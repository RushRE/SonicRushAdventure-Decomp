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

static const HubPurchaseCostConfig radioTowerCost[] =
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

static const HubPurchaseCostConfig decorPurchaseCost[] =
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

static const ViMapBackConfig mapDecorGraphicsConfig[] = {
    { .flags = 0, .animID = 0 },  { .flags = 0, .animID = 1 },  { .flags = 0, .animID = 2 },  { .flags = 0, .animID = 3 },  { .flags = 0, .animID = 4 },
    { .flags = 2, .animID = 7 },  { .flags = 0, .animID = 8 },  { .flags = 0, .animID = 9 },  { .flags = 0, .animID = 10 }, { .flags = 1, .animID = 11 },
    { .flags = 1, .animID = 12 }, { .flags = 1, .animID = 13 }, { .flags = 1, .animID = 14 },
};

static const Unknown2171914 dockUnknownConfig[] = {
    { .dockArea = DOCKAREA_BASE, .field_4 = 0 },  { .dockArea = DOCKAREA_JET, .field_4 = 2 },       { .dockArea = DOCKAREA_BOAT, .field_4 = 3 },
    { .dockArea = DOCKAREA_HOVER, .field_4 = 4 }, { .dockArea = DOCKAREA_SUBMARINE, .field_4 = 5 }, { .dockArea = DOCKAREA_BEACH, .field_4 = 6 },
    { .dockArea = DOCKAREA_DRILL, .field_4 = 8 },
};

static const HubPurchaseCostConfig shipBuildCost[] =
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

static const HubPurchaseCostConfig shipUpgradeCost[] =
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

static const DockMapConfig dockMapConfig[] = {
    [SHIP_JET] = 
    {
        .dockArea            = DOCKAREA_JET,
        .unknownArea         = DOCKAREA_BASE_NEXT,
        .shipScale           = FLOAT_TO_FX32(3.0),
        .shipPosY            = FLOAT_TO_FX32(0.0),
        .rotationX           = FLOAT_DEG_TO_IDX(10.0),
        .msgSeqShipCompleted = 0,
        .materialCount       = 2,
        .field_16            = 0,
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
        .field_16            = 0,
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
        .field_16            = 0,
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
        .field_16            = 0,
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
        .field_16            = 0,
        .materials           = { SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0, 0, 0 },
    },
};

static const ViDockBackConfig dockBackInfo[] = {
    { .field_0            = DOCKAREA_BASE,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SON_BASE_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SON_BASE_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(4.0),
      .field_18           = FLOAT_DEG_TO_IDX(0.0) },

    { .field_0            = DOCKAREA_BASE_NEXT,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_DOCK_BASE_NEXT_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_DOCK_BASE_NEXT_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(4.0),
      .field_18           = FLOAT_DEG_TO_IDX(0.0) },

    { .field_0            = DOCKAREA_JET,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_JET_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(4.0),
      .field_18           = FLOAT_DEG_TO_IDX(270.0) },

    { .field_0            = DOCKAREA_BOAT,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SHIP_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(10.0),
      .field_18           = FLOAT_DEG_TO_IDX(270.0) },

    { .field_0            = DOCKAREA_HOVER,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_BOAT_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = FLOAT_TO_FX32(0.0),
      .field_18           = FLOAT_DEG_TO_IDX(270.0) },

    { .field_0            = DOCKAREA_SUBMARINE,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_NSBMD,
      .resJointAnimShip   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_NSBCA,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_NSBTA,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_SUBMARINE_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = FLOAT_TO_FX32(0.0),
      .field_18           = FLOAT_DEG_TO_IDX(270.0) },

    { .field_0            = DOCKAREA_BEACH,
      .resModelShip       = CVIEVTCMN_RESOURCE_NONE,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBMD,
      .resJointAnimDock   = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBCA,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_NSBTP,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_BEACH_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(4.0),
      .field_18           = FLOAT_DEG_TO_IDX(0.0) },

    { .field_0            = DOCKAREA_NONE,
      .resModelShip       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_NSBMD,
      .resJointAnimShip   = CVIEVTCMN_RESOURCE_NONE,
      .resModelDock       = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_DOCK_NSBMD,
      .resJointAnimDock   = CVIEVTCMN_RESOURCE_NONE,
      .resTextureAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .resPatternAnimDock = CVIEVTCMN_RESOURCE_NONE,
      .field_10           = BUNDLE_VI_DOCK_FILE_RESOURCES_BB_VI_DOCK_SONIC_DRILL_DOCK_BSD,
      .field_12           = CVIEVTCMN_RESOURCE_NONE,
      .field_14           = -FLOAT_TO_FX32(10.0),
      .field_18           = FLOAT_DEG_TO_IDX(0.0) },
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

static const DockMapConfig dockMapConfig_Unknown[] = {
    [(2 * SHIP_JET) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                              .unknownArea         = DOCKAREA_BASE_NEXT,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .field_16            = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_JET) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                              .unknownArea         = DOCKAREA_BASE_NEXT,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .field_16            = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .unknownArea         = DOCKAREA_JET,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .field_16            = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .unknownArea         = DOCKAREA_JET,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .field_16            = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .unknownArea         = DOCKAREA_BOAT,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .field_16            = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .unknownArea         = DOCKAREA_BOAT,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .field_16            = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .unknownArea         = DOCKAREA_HOVER,
                                  .shipScale           = FLOAT_TO_FX32(0.0),
                                  .shipPosY            = FLOAT_TO_FX32(0.0),
                                  .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                  .msgSeqShipCompleted = 0,
                                  .materialCount       = 5,
                                  .field_16            = 0,
                                  .materials           = { SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .unknownArea         = DOCKAREA_HOVER,
                                  .shipScale           = FLOAT_TO_FX32(0.0),
                                  .shipPosY            = FLOAT_TO_FX32(0.0),
                                  .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                  .msgSeqShipCompleted = 0,
                                  .materialCount       = 5,
                                  .field_16            = 0,
                                  .materials           = { SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD, SAVE_MATERIAL_BLACK, 0, 0, 0 } },
};

static const DockStageConfig HubConfig__dockStageConfig[] = {
    [DOCKAREA_BASE] = { .dockArea       = DOCKAREA_BASE,
                        .mapArea        = MAPAREA_BASE,
                        .field_8        = { 0, 0, -0x17000 },
                        .field_14       = 0x3C000,
                        .field_18       = 0xF1C8,
                        .field_1C       = 0,
                        .field_20       = 0x3000,
                        .field_24       = -0x4000,
                        .field_28       = 0,
                        .field_2C       = 0x3000,
                        .field_30       = 0x4000,
                        .shadowAlpha    = GX_COLOR_FROM_888(0x40),
                        .playerTopSpeed = FLOAT_TO_FX32(0.5),
                        .field_3C       = 0,
                        .scale          = FLOAT_TO_FX32(1.0),
                        .field_42       = 0 },

    [DOCKAREA_BASE_NEXT] = { .dockArea       = DOCKAREA_BASE_NEXT,
                             .mapArea        = MAPAREA_BASE,
                             .field_8        = { 0, 0, -0x17000 },
                             .field_14       = 0x3C000,
                             .field_18       = 0xF1C8,
                             .field_1C       = 0,
                             .field_20       = 0x3000,
                             .field_24       = -0x4000,
                             .field_28       = 0,
                             .field_2C       = 0x3000,
                             .field_30       = 0x4000,
                             .shadowAlpha    = GX_COLOR_FROM_888(0x40),
                             .playerTopSpeed = FLOAT_TO_FX32(0.5),
                             .field_3C       = 0,
                             .scale          = FLOAT_TO_FX32(1.0),
                             .field_42       = 0 },

    [DOCKAREA_JET] = { .dockArea       = DOCKAREA_JET,
                       .mapArea        = MAPAREA_JET,
                       .field_8        = { 0, 0, -0xF000 },
                       .field_14       = 0x50000,
                       .field_18       = 0xF1C8,
                       .field_1C       = -0x14000,
                       .field_20       = 0,
                       .field_24       = 0x20000,
                       .field_28       = 0x14000,
                       .field_2C       = 0,
                       .field_30       = 0x32000,
                       .shadowAlpha    = GX_COLOR_FROM_888(0x80),
                       .playerTopSpeed = FLOAT_TO_FX32(1.0),
                       .field_3C       = 1,
                       .scale          = FLOAT_TO_FX32(1.0),
                       .field_42       = 0 },

    [DOCKAREA_BOAT] = { .dockArea       = DOCKAREA_BOAT,
                        .mapArea        = MAPAREA_BOAT,
                        .field_8        = { 0, 0, -0x1E000 },
                        .field_14       = 0x80000,
                        .field_18       = 0xEAAB,
                        .field_1C       = -0x69000,
                        .field_20       = 0,
                        .field_24       = 0,
                        .field_28       = 0x69000,
                        .field_2C       = 0,
                        .field_30       = 0x4C000,
                        .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                        .playerTopSpeed = FLOAT_TO_FX32(2.0),
                        .field_3C       = 1,
                        .scale          = FLOAT_TO_FX32(1.5),
                        .field_42       = 0 },

    [DOCKAREA_HOVER] = { .dockArea       = DOCKAREA_HOVER,
                         .mapArea        = MAPAREA_HOVER,
                         .field_8        = { 0, 0, -0x1E000 },
                         .field_14       = 0x80000,
                         .field_18       = 0xEAAB,
                         .field_1C       = -0x55000,
                         .field_20       = 0,
                         .field_24       = 0,
                         .field_28       = 0x2D000,
                         .field_2C       = 0,
                         .field_30       = 0x4C000,
                         .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                         .playerTopSpeed = FLOAT_TO_FX32(2.0),
                         .field_3C       = 1,
                         .scale          = FLOAT_TO_FX32(1.5),
                         .field_42       = 0 },

    [DOCKAREA_SUBMARINE] = { .dockArea       = DOCKAREA_SUBMARINE,
                             .mapArea        = MAPAREA_SUBMARINE,
                             .field_8        = { 0, 0, -0x1E000 },
                             .field_14       = 0x80000,
                             .field_18       = 0xEAAB,
                             .field_1C       = -0x2D000,
                             .field_20       = 0,
                             .field_24       = 0,
                             .field_28       = 0x2D000,
                             .field_2C       = 0,
                             .field_30       = 0x4C000,
                             .shadowAlpha    = GX_COLOR_FROM_888(0x60),
                             .playerTopSpeed = FLOAT_TO_FX32(2.0),
                             .field_3C       = 1,
                             .scale          = FLOAT_TO_FX32(1.5),
                             .field_42       = 0 },

    [DOCKAREA_BEACH] = { .dockArea       = DOCKAREA_BEACH,
                         .mapArea        = MAPAREA_BEACH,
                         .field_8        = { 0, 0, -0x8000 },
                         .field_14       = 0x64000,
                         .field_18       = 0xE38F,
                         .field_1C       = -0xB000,
                         .field_20       = 0,
                         .field_24       = -0x100000,
                         .field_28       = 0xB000,
                         .field_2C       = 0,
                         .field_30       = 0x21000,
                         .shadowAlpha    = GX_COLOR_FROM_888(0x80),
                         .playerTopSpeed = FLOAT_TO_FX32(2.0),
                         .field_3C       = 1,
                         .scale          = FLOAT_TO_FX32(1.0),
                         .field_42       = 0 },

    // No stage for DOCKAREA_DRILL
};

static const Unknown2171FE8 ovl05_02171FE8[] = {
    [MAPAREA_BASE] = 
    {
        .field_0  = 0x90,
        .field_2  = 0x94,
        .dockArea = DOCKAREA_BASE,
        .field_8  = 0,
        .field_C  = { 3, 4, 5 },
        .field_18 = { 6, 4, 7 },
        .field_24 = { 2, 7, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = 1,
        .field_3E = 0,
    },

    [MAPAREA_JET] = 
    {
        .field_0  = 0x78,
        .field_2  = 0xD4,
        .dockArea = DOCKAREA_JET,
        .field_8  = 1,
        .field_C  = { 5, 3, 4 },
        .field_18 = { 0, 9, 9 },
        .field_24 = { 2, 0, 9 },
        .field_30 = { 9, 9, 9 },
        .field_3C = 2,
        .field_3E = 0,
    },

    [MAPAREA_BOAT] = 
    {
        .field_0  = 0x104,
        .field_2  = 0xBE,
        .dockArea = DOCKAREA_BOAT,
        .field_8  = 2,
        .field_C  = { 0, 9, 9 },
        .field_18 = { 7, 9, 9 },
        .field_24 = { 9, 9, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = 3,
        .field_3E = 0,
    },

    [MAPAREA_HOVER] = 
    {
        .field_0  = 0x3C,
        .field_2  = 0x9E,
        .dockArea = DOCKAREA_HOVER,
        .field_8  = 3,
        .field_C  = { 9, 9, 9 },
        .field_18 = { 4, 9, 9 },
        .field_24 = { 0, 9, 9 },
        .field_30 = { 5, 1, 9 },
        .field_3C = 4,
        .field_3E = 0,
    },

    [MAPAREA_SUBMARINE] = 
    {
        .field_0  = 0x50,
        .field_2  = 0x64,
        .dockArea = DOCKAREA_SUBMARINE,
        .field_8  = 4,
        .field_C  = { 3, 9, 9 },
        .field_18 = { 6, 9, 9 },
        .field_24 = { 6, 0, 9 },
        .field_30 = { 3, 0, 1 },
        .field_3C = 5,
        .field_3E = 0,
    },

    [MAPAREA_BEACH] = 
    {
        .field_0  = 0x2C,
        .field_2  = 0xCC,
        .dockArea = DOCKAREA_BEACH,
        .field_8  = 5,
        .field_C  = { 9, 9, 9 },
        .field_18 = { 3, 9, 9 },
        .field_24 = { 1, 0, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = CVIEVTCMN_RESOURCE_NONE,
        .field_3E = 0,
    },

    [MAPAREA_DRILL] = 
    {
        .field_0  = 0x9A,
        .field_2  = 0x50,
        .dockArea = DOCKAREA_COUNT,
        .field_8  = 6,
        .field_C  = { 4, 9, 9 },
        .field_18 = { 9, 9, 9 },
        .field_24 = { 7, 9, 9 },
        .field_30 = { 0, 9, 9 },
        .field_3C = 6,
        .field_3E = 0,
    },

    [MAPAREA_TUTORIAL] = 
    {
        .field_0  = 0x114,
        .field_2  = 0x68,
        .dockArea = DOCKAREA_COUNT,
        .field_8  = 7,
        .field_C  = { 6, 0, 9 },
        .field_18 = { 6, 9, 9 },
        .field_24 = { 9, 9, 9 },
        .field_30 = { 2, 0, 9 },
        .field_3C = CVIEVTCMN_RESOURCE_NONE,
        .field_3E = 0,
    },
};

// --------------------
// FUNCTIONS
// --------------------

const Unknown2171FE8 *HubConfig__Func_2152960(u16 area)
{
    return &ovl05_02171FE8[area];
}

const DockStageConfig *HubConfig__GetDockStageConfig(u16 area)
{
    return &HubConfig__dockStageConfig[area];
}

const Unknown2171914 *HubConfig__GetDockUnknownConfig(u16 area)
{
    return &dockUnknownConfig[area];
}

const DockMapConfig *HubConfig__GetDockMapConfig(u16 area)
{
    return &dockMapConfig[area];
}

const DockMapConfig *HubConfig__GetDockMapUnknownConfig(u16 area)
{
    return &dockMapConfig_Unknown[area];
}

const HubPurchaseCostConfig *HubConfig__GetShipBuildCost(s32 id)
{
    return &shipBuildCost[id];
}

const HubPurchaseCostConfig *HubConfig__GetRadioTowerPurchaseCost(void)
{
    return &radioTowerCost[0];
}

const HubPurchaseCostConfig *HubConfig__GetDecorPurchaseCost(s32 id)
{
    return &decorPurchaseCost[id];
}

const HubPurchaseCostConfig *HubConfig__GetShipUpgradeCost(s32 id)
{
    return &shipUpgradeCost[id];
}

const ViDockBackConfig *HubConfig__GetDockBackInfo(u16 id)
{
    return &dockBackInfo[id];
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

const ViMapBackConfig *HubConfig__GetMapBackConfig(s32 id)
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