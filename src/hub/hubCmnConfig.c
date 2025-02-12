#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <hub/cviEvtCmn.hpp>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/bb/vi_dock.h>

// --------------------
// VARIABLES
// --------------------

static const ViNpcUnknown npcUnknown3 = { .field_0 = 10, .field_2 = 15 };
static const ViNpcUnknown npcUnknown1 = { .field_0 = 0, .field_2 = 0 };
static const ViNpcUnknown npcUnknown2 = { .field_0 = 10, .field_2 = 16 };

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
    { .areaID = DOCKAREA_BASE, .field_4 = 0 },  { .areaID = DOCKAREA_JET, .field_4 = 2 },       { .areaID = DOCKAREA_SHIP, .field_4 = 3 },
    { .areaID = DOCKAREA_BOAT, .field_4 = 4 },  { .areaID = DOCKAREA_SUBMARINE, .field_4 = 5 }, { .areaID = DOCKAREA_BEACH, .field_4 = 6 },
    { .areaID = DOCKAREA_DRILL, .field_4 = 8 },
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
    { .areaID   = DOCKAREA_JET,
      .field_4  = 1,
      .field_8  = 0x3000,
      .field_C  = 0,
      .field_10 = 0x71C,
      .msgSeq   = 0,
      .field_14 = 2,
      .field_18 = 0x10000,
      .field_1C = 0,
      .field_20 = 0,
      .field_24 = 0 },

    { .areaID   = DOCKAREA_SHIP,
      .field_4  = 2,
      .field_8  = 0x800,
      .field_C  = 0,
      .field_10 = 0xE38,
      .msgSeq   = 1,
      .field_14 = 2,
      .field_18 = 0x30002,
      .field_1C = 0,
      .field_20 = 0,
      .field_24 = 0 },

    { .areaID   = DOCKAREA_BOAT,
      .field_4  = 3,
      .field_8  = 0x800,
      .field_C  = 0,
      .field_10 = 0xE38,
      .msgSeq   = 2,
      .field_14 = 6,
      .field_18 = 0x10000,
      .field_1C = 0x30002,
      .field_20 = 0x50004,
      .field_24 = 0 },

    { .areaID   = DOCKAREA_SUBMARINE,
      .field_4  = 4,
      .field_8  = 0x800,
      .field_C  = 0,
      .field_10 = 0xE38,
      .msgSeq   = 3,
      .field_14 = 8,
      .field_18 = 0x10000,
      .field_1C = 0x30002,
      .field_20 = 0x50004,
      .field_24 = 0x70006 },

    { .areaID   = DOCKAREA_DRILL,
      .field_4  = 6,
      .field_8  = 0x800,
      .field_C  = 0,
      .field_10 = 0xE38,
      .msgSeq   = 4,
      .field_14 = 1,
      .field_18 = 8,
      .field_1C = 0,
      .field_20 = 0,
      .field_24 = 0 },
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

    { .field_0            = DOCKAREA_SHIP,
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

    { .field_0            = DOCKAREA_BOAT,
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

static const HubNpcSpawnConfig npcSpawnConfig[] = {
    { .field_0 = 1, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 9, .spawnZ = 0, .field_8 = HubConfig__Func_2152A70 },

    { .field_0 = 2, .spawnAngle = FLOAT_DEG_TO_IDX(90.0), .spawnX = -15, .spawnZ = 18, .field_8 = HubConfig__Func_2152A7C },

    { .field_0 = 0, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -9, .spawnZ = 0, .field_8 = HubConfig__Func_2152A88 },

    { .field_0 = 5, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -9, .spawnZ = 0, .field_8 = HubConfig__Func_2152AA0 },

    { .field_0 = 6, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -9, .spawnZ = 0, .field_8 = HubConfig__Func_2152AAC },

    { .field_0 = 4, .spawnAngle = FLOAT_DEG_TO_IDX(270.0), .spawnX = 11, .spawnZ = 8, .field_8 = HubConfig__Func_2152A94 },

    { .field_0 = 6, .spawnAngle = FLOAT_DEG_TO_IDX(90.0), .spawnX = -11, .spawnZ = 8, .field_8 = HubConfig__Func_2152AAC },

    { .field_0 = 11, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -7, .spawnZ = -11, .field_8 = HubConfig__Func_2152AF4 },

    { .field_0 = 12, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 7, .spawnZ = -11, .field_8 = HubConfig__Func_2152B00 },

    { .field_0 = 1, .spawnAngle = FLOAT_DEG_TO_IDX(320.0), .spawnX = 32, .spawnZ = 33, .field_8 = HubConfig__Func_2152A70 },

    { .field_0 = 2, .spawnAngle = FLOAT_DEG_TO_IDX(270.0), .spawnX = 16, .spawnZ = 45, .field_8 = HubConfig__Func_2152A7C },

    { .field_0 = 5, .spawnAngle = FLOAT_DEG_TO_IDX(90.0), .spawnX = 32, .spawnZ = 45, .field_8 = HubConfig__Func_2152AA0 },

    { .field_0 = 9, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 12, .spawnZ = 45, .field_8 = HubConfig__Func_2152AD0 },

    { .field_0 = 6, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AAC },

    { .field_0 = 7, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AB8 },

    { .field_0 = 3, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AE8 },

    { .field_0 = 6, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AAC },

    { .field_0 = 8, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AC4 },

    { .field_0 = 6, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = 21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AAC },

    { .field_0 = 8, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -21, .spawnZ = 84, .field_8 = HubConfig__Func_2152AC4 },

    { .field_0 = 5, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -5, .spawnZ = 27, .field_8 = HubConfig__Func_2152AA0 },

    { .field_0 = 10, .spawnAngle = FLOAT_DEG_TO_IDX(0.0), .spawnX = -5, .spawnZ = 27, .field_8 = HubConfig__Func_2152ADC },
};

static const Unknown2171CCC ovl05_02171CCC[] = {
    { .field_0 = 9, .field_4 = 1, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 3, .field_18 = 0x10000, .field_1C = 8, .field_20 = 0, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 1, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 3, .field_18 = 0x10000, .field_1C = 8, .field_20 = 0, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 2, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 3, .field_18 = 0x30002, .field_1C = 8, .field_20 = 0, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 2, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 3, .field_18 = 0x30002, .field_1C = 8, .field_20 = 0, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 3, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 5, .field_18 = 0x30002, .field_1C = 0x50004, .field_20 = 8, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 3, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 5, .field_18 = 0x30002, .field_1C = 0x50004, .field_20 = 8, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 4, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 5, .field_18 = 0x50004, .field_1C = 0x70006, .field_20 = 8, .field_24 = 0 },
    { .field_0 = 9, .field_4 = 4, .field_8 = 0, .field_C = 0, .field_10 = 0, .field_14 = 5, .field_18 = 0x50004, .field_1C = 0x70006, .field_20 = 8, .field_24 = 0 },
};

static const DockStageConfig HubConfig__dockStageConfig[] = {
    [DOCKAREA_BASE] = { .areaID         = DOCKAREA_BASE,
                        .nextArea       = DOCKAREA_BASE,
                        .field_8        = { 0, 0, -0x17000 },
                        .field_14       = 0x3C000,
                        .field_18       = 0xF1C8,
                        .field_1C       = 0,
                        .field_20       = 0x3000,
                        .field_24       = 0xFFFFC000,
                        .field_28       = 0,
                        .field_2C       = 0x3000,
                        .field_30       = 0x4000,
                        .field_34       = 8,
                        .playerTopSpeed = 0x800,
                        .field_3C       = 0,
                        .field_40       = 0x1000,
                        .field_42       = 0 },

    [DOCKAREA_BASE_NEXT] = { .areaID         = DOCKAREA_BASE_NEXT,
                             .nextArea       = DOCKAREA_BASE,
                             .field_8        = { 0, 0, -0x17000 },
                             .field_14       = 0x3C000,
                             .field_18       = 0xF1C8,
                             .field_1C       = 0,
                             .field_20       = 0x3000,
                             .field_24       = 0xFFFFC000,
                             .field_28       = 0,
                             .field_2C       = 0x3000,
                             .field_30       = 0x4000,
                             .field_34       = 8,
                             .playerTopSpeed = 0x800,
                             .field_3C       = 0,
                             .field_40       = 0x1000,
                             .field_42       = 0 },

    [DOCKAREA_JET] = { .areaID         = DOCKAREA_JET,
                       .nextArea       = DOCKAREA_BASE_NEXT,
                       .field_8        = { 0, 0, -0xF000 },
                       .field_14       = 0x50000,
                       .field_18       = 0xF1C8,
                       .field_1C       = 0xFFFEC000,
                       .field_20       = 0,
                       .field_24       = 0x20000,
                       .field_28       = 0x14000,
                       .field_2C       = 0,
                       .field_30       = 0x32000,
                       .field_34       = 0x10,
                       .playerTopSpeed = 0x1000,
                       .field_3C       = 1,
                       .field_40       = 0x1000,
                       .field_42       = 0 },

    [DOCKAREA_SHIP] = { .areaID         = DOCKAREA_SHIP,
                        .nextArea       = DOCKAREA_JET,
                        .field_8        = { 0, 0, -0x1E000 },
                        .field_14       = 0x80000,
                        .field_18       = 0xEAAB,
                        .field_1C       = 0xFFF97000,
                        .field_20       = 0,
                        .field_24       = 0,
                        .field_28       = 0x69000,
                        .field_2C       = 0,
                        .field_30       = 0x4C000,
                        .field_34       = 0xC,
                        .playerTopSpeed = 0x2000,
                        .field_3C       = 1,
                        .field_40       = 0x1800,
                        .field_42       = 0 },

    [DOCKAREA_BOAT] = { .areaID         = DOCKAREA_BOAT,
                        .nextArea       = DOCKAREA_SHIP,
                        .field_8        = { 0, 0, -0x1E000 },
                        .field_14       = 0x80000,
                        .field_18       = 0xEAAB,
                        .field_1C       = 0xFFFAB000,
                        .field_20       = 0,
                        .field_24       = 0,
                        .field_28       = 0x2D000,
                        .field_2C       = 0,
                        .field_30       = 0x4C000,
                        .field_34       = 0xC,
                        .playerTopSpeed = 0x2000,
                        .field_3C       = 1,
                        .field_40       = 0x1800,
                        .field_42       = 0 },

    [DOCKAREA_SUBMARINE] = { .areaID         = DOCKAREA_SUBMARINE,
                             .nextArea       = DOCKAREA_BOAT,
                             .field_8        = { 0, 0, -0x1E000 },
                             .field_14       = 0x80000,
                             .field_18       = 0xEAAB,
                             .field_1C       = 0xFFFD3000,
                             .field_20       = 0,
                             .field_24       = 0,
                             .field_28       = 0x2D000,
                             .field_2C       = 0,
                             .field_30       = 0x4C000,
                             .field_34       = 0xC,
                             .playerTopSpeed = 0x2000,
                             .field_3C       = 1,
                             .field_40       = 0x1800,
                             .field_42       = 0 },

    [DOCKAREA_BEACH] = { .areaID         = DOCKAREA_BEACH,
                         .nextArea       = DOCKAREA_SUBMARINE,
                         .field_8        = { 0, 0, -0x8000 },
                         .field_14       = 0x64000,
                         .field_18       = 0xE38F,
                         .field_1C       = 0xFFFF5000,
                         .field_20       = 0,
                         .field_24       = 0xFFF00000,
                         .field_28       = 0xB000,
                         .field_2C       = 0,
                         .field_30       = 0x21000,
                         .field_34       = 0x10,
                         .playerTopSpeed = 0x2000,
                         .field_3C       = 1,
                         .field_40       = 0x1000,
                         .field_42       = 0 },

    // No stage for DOCKAREA_DRILL
};

static const Unknown2171FE8 ovl05_02171FE8[] = {
    [DOCKAREA_BASE] = 
    {
        .field_0  = 0x90,
        .field_2  = 0x94,
        .field_4  = 0,
        .field_8  = 0,
        .field_C  = { 3, 4, 5 },
        .field_18 = { 6, 4, 7 },
        .field_24 = { 2, 7, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = 1,
        .field_3E = 0,
    },

    [DOCKAREA_BASE_NEXT] = 
    {
        .field_0  = 0x78,
        .field_2  = 0xD4,
        .field_4  = 2,
        .field_8  = 1,
        .field_C  = { 5, 3, 4 },
        .field_18 = { 0, 9, 9 },
        .field_24 = { 2, 0, 9 },
        .field_30 = { 9, 9, 9 },
        .field_3C = 2,
        .field_3E = 0,
    },

    [DOCKAREA_JET] = 
    {
        .field_0  = 0x104,
        .field_2  = 0xBE,
        .field_4  = 3,
        .field_8  = 2,
        .field_C  = { 0, 9, 9 },
        .field_18 = { 7, 9, 9 },
        .field_24 = { 9, 9, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = 3,
        .field_3E = 0,
    },

    [DOCKAREA_SHIP] = 
    {
        .field_0  = 0x3C,
        .field_2  = 0x9E,
        .field_4  = 4,
        .field_8  = 3,
        .field_C  = { 9, 9, 9 },
        .field_18 = { 4, 9, 9 },
        .field_24 = { 0, 9, 9 },
        .field_30 = { 5, 1, 9 },
        .field_3C = 4,
        .field_3E = 0,
    },

    [DOCKAREA_BOAT] = 
    {
        .field_0  = 0x50,
        .field_2  = 0x64,
        .field_4  = 5,
        .field_8  = 4,
        .field_C  = { 3, 9, 9 },
        .field_18 = { 6, 9, 9 },
        .field_24 = { 6, 0, 9 },
        .field_30 = { 3, 0, 1 },
        .field_3C = 5,
        .field_3E = 0,
    },

    [DOCKAREA_SUBMARINE] = 
    {
        .field_0  = 0x2C,
        .field_2  = 0xCC,
        .field_4  = 6,
        .field_8  = 5,
        .field_C  = { 9, 9, 9 },
        .field_18 = { 3, 9, 9 },
        .field_24 = { 1, 0, 9 },
        .field_30 = { 1, 9, 9 },
        .field_3C = CVIEVTCMN_RESOURCE_NONE,
        .field_3E = 0,
    },

    [DOCKAREA_BEACH] = 
    {
        .field_0  = 0x9A,
        .field_2  = 0x50,
        .field_4  = 8,
        .field_8  = 6,
        .field_C  = { 4, 9, 9 },
        .field_18 = { 9, 9, 9 },
        .field_24 = { 7, 9, 9 },
        .field_30 = { 0, 9, 9 },
        .field_3C = 6,
        .field_3E = 0,
    },

    [DOCKAREA_DRILL] = 
    {
        .field_0  = 0x114,
        .field_2  = 0x68,
        .field_4  = 8,
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

const Unknown2171914 *HubConfig__GetDockUnknownConfig(u16 id)
{
    return &dockUnknownConfig[id];
}

const DockMapConfig *HubConfig__GetDockMapConfig(u16 id)
{
    return &dockMapConfig[id];
}

const Unknown2171CCC *HubConfig__Func_21529A8(u16 id)
{
    return &ovl05_02171CCC[id];
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

const ViDockBackConfig *HubConfig__GetDockBackInfo(s32 id)
{
    return &dockBackInfo[id];
}

const HubNpcSpawnConfig *HubConfig__GetNpcConfig(u16 id)
{
    return &npcSpawnConfig[id];
}

const u16 *HubConfig__Func_2152A20(s32 id)
{
    return &ovl05_02171882[id];
}

const u16 *HubConfig__Func_2152A30(s32 id)
{
    return &ovl05_02171848[id];
}

const u16 *HubConfig__Func_2152A40(s32 id)
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

const ViNpcUnknown *HubConfig__Func_2152A70(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152A7C(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152A88(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152A94(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AA0(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AAC(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AB8(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AC4(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AD0(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152ADC(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AE8(void)
{
    return &npcUnknown1;
}

const ViNpcUnknown *HubConfig__Func_2152AF4(void)
{
    return &npcUnknown2;
}

const ViNpcUnknown *HubConfig__Func_2152B00(void)
{
    return &npcUnknown3;
}