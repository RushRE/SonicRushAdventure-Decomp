#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <hub/cviEvtCmn.hpp>
#include <hub/cviDockNpcTalk.hpp>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/bb/vi_dock.h>

// --------------------
// VARIABLES
// --------------------

static const HubNpcTalkActionConfig npcTalkActionOldDS     = { .talkActionType = CVIDOCKNPCTALK_ACTION, .talkActionParam = CVIDOCKNPCTALK_ACTION_15 };
static const HubNpcTalkActionConfig npcTalkActionCommon    = { .talkActionType = CVIDOCKNPCTALK_NPC, .talkActionParam = 0 };
static const HubNpcTalkActionConfig npcTalkActionHourglass = { .talkActionType = CVIDOCKNPCTALK_ACTION, .talkActionParam = CVIDOCKNPCTALK_ACTION_16 };

static const CViPurchaseCostConfig radioTowerCost[] =
{
    {
        .ringCost = 1000,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 5,
            [SAVE_MATERIAL_BRONZE] = 5,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    }
};

static const u16 ovl05_02171848[] = { 0, 1, 4, 3, 5, 2, 10, 6, 7, 8, 9, 11, 12, 13 };
static const u16 ovl05_02171864[] = { 0, 1, 2, 3, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
static const u16 ovl05_02171882[] = { 7, 8, 9, 10, 11, 12, 13, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0 };

static const CViPurchaseCostConfig decorPurchaseCost[] =
{
    {
        .ringCost = 600,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0
        },
    },

    {
        .ringCost = 800,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },

    {
        .ringCost = 1200,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },
};

static const CViMapDecorConfig mapDecorGraphicsConfig[] = {
    { .flags = 0, .animID = 0 },  { .flags = 0, .animID = 1 },  { .flags = 0, .animID = 2 },  { .flags = 0, .animID = 3 },  { .flags = 0, .animID = 4 },
    { .flags = 2, .animID = 7 },  { .flags = 0, .animID = 8 },  { .flags = 0, .animID = 9 },  { .flags = 0, .animID = 10 }, { .flags = 1, .animID = 11 },
    { .flags = 1, .animID = 12 }, { .flags = 1, .animID = 13 }, { .flags = 1, .animID = 14 },
};

static const Unknown2171914 dockUnknownConfig[] = {
    { .dockArea = DOCKAREA_BASE, .unknown = 0 },  { .dockArea = DOCKAREA_JET, .unknown = 2 },       { .dockArea = DOCKAREA_BOAT, .unknown = 3 },
    { .dockArea = DOCKAREA_HOVER, .unknown = 4 }, { .dockArea = DOCKAREA_SUBMARINE, .unknown = 5 }, { .dockArea = DOCKAREA_BEACH, .unknown = 6 },
    { .dockArea = DOCKAREA_DRILL, .unknown = 8 },
};

static const CViPurchaseCostConfig shipBuildCost[] =
{
    [SHIP_JET] = 
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 1,
            [SAVE_MATERIAL_IRON] = 1,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },

    [SHIP_BOAT] = 
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 5,
            [SAVE_MATERIAL_BRONZE] = 5,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },

    [SHIP_HOVER] = 
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 1,
            [SAVE_MATERIAL_IRON] = 1,
            [SAVE_MATERIAL_GREEN] = 2,
            [SAVE_MATERIAL_BRONZE] = 2,
            [SAVE_MATERIAL_RED] = 5,
            [SAVE_MATERIAL_SILVER] = 5,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },

    [SHIP_SUBMARINE] = 
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 1,
            [SAVE_MATERIAL_IRON] = 1,
            [SAVE_MATERIAL_GREEN] = 1,
            [SAVE_MATERIAL_BRONZE] = 1,
            [SAVE_MATERIAL_RED] = 2,
            [SAVE_MATERIAL_SILVER] = 2,
            [SAVE_MATERIAL_AQUA] = 5,
            [SAVE_MATERIAL_GOLD] = 5,
            [SAVE_MATERIAL_BLACK] = 0,
        },
    },

    // This goes unused.
    // The magma hurricane does not need to be built manually in the final game.
    [SHIP_DRILL] = 
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 1,
        },
    },
};

static const CViPurchaseCostConfig shipUpgradeCost[] =
{
    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 3,
            [SAVE_MATERIAL_IRON] = 3,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 3,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 5,
            [SAVE_MATERIAL_IRON] = 5,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 5,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 3,
            [SAVE_MATERIAL_BRONZE] = 3,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 3,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 5,
            [SAVE_MATERIAL_BRONZE] = 5,
            [SAVE_MATERIAL_RED] = 0,
            [SAVE_MATERIAL_SILVER] = 0,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 5,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 3,
            [SAVE_MATERIAL_BRONZE] = 3,
            [SAVE_MATERIAL_RED] = 3,
            [SAVE_MATERIAL_SILVER] = 3,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 3,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 5,
            [SAVE_MATERIAL_BRONZE] = 5,
            [SAVE_MATERIAL_RED] = 5,
            [SAVE_MATERIAL_SILVER] = 5,
            [SAVE_MATERIAL_AQUA] = 0,
            [SAVE_MATERIAL_GOLD] = 0,
            [SAVE_MATERIAL_BLACK] = 5,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 3,
            [SAVE_MATERIAL_SILVER] = 3,
            [SAVE_MATERIAL_AQUA] = 3,
            [SAVE_MATERIAL_GOLD] = 3,
            [SAVE_MATERIAL_BLACK] = 3,
        },
    },

    {
        .ringCost = 0,
        .materialCost = {
            [SAVE_MATERIAL_BLUE] = 0,
            [SAVE_MATERIAL_IRON] = 0,
            [SAVE_MATERIAL_GREEN] = 0,
            [SAVE_MATERIAL_BRONZE] = 0,
            [SAVE_MATERIAL_RED] = 5,
            [SAVE_MATERIAL_SILVER] = 5,
            [SAVE_MATERIAL_AQUA] = 5,
            [SAVE_MATERIAL_GOLD] = 5,
            [SAVE_MATERIAL_BLACK] = 5,
        },
    },
};

static const CViMapAreaConfig mapAreaConfig[] = {
    [SHIP_JET] = 
    {
        .dockArea            = DOCKAREA_JET,
        .unknownArea         = DOCKAREA_BASE_NEXT,
        .shipScale           = FLOAT_TO_FX32(3.0),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(10.0),
        .msgSeqShipCompleted = 0,
        .materialCount       = 2,
        .unknown             = 0,
        .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, 0, 0, 0, 0, 0, 0 },
    },

    [SHIP_BOAT] = 
    {
        .dockArea            = DOCKAREA_BOAT,
        .unknownArea         = DOCKAREA_JET,
        .shipScale           = FLOAT_TO_FX32(0.5),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(20.0),
        .msgSeqShipCompleted = 1,
        .materialCount       = 2,
        .unknown             = 0,
        .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, 0, 0, 0, 0, 0, 0 },
    },

    [SHIP_HOVER] = 
    {
        .dockArea            = DOCKAREA_HOVER,
        .unknownArea         = DOCKAREA_BOAT,
        .shipScale           = FLOAT_TO_FX32(0.5),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(20.0),
        .msgSeqShipCompleted = 2,
        .materialCount       = 6,
        .unknown             = 0,
        .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, 0, 0 },
    },

    [SHIP_SUBMARINE] = 
    {
        .dockArea            = DOCKAREA_SUBMARINE,
        .unknownArea         = DOCKAREA_HOVER,
        .shipScale           = FLOAT_TO_FX32(0.5),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(20.0),
        .msgSeqShipCompleted = 3,
        .materialCount       = 8,
        .unknown             = 0,
        .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD },
    },

    // unused in the final game. The magma hurricane cannot be built, and thus this config isn't needed
    [SHIP_DRILL] = 
    {
        .dockArea            = DOCKAREA_DRILL,
        .unknownArea         = DOCKAREA_BEACH,
        .shipScale           = FLOAT_TO_FX32(0.5),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(20.0),
        .msgSeqShipCompleted = 4,
        .materialCount       = 1,
        .unknown             = 0,
        .materials           = { SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0, 0, 0 },
    },
};

static const CViDockBackAreaConfig dockBackAreaConfig[] = {
    { .dockArea           = DOCKAREA_BASE,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SON_BASE_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SON_BASE_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(4.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(0.0) },

    { .dockArea           = DOCKAREA_BASE_NEXT,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_DOCK_BASE_NEXT_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_DOCK_BASE_NEXT_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(4.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(0.0) },

    { .dockArea           = DOCKAREA_JET,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(4.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(270.0) },

    { .dockArea           = DOCKAREA_BOAT,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(10.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(270.0) },

    { .dockArea           = DOCKAREA_HOVER,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = FLOAT_TO_FX32(0.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(270.0) },

    { .dockArea           = DOCKAREA_SUBMARINE,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = FLOAT_TO_FX32(0.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(270.0) },

    { .dockArea           = DOCKAREA_BEACH,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBMD,
      .resJointAnimDock   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBCA,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBTP,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(4.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(0.0) },

    { .dockArea           = DOCKAREA_NONE,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_NSBMD,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resDrawState       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_DOCK_BSD,
      .resUnknown         = CVIEVTCMN_RESOURCE_NONE,
      .shipPosY           = -FLOAT_TO_FX32(10.0),
      .dockRotationY      = FLOAT_DEG_TO_IDX(0.0) },
};

static const HubNpcSpawnConfig npcSpawnConfig[CVIDOCK_NPC_COUNT] = {
    [CVIDOCK_NPC_BASE_TAILS] = { .type            = CVIDOCKNPC_TYPE_TAILS,
                                 .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                 .spawnX          = 9,
                                 .spawnZ          = 0,
                                 .getActionConfig = HubConfig__GetNpcActionConfig_Tails },

    [CVIDOCK_NPC_BASE_MARINE] = { .type            = CVIDOCKNPC_TYPE_MARINE,
                                  .spawnAngle      = FLOAT_DEG_TO_IDX(90.0),
                                  .spawnX          = -15,
                                  .spawnZ          = 18,
                                  .getActionConfig = HubConfig__GetNpcActionConfig_Marine },

    [CVIDOCK_NPC_BASE_BLAZE] = { .type            = CVIDOCKNPC_TYPE_BLAZE,
                                 .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                 .spawnX          = -9,
                                 .spawnZ          = 0,
                                 .getActionConfig = HubConfig__GetNpcActionConfig_Blaze },

    [CVIDOCK_NPC_BASE_TABBY] = { .type            = CVIDOCKNPC_TYPE_TABBY,
                                 .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                 .spawnX          = -9,
                                 .spawnZ          = 0,
                                 .getActionConfig = HubConfig__GetNpcActionConfig_Tabby },

    [CVIDOCK_NPC_BASE_COLONEL] = { .type            = CVIDOCKNPC_TYPE_COLONEL,
                                   .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                   .spawnX          = -9,
                                   .spawnZ          = 0,
                                   .getActionConfig = HubConfig__GetNpcActionConfig_Colonel },

    [CVIDOCK_NPC_BASENEXT_SETTER] = { .type            = CVIDOCKNPC_TYPE_SETTER,
                                      .spawnAngle      = FLOAT_DEG_TO_IDX(270.0),
                                      .spawnX          = 11,
                                      .spawnZ          = 8,
                                      .getActionConfig = HubConfig__GetNpcActionConfig_Setter },

    [CVIDOCK_NPC_BASENEXT_COLONEL] = { .type            = CVIDOCKNPC_TYPE_COLONEL,
                                       .spawnAngle      = FLOAT_DEG_TO_IDX(90.0),
                                       .spawnX          = -11,
                                       .spawnZ          = 8,
                                       .getActionConfig = HubConfig__GetNpcActionConfig_Colonel },

    [CVIDOCK_NPC_BASENEXT_HOURGLASS] = { .type            = CVIDOCKNPC_TYPE_HOURGLASS,
                                         .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                         .spawnX          = -7,
                                         .spawnZ          = -11,
                                         .getActionConfig = HubConfig__GetNpcActionConfig_Hourglass },

    [CVIDOCK_NPC_BASENEXT_OLDDS] = { .type            = CVIDOCKNPC_TYPE_OLDDS,
                                     .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                     .spawnX          = 7,
                                     .spawnZ          = -11,
                                     .getActionConfig = HubConfig__GetNpcActionConfig_OldDS },

    [CVIDOCK_NPC_JET_TAILS] = { .type            = CVIDOCKNPC_TYPE_TAILS,
                                .spawnAngle      = FLOAT_DEG_TO_IDX(320.0),
                                .spawnX          = 32,
                                .spawnZ          = 33,
                                .getActionConfig = HubConfig__GetNpcActionConfig_Tails },

    [CVIDOCK_NPC_JET_MARINE] = { .type            = CVIDOCKNPC_TYPE_MARINE,
                                 .spawnAngle      = FLOAT_DEG_TO_IDX(270.0),
                                 .spawnX          = 16,
                                 .spawnZ          = 45,
                                 .getActionConfig = HubConfig__GetNpcActionConfig_Marine },

    [CVIDOCK_NPC_JET_TABBY] = { .type            = CVIDOCKNPC_TYPE_TABBY,
                                .spawnAngle      = FLOAT_DEG_TO_IDX(90.0),
                                .spawnX          = 32,
                                .spawnZ          = 45,
                                .getActionConfig = HubConfig__GetNpcActionConfig_Tabby },

    [CVIDOCK_NPC_JET_KYLOK] = { .type            = CVIDOCKNPC_TYPE_KYLOK,
                                .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                .spawnX          = 12,
                                .spawnZ          = 45,
                                .getActionConfig = HubConfig__GetNpcActionConfig_Kylok },

    [CVIDOCK_NPC_BOAT_COLONEL] = { .type            = CVIDOCKNPC_TYPE_COLONEL,
                                   .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                   .spawnX          = -21,
                                   .spawnZ          = 84,
                                   .getActionConfig = HubConfig__GetNpcActionConfig_Colonel },

    [CVIDOCK_NPC_BOAT_GARDON] = { .type            = CVIDOCKNPC_TYPE_GARDON,
                                  .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                  .spawnX          = 21,
                                  .spawnZ          = 84,
                                  .getActionConfig = HubConfig__GetNpcActionConfig_Gardon },

    [CVIDOCK_NPC_BOAT_NORMAN] = { .type            = CVIDOCKNPC_TYPE_NORMAN,
                                  .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                  .spawnX          = -21,
                                  .spawnZ          = 84,
                                  .getActionConfig = HubConfig__GetNpcActionConfig_Norman },

    [CVIDOCK_NPC_HOVER_COLONEL] = { .type            = CVIDOCKNPC_TYPE_COLONEL,
                                    .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                    .spawnX          = 21,
                                    .spawnZ          = 84,
                                    .getActionConfig = HubConfig__GetNpcActionConfig_Colonel },

    [CVIDOCK_NPC_HOVER_DAIKUN] = { .type            = CVIDOCKNPC_TYPE_DAIKUN,
                                   .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                   .spawnX          = -21,
                                   .spawnZ          = 84,
                                   .getActionConfig = HubConfig__GetNpcActionConfig_Daikun },

    [CVIDOCK_NPC_SUBMARINE_COLONEL] = { .type            = CVIDOCKNPC_TYPE_COLONEL,
                                        .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                        .spawnX          = 21,
                                        .spawnZ          = 84,
                                        .getActionConfig = HubConfig__GetNpcActionConfig_Colonel },

    [CVIDOCK_NPC_SUBMARINE_DAIKUN] = { .type            = CVIDOCKNPC_TYPE_DAIKUN,
                                       .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                       .spawnX          = -21,
                                       .spawnZ          = 84,
                                       .getActionConfig = HubConfig__GetNpcActionConfig_Daikun },

    [CVIDOCK_NPC_BEACH_TABBY] = { .type            = CVIDOCKNPC_TYPE_TABBY,
                                  .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                  .spawnX          = -5,
                                  .spawnZ          = 27,
                                  .getActionConfig = HubConfig__GetNpcActionConfig_Tabby },

    [CVIDOCK_NPC_BEACH_MUZY] = { .type            = CVIDOCKNPC_TYPE_MUZY,
                                 .spawnAngle      = FLOAT_DEG_TO_IDX(0.0),
                                 .spawnX          = -5,
                                 .spawnZ          = 27,
                                 .getActionConfig = HubConfig__GetNpcActionConfig_Muzy },
};

static const CViMapAreaConfig mapAreaUpgradeConfig[] = {
    [(2 * SHIP_JET) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                              .unknownArea         = DOCKAREA_BASE_NEXT,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .unknown             = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_JET) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                              .unknownArea         = DOCKAREA_BASE_NEXT,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .unknown             = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .unknownArea         = DOCKAREA_JET,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .unknown             = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .unknownArea         = DOCKAREA_JET,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .unknown             = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .unknownArea         = DOCKAREA_BOAT,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .unknown             = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .unknownArea         = DOCKAREA_BOAT,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .unknown             = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .unknownArea         = DOCKAREA_HOVER,
                                  .shipScale           = FLOAT_TO_FX32(0.0),
                                  .shipPosY            = FLOAT_TO_FX32(0.0),
                                  .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                  .msgSeqShipCompleted = 0,
                                  .materialCount       = 5,
                                  .unknown             = 0,
                                  .materials           = { SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .unknownArea         = DOCKAREA_HOVER,
                                  .shipScale           = FLOAT_TO_FX32(0.0),
                                  .shipPosY            = FLOAT_TO_FX32(0.0),
                                  .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                  .msgSeqShipCompleted = 0,
                                  .materialCount       = 5,
                                  .unknown             = 0,
                                  .materials           = { SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD, SAVE_MATERIAL_BLACK, 0, 0, 0 } },
};

static const CViDockAreaConfig dockAreaConfig[] = {
    [DOCKAREA_BASE] = { .dockArea       = DOCKAREA_BASE,
                        .mapArea        = MAPAREA_BASE,
                        .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(23.0) },
                        .camPosZ        = FLOAT_TO_FX32(60.0),
                        .camAngle       = FLOAT_DEG_TO_IDX(340.005),
                        .camBounds = {
                            .min        = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(3.0), -FLOAT_TO_FX32(4.0) },
                            .max        = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(3.0), FLOAT_TO_FX32(4.0) },
                        },
                        .shadowAlpha    = GX_COLOR_FROM_888(0x40),
                        .playerTopSpeed = FLOAT_TO_FX32(0.5),
                        .camFlag        = FALSE,
                        .scale          = FLOAT_TO_FX32(1.0), },

    [DOCKAREA_BASE_NEXT] = { .dockArea       = DOCKAREA_BASE_NEXT,
                             .mapArea        = MAPAREA_BASE,
                             .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(23.0) },
                             .camPosZ        = FLOAT_TO_FX32(60.0),
                             .camAngle       = FLOAT_DEG_TO_IDX(340.005),
                             .camBounds = {
                                .min         = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(3.0), -FLOAT_TO_FX32(4.0) },
                                .max         = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(3.0), FLOAT_TO_FX32(4.0) },
                             },
                             .shadowAlpha    = GX_COLOR_FROM_888(0x40),
                             .playerTopSpeed = FLOAT_TO_FX32(0.5),
                             .camFlag        = FALSE,
                             .scale          = FLOAT_TO_FX32(1.0), },

    [DOCKAREA_JET] = { .dockArea       = DOCKAREA_JET,
                       .mapArea        = MAPAREA_JET,
                       .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(15.0) },
                       .camPosZ        = FLOAT_TO_FX32(80.0),
                       .camAngle       = FLOAT_DEG_TO_IDX(340.005),
                       .camBounds = {
                            .min       = { -FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(32.0) },
                            .max       = { FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(50.0) },
                        },
                       .shadowAlpha    = GX_COLOR_FROM_888(0x80),
                       .playerTopSpeed = FLOAT_TO_FX32(1.0),
                       .camFlag        = TRUE,
                       .scale          = FLOAT_TO_FX32(1.0), },

    [DOCKAREA_BOAT] = { .dockArea       = DOCKAREA_BOAT,
                        .mapArea        = MAPAREA_BOAT,
                        .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(30.0) },
                        .camPosZ        = FLOAT_TO_FX32(128.0),
                        .camAngle       = FLOAT_DEG_TO_IDX(330.005),
                        .camBounds = {
                            .min        = { -FLOAT_TO_FX32(105.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) },
                            .max        = { FLOAT_TO_FX32(105.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(76.0) },
                        },
                        .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                        .playerTopSpeed = FLOAT_TO_FX32(2.0),
                        .camFlag        = TRUE,
                        .scale          = FLOAT_TO_FX32(1.5), },

    [DOCKAREA_HOVER] = { .dockArea       = DOCKAREA_HOVER,
                         .mapArea        = MAPAREA_HOVER,
                         .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(30.0) },
                         .camPosZ        = FLOAT_TO_FX32(128.0),
                         .camAngle       = FLOAT_DEG_TO_IDX(330.005),
                         .camBounds = {
                            .min         = { -FLOAT_TO_FX32(85.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) },
                            .max         = { FLOAT_TO_FX32(45.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(76.0) },
                         },
                         .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                         .playerTopSpeed = FLOAT_TO_FX32(2.0),
                         .camFlag        = TRUE,
                         .scale          = FLOAT_TO_FX32(1.5), },

    [DOCKAREA_SUBMARINE] = { .dockArea       = DOCKAREA_SUBMARINE,
                             .mapArea        = MAPAREA_SUBMARINE,
                             .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(30.0) },
                             .camPosZ        = FLOAT_TO_FX32(128.0),
                             .camAngle       = FLOAT_DEG_TO_IDX(330.005),
                             .camBounds = {
                                .min         = { -FLOAT_TO_FX32(45.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) },
                                .max         = { FLOAT_TO_FX32(45.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(76.0) },
                             },
                             .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                             .playerTopSpeed = FLOAT_TO_FX32(2.0),
                             .camFlag        = TRUE,
                             .scale          = FLOAT_TO_FX32(1.5), },

    [DOCKAREA_BEACH] = { .dockArea       = DOCKAREA_BEACH,
                         .mapArea        = MAPAREA_BEACH,
                         .camOffset      = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(8.0) },
                         .camPosZ        = FLOAT_TO_FX32(100.0),
                         .camAngle       = FLOAT_DEG_TO_IDX(320.005),
                         .camBounds = {
                            .min         = {-FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(256.0) },
                            .max         = {FLOAT_TO_FX32(11.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(33.0) },
                         },
                         .shadowAlpha    = GX_COLOR_FROM_888(0x80),
                         .playerTopSpeed = FLOAT_TO_FX32(2.0),
                         .camFlag        = TRUE,
                         .scale          = FLOAT_TO_FX32(1.0), },

    // No stage for DOCKAREA_DRILL
};

static const CViMapAreaIconConfig mapAreaIconConfig[] = {
    [MAPAREA_BASE] = 
    {
        .position       = { 144, 148 },
        .dockArea       = DOCKAREA_BASE,
        .field_8        = MAPAREA_BASE,
        .nextArea_Left  = { MAPAREA_HOVER, MAPAREA_SUBMARINE, MAPAREA_BEACH },
        .nextArea_Up    = { MAPAREA_DRILL, MAPAREA_SUBMARINE, MAPAREA_TUTORIAL },
        .nextArea_Right = { MAPAREA_BOAT, MAPAREA_TUTORIAL, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .field_3C       = 1,
    },

    [MAPAREA_JET] = 
    {
        .position       = { 120, 212 },
        .dockArea       = DOCKAREA_JET,
        .field_8        = MAPAREA_JET,
        .nextArea_Left  = { MAPAREA_BEACH, MAPAREA_HOVER, MAPAREA_SUBMARINE },
        .nextArea_Up    = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_BOAT, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .field_3C       = 2,
    },

    [MAPAREA_BOAT] = 
    {
        .position       = { 260, 190 },
        .dockArea       = DOCKAREA_BOAT,
        .field_8        = MAPAREA_BOAT,
        .nextArea_Left  = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_TUTORIAL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .field_3C       = 3,
    },

    [MAPAREA_HOVER] = 
    {
        .position       = { 60, 158 },
        .dockArea       = DOCKAREA_HOVER,
        .field_8        = MAPAREA_HOVER,
        .nextArea_Left  = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_SUBMARINE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_BEACH, MAPAREA_JET, MAPAREA_INVALID },
        .field_3C       = 4,
    },

    [MAPAREA_SUBMARINE] = 
    {
        .position       = { 80, 100 },
        .dockArea       = DOCKAREA_SUBMARINE,
        .field_8        = MAPAREA_SUBMARINE,
        .nextArea_Left  = { MAPAREA_HOVER, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_DRILL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_DRILL, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_HOVER, MAPAREA_BASE, MAPAREA_JET },
        .field_3C       = 5,
    },

    [MAPAREA_BEACH] = 
    {
        .position       = { 44, 204 },
        .dockArea       = DOCKAREA_BEACH,
        .field_8        = MAPAREA_BEACH,
        .nextArea_Left  = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_HOVER, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_JET, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .field_3C       = CVIEVTCMN_RESOURCE_NONE,
    },

    [MAPAREA_DRILL] = 
    {
        .position       = { 154, 80 },
        .dockArea       = DOCKAREA_COUNT,
        .field_8        = MAPAREA_DRILL,
        .nextArea_Left  = { MAPAREA_SUBMARINE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_TUTORIAL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .field_3C       = 6,
    },

    [MAPAREA_TUTORIAL] = 
    {
        .position       = { 276, 104 },
        .dockArea       = DOCKAREA_COUNT,
        .field_8        = MAPAREA_TUTORIAL,
        .nextArea_Left  = { MAPAREA_DRILL, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Up    = { MAPAREA_DRILL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down  = { MAPAREA_BOAT, MAPAREA_BASE, MAPAREA_INVALID },
        .field_3C       = CVIEVTCMN_RESOURCE_NONE,
    },
};

// --------------------
// FUNCTIONS
// --------------------

const CViMapAreaIconConfig *HubConfig__GetDockMapIconConfig(u16 area)
{
    return &mapAreaIconConfig[area];
}

const CViDockAreaConfig *HubConfig__GetDockStageConfig(u16 area)
{
    return &dockAreaConfig[area];
}

const Unknown2171914 *HubConfig__GetDockUnknownConfig(u16 area)
{
    return &dockUnknownConfig[area];
}

const CViMapAreaConfig *HubConfig__GetDockMapConfig(u16 area)
{
    return &mapAreaConfig[area];
}

const CViMapAreaConfig *HubConfig__GetDockMapUnknownConfig(u16 area)
{
    return &mapAreaUpgradeConfig[area];
}

const CViPurchaseCostConfig *HubConfig__GetShipBuildCost(s32 id)
{
    return &shipBuildCost[id];
}

const CViPurchaseCostConfig *HubConfig__GetRadioTowerPurchaseCost(void)
{
    return &radioTowerCost[0];
}

const CViPurchaseCostConfig *HubConfig__GetDecorPurchaseCost(s32 id)
{
    return &decorPurchaseCost[id];
}

const CViPurchaseCostConfig *HubConfig__GetShipUpgradeCost(s32 id)
{
    return &shipUpgradeCost[id];
}

const CViDockBackAreaConfig *HubConfig__GetDockBackInfo(u16 id)
{
    return &dockBackAreaConfig[id];
}

const HubNpcSpawnConfig *HubConfig__GetNpcConfig(u16 id)
{
    return &npcSpawnConfig[id];
}

const u16 *HubConfig__Func_2152A20(u16 id)
{
    return &ovl05_02171882[id];
}

const u16 *HubConfig__Func_2152A30(u16 id)
{
    return &ovl05_02171848[id];
}

const u16 *HubConfig__Func_2152A40(u16 id)
{
    return &ovl05_02171864[id];
}

const CViMapDecorConfig *HubConfig__GetMapBackConfig(s32 id)
{
    return &mapDecorGraphicsConfig[id];
}

BOOL HubConfig__Func_2152A60(u16 id)
{
    return id <= 6;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Tails(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Marine(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Blaze(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Setter(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Tabby(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Colonel(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Gardon(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Daikun(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Kylok(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Muzy(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Norman(void)
{
    return &npcTalkActionCommon;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_Hourglass(void)
{
    return &npcTalkActionHourglass;
}

const HubNpcTalkActionConfig *HubConfig__GetNpcActionConfig_OldDS(void)
{
    return &npcTalkActionOldDS;
}