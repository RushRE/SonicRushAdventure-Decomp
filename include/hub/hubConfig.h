#ifndef RUSH_HUBCONFIG_H
#define RUSH_HUBCONFIG_H

#include <hub/dockCommon.h>
#include <game/math/mtMath.h>

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
    CVITALKANNOUNCE_TYPE_UNLOCKED_MEDAL,
    CVITALKANNOUNCE_TYPE_UNLOCKED_NEW_MISSION,
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

enum CViMapDecorFlags
{
    CVIMAPDECOR_FLAG_NONE = 0x00,

    CVIMAPDECOR_FLAG_USE_SUB_OBJ = 1 << 0,
    CVIMAPDECOR_FLAG_TRANSPARENT = 1 << 1,
};

enum CViMapDecoration
{
    CVIMAP_DECOR_DOCK_BEACH,
    CVIMAP_DECOR_WATERFALL,
    CVIMAP_DECOR_LIGHTHOUSE,
    CVIMAP_DECOR_LAVA,
    CVIMAP_DECOR_WATCHTOWER,
    CVIMAP_DECOR_STATUE,
    CVIMAP_DECOR_MONUMENT,
    CVIMAP_DECOR_RADIO_TOWER,
    CVIMAP_DECOR_BALLOON,
    CVIMAP_DECOR_WATERFALL_SPLASH,
    CVIMAP_DECOR_PALM_TREE_1,
    CVIMAP_DECOR_PALM_TREE_2,
    CVIMAP_DECOR_PALM_TREE_3,
    CVIMAP_DECOR_SEAGULL,
    CVIMAP_DECOR_VOLCANO_STEAM,
    CVIMAP_DECOR_SMALL_WINDMILL,
    CVIMAP_DECOR_DINOSAUR,
    CVIMAP_DECOR_FLAG,
    CVIMAP_DECOR_LARGE_WINDMILL,
    CVIMAP_DECOR_WHALE,
    CVIMAP_DECOR_FLOWER_GARDEN,
    CVIMAP_DECOR_PRETTY_FLOWER_GARDEN,
    
    CVIMAP_DECOR_COUNT,
    CVIMAP_DECOR_INVALID,
};

enum CViMapBackDecorationBackground
{
    CVIMAPBACK_DECORBG_ISLAND,
    CVIMAPBACK_DECORBG_BASE,
    CVIMAPBACK_DECORBG_DOCK_JET,
    CVIMAPBACK_DECORBG_DOCK_BOAT,
    CVIMAPBACK_DECORBG_DOCK_HOVER,
    CVIMAPBACK_DECORBG_DOCK_SUBMARINE,
    CVIMAPBACK_DECORBG_DOCK_DRILL,
    CVIMAPBACK_DECORBG_DOCK_BEACH,
    CVIMAPBACK_DECORBG_DEC_WATERFALL,
    CVIMAPBACK_DECORBG_DEC_LIGHTHOUSE,
    CVIMAPBACK_DECORBG_DEC_LAVA,
    CVIMAPBACK_DECORBG_DEC_WATCHTOWER,
    CVIMAPBACK_DECORBG_DEC_STATUE,
    CVIMAPBACK_DECORBG_DEC_MONUMENT,
    
    CVIMAPBACK_DECORBG_COUNT,
};

enum CViMapBackDecorationSprite
{
    CVIMAPBACK_DECORSPRITE_RADIO_TOWER,
    CVIMAPBACK_DECORSPRITE_BALLOON,
    CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH,
    CVIMAPBACK_DECORSPRITE_PALM_TREE_1,
    CVIMAPBACK_DECORSPRITE_PALM_TREE_2,
    CVIMAPBACK_DECORSPRITE_PALM_TREE_3,
    CVIMAPBACK_DECORSPRITE_SEAGULL,
    CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM,
    CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL,
    CVIMAPBACK_DECORSPRITE_DINOSAUR,
    CVIMAPBACK_DECORSPRITE_FLAG,
    CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL,
    CVIMAPBACK_DECORSPRITE_WHALE,
    CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN,
    CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN,
    
    CVIMAPBACK_DECORSPRITE_COUNT,
};

enum CViMapBackDecorationAnim
{
    CVIMAPBACK_DECORSPRITE_ANIM_RADIO_TOWER,
    CVIMAPBACK_DECORSPRITE_ANIM_BALLOON,
    CVIMAPBACK_DECORSPRITE_ANIM_WATERFALL_SPLASH,
    CVIMAPBACK_DECORSPRITE_ANIM_PALM_TREE,
    CVIMAPBACK_DECORSPRITE_ANIM_SEAGULL,
    CVIMAPBACK_DECORSPRITE_ANIM_VOLCANO_STEAM,
    CVIMAPBACK_DECORSPRITE_ANIM_SMALL_WINDMILL,
    CVIMAPBACK_DECORSPRITE_ANIM_DINOSAUR,
    CVIMAPBACK_DECORSPRITE_ANIM_FLAG,
    CVIMAPBACK_DECORSPRITE_ANIM_LARGE_WINDMILL,
    CVIMAPBACK_DECORSPRITE_ANIM_WHALE,
    CVIMAPBACK_DECORSPRITE_ANIM_FLOWER_GARDEN,
    CVIMAPBACK_DECORSPRITE_ANIM_PRETTY_FLOWER_GARDEN,
    
    CVIMAPBACK_DECORSPRITE_ANIM_COUNT,
};

enum CViMapDecorAnimID
{
    CVIMAPDECOR_ANI_RADIO_TOWER,
    CVIMAPDECOR_ANI_BALLOON,
    CVIMAPDECOR_ANI_WATERFALL_SPLASH,
    CVIMAPDECOR_ANI_PALM_TREE,
    CVIMAPDECOR_ANI_SEAGULL_GLIDE,
    CVIMAPDECOR_ANI_SEAGULL_FLY,
    CVIMAPDECOR_ANI_SEAGULL_TURN,
    CVIMAPDECOR_ANI_VOLCANO_STEAM,
    CVIMAPDECOR_ANI_SMALL_WINDMILL,
    CVIMAPDECOR_ANI_DINOSAUR,
    CVIMAPDECOR_ANI_FLAG,
    CVIMAPDECOR_ANI_LARGE_WINDMILL,
    CVIMAPDECOR_ANI_WHALE,
    CVIMAPDECOR_ANI_FLOWER_GARDEN,
    CVIMAPDECOR_ANI_PRETTY_FLOWER_GARDEN,
};

// --------------------
// STRUCTS
// --------------------

struct CViDockCameraBounds
{
    VecFx32 min;
    VecFx32 max;
};

typedef struct CViMapAreaIconConfig_
{
    Vec2U16 position;
    DockArea dockArea;
    DockArea previewDockArea;
    u32 nextArea_Left[3];
    u32 nextArea_Up[3];
    u32 nextArea_Right[3];
    u32 nextArea_Down[3];
    u16 dockImageID;
} CViMapAreaIconConfig;

typedef struct CViDockAreaConfig_
{
    DockArea dockArea;
    MapArea mapArea;
    VecFx32 camOffset;
    fx32 camPosZ;
    u16 camAngle;
    struct CViDockCameraBounds camBounds;
    GXRgb shadowAlpha;
    fx32 playerTopSpeed;
    BOOL allowTalkNpcCameraMove;
    fx16 scale;
} CViDockAreaConfig;

typedef struct CViMapAreaConfig_
{
    DockArea dockArea;
    MapArea mapArea;
    fx32 shipScale;
    fx32 shipPosY;
    u16 rotationX;
    u16 msgSeqShipCompleted;
    u16 materialCount;
    u16 unknown;
    u16 materials[8];
} CViMapAreaConfig;

typedef struct CViDockBackAreaConfig_
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
} CViDockPreviewConfig;

typedef struct CViMapBackDecorConfig_
{
    u16 flags;
    u16 animID;
} CViMapBackDecorConfig;

// --------------------
// FUNCTIONS
// --------------------

const CViMapAreaIconConfig *HubConfig__GetDockMapIconConfig(u16 area);
const CViDockAreaConfig *HubConfig__GetDockStageConfig(u16 area);
const CViDockPreviewConfig *HubConfig__GetDockPreviewConfig(u16 area);
const CViMapAreaConfig *HubConfig__GetDockMapConfig(u16 area);
const CViMapAreaConfig *HubConfig__GetDockMapUnknownConfig(u16 area);
const CViPurchaseCostConfig *HubConfig__GetShipBuildCost(s32 id);
const CViPurchaseCostConfig *HubConfig__GetRadioTowerPurchaseCost(void);
const CViPurchaseCostConfig *HubConfig__GetDecorPurchaseCost(s32 id);
const CViPurchaseCostConfig *HubConfig__GetShipUpgradeCost(s32 id);
const CViDockBackAreaConfig *HubConfig__GetDockBackInfo(u16 id);
const HubNpcSpawnConfig *HubConfig__GetNpcConfig(u16 id);
const u16 *HubConfig__GetMapBackDecorID(u16 id);
const u16 *HubConfig__GetMapBackDecorBackgroundConfig(u16 id);
const u16 *HubConfig__GetMapBackDecorSpriteAnimator(u16 id);
const CViMapBackDecorConfig *HubConfig__GetMapBackDecorSpriteConfig(u16 id);
BOOL HubConfig__CheckDecorConstructionIsBackground(u16 id);
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