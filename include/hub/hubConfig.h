#ifndef RUSH_HUBCONFIG_H
#define RUSH_HUBCONFIG_H

#include <hub/dockCommon.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum CViTalkAnnounceType
{
    CVITALKANNOUNCE_TYPE_UNLOCKED_JET,
    CVITALKANNOUNCE_TYPE_UNLOCKED_BOAT,
    CVITALKANNOUNCE_TYPE_UNLOCKED_HOVER,
    CVITALKANNOUNCE_TYPE_UNLOCKED_SUBMARINE,
    CVITALKANNOUNCE_TYPE_UNLOCKED_DRILL,
    CVITALKANNOUNCE_TYPE_UNUSED5,
    CVITALKANNOUNCE_TYPE_UNUSED6,
    CVITALKANNOUNCE_TYPE_UNUSED7,
    CVITALKANNOUNCE_TYPE_UNUSED8,
    CVITALKANNOUNCE_TYPE_UNUSED9,
    CVITALKANNOUNCE_TYPE_DECOR_1,
    CVITALKANNOUNCE_TYPE_UNUSED11,
    CVITALKANNOUNCE_TYPE_UNLOCKED_RADIO_TOWER,
    CVITALKANNOUNCE_TYPE_DECOR_2,
    CVITALKANNOUNCE_TYPE_UNUSED14,
    CVITALKANNOUNCE_TYPE_UNUSED15,
    CVITALKANNOUNCE_TYPE_UNUSED16,
    CVITALKANNOUNCE_TYPE_UNUSED17,
    CVITALKANNOUNCE_TYPE_UNUSED18,
    CVITALKANNOUNCE_TYPE_UNUSED19,
    CVITALKANNOUNCE_TYPE_UNUSED20,
    CVITALKANNOUNCE_TYPE_UNUSED21,
    CVITALKANNOUNCE_TYPE_DECOR_3,
    CVITALKANNOUNCE_TYPE_UNUSED23,
    CVITALKANNOUNCE_TYPE_UNUSED24,
    CVITALKANNOUNCE_TYPE_UNUSED25,
    CVITALKANNOUNCE_TYPE_UNUSED26,
    CVITALKANNOUNCE_TYPE_UNLOCKED_NEW_MISSION,
    CVITALKANNOUNCE_TYPE_UNLOCKED_MEDAL,
    CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL1,
    CVITALKANNOUNCE_TYPE_UPGRADED_JET_LEVEL2,
    CVITALKANNOUNCE_TYPE_UPGRADED_BOAT_LEVEL1,
    CVITALKANNOUNCE_TYPE_UPGRADED_BOAT_LEVEL2,
    CVITALKANNOUNCE_TYPE_UPGRADED_HOVER_LEVEL1,
    CVITALKANNOUNCE_TYPE_UPGRADED_HOVER_LEVEL2,
    CVITALKANNOUNCE_TYPE_UPGRADED_SUBMARINE_LEVEL1,
    CVITALKANNOUNCE_TYPE_UPGRADED_SUBMARINE_LEVEL2,

    CVITALKANNOUNCE_TYPE_COUNT,
};

enum CViDockNpcType
{
    CVIDOCKNPC_TYPE_BLAZE,
    CVIDOCKNPC_TYPE_TAILS,
    CVIDOCKNPC_TYPE_MARINE,
    CVIDOCKNPC_TYPE_NORMAN,
    CVIDOCKNPC_TYPE_SETTER,
    CVIDOCKNPC_TYPE_TABBY,
    CVIDOCKNPC_TYPE_COLONEL,
    CVIDOCKNPC_TYPE_GARDON,
    CVIDOCKNPC_TYPE_DAIKUN,
    CVIDOCKNPC_TYPE_KYLOK,
    CVIDOCKNPC_TYPE_MUZY,
    CVIDOCKNPC_TYPE_HOURGLASS,
    CVIDOCKNPC_TYPE_OLDDS,
};

enum CViDockNpcSpawnType
{
    CVIDOCK_NPC_BASE_TAILS,
    CVIDOCK_NPC_BASE_MARINE,
    CVIDOCK_NPC_BASE_BLAZE,
    CVIDOCK_NPC_BASE_TABBY,
    CVIDOCK_NPC_BASE_COLONEL,
    CVIDOCK_NPC_BASENEXT_SETTER,
    CVIDOCK_NPC_BASENEXT_COLONEL,
    CVIDOCK_NPC_BASENEXT_HOURGLASS,
    CVIDOCK_NPC_BASENEXT_OLDDS,
    CVIDOCK_NPC_JET_TAILS,
    CVIDOCK_NPC_JET_MARINE,
    CVIDOCK_NPC_JET_TABBY,
    CVIDOCK_NPC_JET_KYLOK,
    CVIDOCK_NPC_BOAT_COLONEL,
    CVIDOCK_NPC_BOAT_GARDON,
    CVIDOCK_NPC_BOAT_NORMAN,
    CVIDOCK_NPC_HOVER_COLONEL,
    CVIDOCK_NPC_HOVER_DAIKUN,
    CVIDOCK_NPC_SUBMARINE_COLONEL,
    CVIDOCK_NPC_SUBMARINE_DAIKUN,
    CVIDOCK_NPC_BEACH_TABBY,
    CVIDOCK_NPC_BEACH_MUZY,

    CVIDOCK_NPC_COUNT,
    CVIDOCK_NPC_INVALID,
};

// --------------------
// STRUCTS
// --------------------

struct CViDockCameraBounds
{
    VecFx32 min;
    VecFx32 max;
};

typedef struct Unknown2171FE8_
{
    s16 field_0;
    s16 field_2;
    DockArea dockArea;
    s32 field_8;
    u32 field_C[3];
    u32 field_18[3];
    u32 field_24[3];
    u32 field_30[3];
    u16 field_3C;
    s16 field_3E;
} Unknown2171FE8;

typedef struct DockStageConfig_
{
    DockArea dockArea;
    MapArea mapArea;
    VecFx32 camOffset;
    fx32 camPosZ;
    u16 camAngle;
    struct CViDockCameraBounds camBounds;
    GXRgb shadowAlpha;
    fx32 playerTopSpeed;
    BOOL camFlag;
    fx16 scale;
} CViDockAreaConfig;

typedef struct DockMapConfig_
{
    DockArea dockArea;
    DockArea unknownArea;
    fx32 shipScale;
    fx32 shipPosY;
    u16 rotationX;
    u16 msgSeqShipCompleted;
    u16 materialCount;
    u16 unknown;
    u16 materials[8];
} CViMapAreaConfig;

typedef struct ViDockBackConfig_
{
    DockArea dockArea;
    u16 resModelShip;
    u16 resJointAnimShip;
    u16 resModelDock;
    u16 resJointAnimDock;
    u16 resTextureAnimDock;
    u16 resPatternAnimDock;
    u16 resDrawState;
    u16 resUnknown;
    fx32 shipPosY;
    u16 dockRotationY;
} CViDockBackAreaConfig;

typedef struct HubNpcTalkActionConfig_
{
    u16 talkActionType;
    u16 talkActionParam;
} HubNpcTalkActionConfig;

typedef struct HubNpcSpawnConfig_
{
    u16 type;
    u16 spawnAngle;
    s16 spawnX;
    s16 spawnZ;
    const HubNpcTalkActionConfig *(*getActionConfig)(void);
} HubNpcSpawnConfig;

typedef struct HubNpcMsgConfig_
{
    u16 msgCtrlFile;
    u16 msgTextID1;
    u16 msgTextID2;
    u16 msgTextID3;
} HubNpcMsgConfig;

typedef struct HubOptionsMsgConfig_
{
    u16 msgCtrlFile;
    u16 msgTextID[7];
} HubOptionsMsgConfig;

typedef struct HubPurchaseCostConfig_
{
    u32 ringCost;
    u8 materialCost[9];
} CViPurchaseCostConfig;

typedef struct HubAnnounceMsgConfig_
{
    u16 mpcFile;
    u16 sequence;
} HubAnnounceMsgConfig;

typedef struct HubPurchaseMsgConfig_
{
    u16 fileID;
    u16 interactionID;
} HubPurchaseMsgConfig;

typedef struct Unknown2171914_
{
    u32 dockArea;
    u32 unknown;
} Unknown2171914;

typedef struct ViMapBackConfig_
{
    u16 flags;
    u16 animID;
} CViMapDecorConfig;

// --------------------
// FUNCTIONS
// --------------------

const Unknown2171FE8 *HubConfig__Func_2152960(u16 area);
const CViDockAreaConfig *HubConfig__GetDockStageConfig(u16 area);
const Unknown2171914 *HubConfig__GetDockUnknownConfig(u16 area);
const CViMapAreaConfig *HubConfig__GetDockMapConfig(u16 area);
const CViMapAreaConfig *HubConfig__GetDockMapUnknownConfig(u16 area);
const CViPurchaseCostConfig *HubConfig__GetShipBuildCost(s32 id);
const CViPurchaseCostConfig *HubConfig__GetRadioTowerPurchaseCost(void);
const CViPurchaseCostConfig *HubConfig__GetDecorPurchaseCost(s32 id);
const CViPurchaseCostConfig *HubConfig__GetShipUpgradeCost(s32 id);
const CViDockBackAreaConfig *HubConfig__GetDockBackInfo(u16 id);
const HubNpcSpawnConfig *HubConfig__GetNpcConfig(u16 id);
const u16 *HubConfig__Func_2152A20(u16 id);
const u16 *HubConfig__Func_2152A30(u16 id);
const u16 *HubConfig__Func_2152A40(u16 id);
const CViMapDecorConfig *HubConfig__GetMapBackConfig(s32 id);
BOOL HubConfig__Func_2152A60(u16 id);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Tails(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Marine(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Blaze(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Setter(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Tabby(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Colonel(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Gardon(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Daikun(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Kylok(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Muzy(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Norman(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Hourglass(void);
const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_OldDS(void);
const HubNpcMsgConfig *HubConfig__GetNpcMsgConfig(s32 id);
const HubPurchaseMsgConfig *HubConfig__GetConstructionPurchaseMsgConfig(s32 id);
const HubPurchaseMsgConfig *HubConfig__GetRadioTowerPurchaseMsgConfig(void);
const HubPurchaseMsgConfig *HubConfig__GetDecorationPurchaseMsgConfig(s32 id);
const HubPurchaseMsgConfig *HubConfig__GetShipUpgradePurchaseMsgConfig(s32 id);
const HubPurchaseMsgConfig *HubConfig__GetInfoPurchaseMsgConfig(void);
const HubAnnounceMsgConfig *HubConfig__GetAnnounceMsgConfig(s32 id);
const HubOptionsMsgConfig *HubConfig__GetOptionsMsgConfig(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBCONFIG_H