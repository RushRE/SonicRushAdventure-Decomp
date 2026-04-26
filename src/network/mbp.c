#include <game/network/mbp.h>

// --------------------
// MACROS
// --------------------

#define STRINGIFY(symbol) #symbol

// --------------------
// CONSTANTS
// --------------------

#define MBP_BIT_CHILD_START 1
#define MBP_CHILD_MAX       (16 - 1)

#define MBP_DMA_NO 2

#define MBP_BITFIELD_NONE 0x0000

// --------------------
// STRUCTS
// --------------------

struct MBPState
{
    MBPState state;
    u16 connectChildBmp;
    u16 requestChildBmp;
    u16 entryChildBmp;
    u16 downloadChildBmp;
    u16 bootableChildBmp;
    u16 rebootChildBmp;
};

// --------------------
// VARIABLES
// --------------------

void *(*gMBPAllocFunc)(size_t size) = NULL;
static u32 *sCWork                  = NULL;
void (*gMBPFreeFunc)(void *ptr)     = NULL;
static u8 *sFilebuf                 = NULL;

struct MBPState sMbpState;
static MBPChildInfo sChildInfo[MBP_CHILD_MAX];

// When matching, manually force the strings to appear in the desired order
#ifndef NON_MATCHING
static const char *_MATCHING_FIX_2_0  = STRINGIFY(MB_COMM_PSTATE_NONE);
static const char *_MATCHING_FIX_2_1  = STRINGIFY(MB_COMM_PSTATE_INIT_COMPLETE);
static const char *_MATCHING_FIX_2_2  = STRINGIFY(MB_COMM_PSTATE_CONNECTED);
static const char *_MATCHING_FIX_2_5  = STRINGIFY(MB_COMM_PSTATE_REQ_ACCEPTED);
static const char *_MATCHING_FIX_1_3  = STRINGIFY(MBP_STATE_DATASENDING);
static const char *_MATCHING_FIX_2_6  = STRINGIFY(MB_COMM_PSTATE_SEND_PROCEED);
static const char *_MATCHING_FIX_2_8  = STRINGIFY(MB_COMM_PSTATE_BOOT_REQUEST);
static const char *_MATCHING_FIX_2_7  = STRINGIFY(MB_COMM_PSTATE_SEND_COMPLETE);
static const char *_MATCHING_FIX_2_14 = STRINGIFY(MB_COMM_PSTATE_WAIT_TO_SEND);
static const char *_MATCHING_FIX_2_9  = STRINGIFY(MB_COMM_PSTATE_BOOT_STARTABLE);
static const char *_MATCHING_FIX_2_10 = STRINGIFY(MB_COMM_PSTATE_REQUESTED);
static const char *_MATCHING_FIX_2_11 = STRINGIFY(MB_COMM_PSTATE_MEMBER_FULL);
static const char *_MATCHING_FIX_1_5  = STRINGIFY(MBP_STATE_COMPLETE);
static const char *_MATCHING_FIX_2_13 = STRINGIFY(MB_COMM_PSTATE_ERROR);
static const char *_MATCHING_FIX_2_3  = STRINGIFY(MB_COMM_PSTATE_DISCONNECTED);

static const char *_MATCHING_FIX_1_1  = STRINGIFY(MBP_STATE_IDLE);
static const char *_MATCHING_FIX_1_0  = STRINGIFY(MBP_STATE_STOP);
static const char *_MATCHING_FIX_1_7  = STRINGIFY(MBP_STATE_ERROR);
static const char *_MATCHING_FIX_2_4  = STRINGIFY(MB_COMM_PSTATE_KICKED);
static const char *_MATCHING_FIX_1_4  = STRINGIFY(MBP_STATE_REBOOTING);
static const char *_MATCHING_FIX_2_12 = STRINGIFY(MB_COMM_PSTATE_END);
static const char *_MATCHING_FIX_1_6  = STRINGIFY(MBP_STATE_CANCEL);
static const char *_MATCHING_FIX_1_2  = STRINGIFY(MBP_STATE_ENTRY);
#endif

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

static BOOL MBP_RegistFile(const MBGameRegistry *gameInfo);
static void MBPi_CheckAllReboot(void);
static void ParentStateCallback(u16 childAID, u32 status, void *arg);
static MBPChildState MBP_GetChildState(u16 aid);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void MBP_AddBitmap(u16 *pBitmap, u16 aid)
{
    OSIntrMode enabled = OS_DisableInterrupts();
    *pBitmap |= (1 << aid);
    OS_RestoreInterrupts(enabled);
}

RUSH_INLINE void MBP_RemoveBitmap(u16 *pBitmap, u16 aid)
{
    OSIntrMode enabled = OS_DisableInterrupts();
    *pBitmap &= ~(1 << aid);
    OS_RestoreInterrupts(enabled);
}

RUSH_INLINE void MBP_DisconnectChildFromBmp(u16 aid)
{
    u16 aidMask = ~(1 << aid);

    OSIntrMode enabled = OS_DisableInterrupts();

    sMbpState.connectChildBmp &= aidMask;
    sMbpState.requestChildBmp &= aidMask;
    sMbpState.entryChildBmp &= aidMask;
    sMbpState.downloadChildBmp &= aidMask;
    sMbpState.bootableChildBmp &= aidMask;
    sMbpState.rebootChildBmp &= aidMask;

    OS_RestoreInterrupts(enabled);
}

RUSH_INLINE void MBP_DisconnectChild(u16 aid)
{
    MBP_DisconnectChildFromBmp(aid);
    MB_DisconnectChild(aid);
}

// --------------------
// FUNCTIONS
// --------------------

void MBP_Init(u32 ggid, u16 tgid)
{
    MBUserInfo myUser;

    OSOwnerInfo ownerInfo;
    OS_GetOwnerInfo(&ownerInfo);
    myUser.favoriteColor = ownerInfo.favoriteColor;
    myUser.nameLength    = ownerInfo.nickNameLength;
    MI_CpuCopy8(ownerInfo.nickName, myUser.name, ownerInfo.nickNameLength * sizeof(char16));

    myUser.playerNo = 0;

    sMbpState = (struct MBPState){
        .state            = MBP_STATE_STOP,    // Initialize struct
        .connectChildBmp  = MBP_BITFIELD_NONE, // Initialize struct
        .requestChildBmp  = MBP_BITFIELD_NONE, // Initialize struct
        .entryChildBmp    = MBP_BITFIELD_NONE, // Initialize struct
        .downloadChildBmp = MBP_BITFIELD_NONE, // Initialize struct
        .bootableChildBmp = MBP_BITFIELD_NONE, // Initialize struct
        .rebootChildBmp   = MBP_BITFIELD_NONE  // Initialize struct
    };

    sCWork = gMBPAllocFunc(MB_SYSTEM_BUF_SIZE);

    if (MB_Init(sCWork, &myUser, ggid, tgid, MBP_DMA_NO) != MB_SUCCESS)
        OS_Terminate();

    MB_SetParentCommParam(MB_COMM_PARENT_SEND_MIN, MBP_CHILD_MAX);
    MB_CommSetParentStateCallback(ParentStateCallback);

    MBP_ChangeState(MBP_STATE_IDLE);
}

void MBP_Start(const MBGameRegistry *gameInfo, u16 channel)
{
    MBP_ChangeState(MBP_STATE_ENTRY);

    if (MB_StartParent(channel) != MB_SUCCESS)
    {
        MBP_ChangeState(MBP_STATE_ERROR);
        return;
    }

    if (MBP_RegistFile(gameInfo) == FALSE)
        OS_Terminate();
}

BOOL MBP_RegistFile(const MBGameRegistry *gameInfo)
{
    FSFile file;
    FSFile *filePtr;
    u32 bufferSize;
    BOOL success = FALSE;

    if (gameInfo->romFilePathp == NULL)
    {
        filePtr = NULL;
    }
    else
    {
        FS_InitFile(&file);
        if (FS_OpenFile(&file, gameInfo->romFilePathp) == FALSE)
            return FALSE;

        filePtr = &file;
    }

    bufferSize = MB_GetSegmentLength(filePtr);
    if (bufferSize != 0)
    {
        sFilebuf = gMBPAllocFunc(bufferSize);
        if (sFilebuf != NULL)
        {
            if (MB_ReadSegment(filePtr, sFilebuf, bufferSize))
            {
                if (MB_RegisterFile(gameInfo, sFilebuf))
                    success = TRUE;
            }

            if (success == FALSE)
                gMBPFreeFunc(sFilebuf);
        }
    }

    if (filePtr == &file)
        FS_CloseFile(&file);

    return success;
}

void MBP_AcceptChild(u16 childAID)
{
    if (MB_CommResponseRequest(childAID, MB_COMM_RESPONSE_REQUEST_ACCEPT) == FALSE)
    {
        MBP_DisconnectChild(childAID);
        return;
    }
}

void MBP_KickChild(u16 childAID)
{
    if (MB_CommResponseRequest(childAID, MB_COMM_RESPONSE_REQUEST_KICK) == FALSE)
    {
        MBP_DisconnectChild(childAID);
        return;
    }

    OSIntrMode enabled = OS_DisableInterrupts();

    sMbpState.requestChildBmp &= ~(1 << childAID);
    sMbpState.connectChildBmp &= ~(1 << childAID);

    OS_RestoreInterrupts(enabled);
}

void MBP_StartDownload(u16 childAID)
{
    if (MB_CommStartSending(childAID) == FALSE)
    {
        MBP_DisconnectChild(childAID);
        return;
    }

    OSIntrMode enabled = OS_DisableInterrupts();

    sMbpState.entryChildBmp &= ~(1 << childAID);
    sMbpState.downloadChildBmp |= (1 << childAID);

    OS_RestoreInterrupts(enabled);
}

void MBP_StartDownloadAll(void)
{
    u16 i;

    MBP_ChangeState(MBP_STATE_DATASENDING);

    for (i = MBP_BIT_CHILD_START; i < (MBP_BIT_CHILD_START + MBP_CHILD_MAX); i++)
    {
        if ((sMbpState.connectChildBmp & (1 << i)) == MBP_BITFIELD_NONE)
            continue;

        if (MBP_GetChildState(i) == MBP_CHILDSTATE_CONNECTING)
            MBP_DisconnectChild(i);
    }
}

BOOL MBP_IsBootableAll(void)
{
    u16 i;

    if (sMbpState.connectChildBmp == 0)
        return FALSE;

    for (i = MBP_BIT_CHILD_START; i < (MBP_BIT_CHILD_START + MBP_CHILD_MAX); i++)
    {
        if ((sMbpState.connectChildBmp & (1 << i)) == MBP_BITFIELD_NONE)
            continue;

        if (MB_CommIsBootable(i) == FALSE)
        {
            return FALSE;
        }
    }

    return TRUE;
}

void MBP_StartRebootAll(void)
{
    u16 i;
    u16 sentChild = MBP_BITFIELD_NONE;

    for (i = MBP_BIT_CHILD_START; i < (MBP_BIT_CHILD_START + MBP_CHILD_MAX); i++)
    {
        if ((sMbpState.bootableChildBmp & (1 << i)) == MBP_BITFIELD_NONE)
            continue;

        if (MB_CommBootRequest(i) == FALSE)
        {
            MBP_DisconnectChild(i);
            continue;
        }

        sentChild |= (1 << i);
    }

    if (sentChild == MBP_BITFIELD_NONE)
    {
        MBP_ChangeState(MBP_STATE_ERROR);
        return;
    }

    MBP_ChangeState(MBP_STATE_REBOOTING);
}

void MBP_Cancel(void)
{
    MBP_ChangeState(MBP_STATE_CANCEL);
    MB_End();
}

void MBPi_CheckAllReboot(void)
{
    if ((sMbpState.state == MBP_STATE_REBOOTING) && (sMbpState.connectChildBmp == sMbpState.rebootChildBmp))
        MB_End();
}

void ParentStateCallback(u16 childAID, u32 status, void *arg)
{
    // The assumption here is that this would've been used to debug which state is active
    static const char *sStateNameList[MB_COMM_PSTATE_COUNT] = {
        [MB_COMM_PSTATE_NONE]           = STRINGIFY(MB_COMM_PSTATE_NONE),
        [MB_COMM_PSTATE_INIT_COMPLETE]  = STRINGIFY(MB_COMM_PSTATE_INIT_COMPLETE),
        [MB_COMM_PSTATE_CONNECTED]      = STRINGIFY(MB_COMM_PSTATE_CONNECTED),
        [MB_COMM_PSTATE_DISCONNECTED]   = STRINGIFY(MB_COMM_PSTATE_DISCONNECTED),
        [MB_COMM_PSTATE_KICKED]         = STRINGIFY(MB_COMM_PSTATE_KICKED),
        [MB_COMM_PSTATE_REQ_ACCEPTED]   = STRINGIFY(MB_COMM_PSTATE_REQ_ACCEPTED),
        [MB_COMM_PSTATE_SEND_PROCEED]   = STRINGIFY(MB_COMM_PSTATE_SEND_PROCEED),
        [MB_COMM_PSTATE_SEND_COMPLETE]  = STRINGIFY(MB_COMM_PSTATE_SEND_COMPLETE),
        [MB_COMM_PSTATE_BOOT_REQUEST]   = STRINGIFY(MB_COMM_PSTATE_BOOT_REQUEST),
        [MB_COMM_PSTATE_BOOT_STARTABLE] = STRINGIFY(MB_COMM_PSTATE_BOOT_STARTABLE),
        [MB_COMM_PSTATE_REQUESTED]      = STRINGIFY(MB_COMM_PSTATE_REQUESTED),
        [MB_COMM_PSTATE_MEMBER_FULL]    = STRINGIFY(MB_COMM_PSTATE_MEMBER_FULL),
        [MB_COMM_PSTATE_END]            = STRINGIFY(MB_COMM_PSTATE_END),
        [MB_COMM_PSTATE_ERROR]          = STRINGIFY(MB_COMM_PSTATE_ERROR),
        [MB_COMM_PSTATE_WAIT_TO_SEND]   = STRINGIFY(MB_COMM_PSTATE_WAIT_TO_SEND),
    };

    switch (status)
    {
        case MB_COMM_PSTATE_INIT_COMPLETE:
            break;

        case MB_COMM_PSTATE_CONNECTED:
            if (MBP_GetState() != MBP_STATE_ENTRY)
                break;

            MBP_AddBitmap(&sMbpState.connectChildBmp, childAID);
            WM_CopyBssid(((WMStartParentCallback *)arg)->macAddress, sChildInfo[childAID - 1].macAddress);

            sChildInfo[childAID - 1].playerNo = childAID;
            break;

        case MB_COMM_PSTATE_DISCONNECTED:
            if (MBP_GetChildState(childAID) != MBP_CHILDSTATE_REBOOT)
            {
                MBP_DisconnectChildFromBmp(childAID);
                MBPi_CheckAllReboot();
            }
            break;

        case MB_COMM_PSTATE_REQUESTED: {
            const MBUserInfo *userInfo;

            userInfo = (MBUserInfo *)arg;

            if (MBP_GetState() != MBP_STATE_ENTRY)
            {
                MBP_KickChild(childAID);
                break;
            }

            sMbpState.requestChildBmp |= 1 << childAID;

            MBP_AcceptChild(childAID);

            userInfo = MB_CommGetChildUser(childAID);
            if (userInfo != NULL)
                MI_CpuCopy8(userInfo, &sChildInfo[childAID - MBP_BIT_CHILD_START].user, sizeof(*userInfo));
        }
        break;

        case MB_COMM_PSTATE_REQ_ACCEPTED:
            break;

        case MB_COMM_PSTATE_WAIT_TO_SEND:
            sMbpState.requestChildBmp &= ~(1 << childAID);
            sMbpState.entryChildBmp |= 1 << childAID;

            MBP_StartDownload(childAID);
            break;

        case MB_COMM_PSTATE_KICKED:
            break;

        case MB_COMM_PSTATE_SEND_PROCEED:
            break;

        case MB_COMM_PSTATE_SEND_COMPLETE:
            sMbpState.downloadChildBmp &= ~(1 << childAID);
            sMbpState.bootableChildBmp |= 1 << childAID;
            break;

        case MB_COMM_PSTATE_BOOT_STARTABLE:
            sMbpState.bootableChildBmp &= ~(1 << childAID);
            sMbpState.rebootChildBmp |= 1 << childAID;

            MBPi_CheckAllReboot();
            break;

        case MB_COMM_PSTATE_BOOT_REQUEST:
            break;

        case MB_COMM_PSTATE_MEMBER_FULL:
            break;

        case MB_COMM_PSTATE_END:
            if (MBP_GetState() == MBP_STATE_REBOOTING)
                MBP_ChangeState(MBP_STATE_COMPLETE);
            else
                MBP_ChangeState(MBP_STATE_STOP);

            if (sFilebuf != NULL)
            {
                gMBPFreeFunc(sFilebuf);
                sFilebuf = NULL;
            }

            if (sCWork != NULL)
            {
                gMBPFreeFunc(sCWork);
                sCWork = NULL;
            }
            break;

        case MB_COMM_PSTATE_ERROR:
            MBErrorStatus *cb = (MBErrorStatus *)arg;

            switch (cb->errcode)
            {
                case MB_ERRCODE_WM_FAILURE:
                    break;

                case MB_ERRCODE_INVALID_PARAM:
                case MB_ERRCODE_INVALID_STATE:
                case MB_ERRCODE_FATAL:
                    MBP_ChangeState(MBP_STATE_ERROR);
                    break;
            }
            break;

        default:
            OS_Terminate();
            break;
    }
}

void MBP_ChangeState(MBPState state)
{
    // The assumption here is that this would've been used to debug which state is active
    static const char *sStateNameList[MBP_STATE_COUNT] = {
        [MBP_STATE_STOP]        = STRINGIFY(MBP_STATE_STOP),        // Formatting Comment
        [MBP_STATE_IDLE]        = STRINGIFY(MBP_STATE_IDLE),        // Formatting Comment
        [MBP_STATE_ENTRY]       = STRINGIFY(MBP_STATE_ENTRY),       // Formatting Comment
        [MBP_STATE_DATASENDING] = STRINGIFY(MBP_STATE_DATASENDING), // Formatting Comment
        [MBP_STATE_REBOOTING]   = STRINGIFY(MBP_STATE_REBOOTING),   // Formatting Comment
        [MBP_STATE_COMPLETE]    = STRINGIFY(MBP_STATE_COMPLETE),    // Formatting Comment
        [MBP_STATE_CANCEL]      = STRINGIFY(MBP_STATE_CANCEL),      // Formatting Comment
        [MBP_STATE_ERROR]       = STRINGIFY(MBP_STATE_ERROR)        // Formatting Comment
    };

    sMbpState.state = state;
}

MBPState MBP_GetState(void)
{
    return sMbpState.state;
}

u16 MBP_GetChildBmp(MBPBmpType bmpType)
{
    static const u16 *sBitmapList[MBP_BMPTYPE_COUNT] = {
        [MBP_BMPTYPE_CONNECT]     = &sMbpState.connectChildBmp,  // Formatting Comment
        [MBP_BMPTYPE_REQUEST]     = &sMbpState.requestChildBmp,  // Formatting Comment
        [MBP_BMPTYPE_ENTRY]       = &sMbpState.entryChildBmp,    // Formatting Comment
        [MBP_BMPTYPE_DOWNLOADING] = &sMbpState.downloadChildBmp, // Formatting Comment
        [MBP_BMPTYPE_BOOTABLE]    = &sMbpState.bootableChildBmp, // Formatting Comment
        [MBP_BMPTYPE_REBOOT]      = &sMbpState.rebootChildBmp,   // Formatting Comment
    };

    return *sBitmapList[bmpType];
}

MBPChildState MBP_GetChildState(u16 aid)
{
    struct MBPState tmpState;
    u16 bitmap = (u16)(1 << aid);

    OSIntrMode enabled = OS_DisableInterrupts();
    if ((sMbpState.connectChildBmp & bitmap) == MBP_BITFIELD_NONE)
    {
        OS_RestoreInterrupts(enabled);
        return MBP_CHILDSTATE_NONE;
    }

    MI_CpuCopy8(&sMbpState, &tmpState, sizeof(tmpState));
    OS_RestoreInterrupts(enabled);

    if ((tmpState.requestChildBmp & bitmap) != MBP_BITFIELD_NONE)
        return MBP_CHILDSTATE_REQUEST;

    if ((tmpState.entryChildBmp & bitmap) != MBP_BITFIELD_NONE)
        return MBP_CHILDSTATE_ENTRY;

    if ((tmpState.downloadChildBmp & bitmap) != MBP_BITFIELD_NONE)
        return MBP_CHILDSTATE_DOWNLOADING;

    if ((tmpState.bootableChildBmp & bitmap) != MBP_BITFIELD_NONE)
        return MBP_CHILDSTATE_BOOTABLE;

    if ((tmpState.rebootChildBmp & bitmap) != MBP_BITFIELD_NONE)
        return MBP_CHILDSTATE_REBOOT;

    return MBP_CHILDSTATE_CONNECTING;
}

const MBPChildInfo *MBP_GetChildInfo(u16 childAID)
{
    if ((sMbpState.connectChildBmp & (1 << childAID)) == MBP_BITFIELD_NONE)
        return NULL;

    return &sChildInfo[childAID - MBP_BIT_CHILD_START];
}