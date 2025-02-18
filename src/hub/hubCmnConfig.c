#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <hub/cviEvtCmn.hpp>
#include <hub/cviDockNpcTalk.hpp>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/bb/vi_dock.h>
#include <resources/bb/vi_map_back.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define GET_CVIMAPBACK_IMAGE(id) ((id) - (BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_VMC))

// --------------------
// VARIABLES
// --------------------

static const HubNpcTalkActionConfig npcTalkActionOldDS     = { .talkActionType = CVIDOCKNPCTALK_ACTION, .talkActionParam = CVIDOCKNPCTALK_ACTION_OPEN_VS_MAIN_MENU };
static const HubNpcTalkActionConfig npcTalkActionCommon    = { .talkActionType = CVIDOCKNPCTALK_NPC, .talkActionParam = 0 };
static const HubNpcTalkActionConfig npcTalkActionHourglass = { .talkActionType = CVIDOCKNPCTALK_ACTION, .talkActionParam = CVIDOCKNPCTALK_ACTION_OPEN_STAGE_SELECT };

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

static const u16 mapBackDecorBackgroundConfig[] = {
    [CVIMAPBACK_DECORBG_ISLAND]         = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_VMC),
    [CVIMAPBACK_DECORBG_BASE]           = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_BASE_VMC),
    [CVIMAPBACK_DECORBG_DOCK_JET]       = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_JET_VMC),
    [CVIMAPBACK_DECORBG_DOCK_BOAT]      = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_SAIL_VMC),
    [CVIMAPBACK_DECORBG_DOCK_HOVER]     = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_HOVER_VMC),
    [CVIMAPBACK_DECORBG_DOCK_SUBMARINE] = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_SUBMARINE_VMC),
    [CVIMAPBACK_DECORBG_DOCK_DRILL]     = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_DRILL_VMC),
    [CVIMAPBACK_DECORBG_DOCK_BEACH]     = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DOCK_BEACH_VMC),
    [CVIMAPBACK_DECORBG_DEC_WATERFALL]  = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_WATERFALL_VMC),
    [CVIMAPBACK_DECORBG_DEC_LIGHTHOUSE] = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_LIGHTHOUSE_VMC),
    [CVIMAPBACK_DECORBG_DEC_LAVA]       = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_LAVA_VMC),
    [CVIMAPBACK_DECORBG_DEC_WATCHTOWER] = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_WATCHTOWER_VMC),
    [CVIMAPBACK_DECORBG_DEC_STATUE]     = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_STATUE_VMC),
    [CVIMAPBACK_DECORBG_DEC_MONUMENT]   = GET_CVIMAPBACK_IMAGE(BUNDLE_VI_MAP_BACK_FILE_RESOURCES_BB_VI_MAP_BACK_ISLAND_DEC_MONUMENT_VMC)
};

static const u16 mapBackDecorSpriteAnimator[] = { [CVIMAPBACK_DECORSPRITE_RADIO_TOWER]          = CVIMAPBACK_DECORSPRITE_ANIM_RADIO_TOWER,
                                                  [CVIMAPBACK_DECORSPRITE_BALLOON]              = CVIMAPBACK_DECORSPRITE_ANIM_BALLOON,
                                                  [CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH]     = CVIMAPBACK_DECORSPRITE_ANIM_WATERFALL_SPLASH,
                                                  [CVIMAPBACK_DECORSPRITE_PALM_TREE_1]          = CVIMAPBACK_DECORSPRITE_ANIM_PALM_TREE,
                                                  [CVIMAPBACK_DECORSPRITE_PALM_TREE_2]          = CVIMAPBACK_DECORSPRITE_ANIM_PALM_TREE,
                                                  [CVIMAPBACK_DECORSPRITE_PALM_TREE_3]          = CVIMAPBACK_DECORSPRITE_ANIM_PALM_TREE,
                                                  [CVIMAPBACK_DECORSPRITE_SEAGULL]              = CVIMAPBACK_DECORSPRITE_ANIM_SEAGULL,
                                                  [CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM]        = CVIMAPBACK_DECORSPRITE_ANIM_VOLCANO_STEAM,
                                                  [CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL]       = CVIMAPBACK_DECORSPRITE_ANIM_SMALL_WINDMILL,
                                                  [CVIMAPBACK_DECORSPRITE_DINOSAUR]             = CVIMAPBACK_DECORSPRITE_ANIM_DINOSAUR,
                                                  [CVIMAPBACK_DECORSPRITE_FLAG]                 = CVIMAPBACK_DECORSPRITE_ANIM_FLAG,
                                                  [CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL]       = CVIMAPBACK_DECORSPRITE_ANIM_LARGE_WINDMILL,
                                                  [CVIMAPBACK_DECORSPRITE_WHALE]                = CVIMAPBACK_DECORSPRITE_ANIM_WHALE,
                                                  [CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN]        = CVIMAPBACK_DECORSPRITE_ANIM_FLOWER_GARDEN,
                                                  [CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN] = CVIMAPBACK_DECORSPRITE_ANIM_PRETTY_FLOWER_GARDEN };

static const u16 mapBackDecorID[] = { /*[CVIMAP_DECOR_DOCK_BEACH]           =*/CVIMAPBACK_DECORBG_DOCK_BEACH,
                                      /*[CVIMAP_DECOR_WATERFALL]            =*/CVIMAPBACK_DECORBG_DEC_WATERFALL,
                                      /*[CVIMAP_DECOR_LIGHTHOUSE]           =*/CVIMAPBACK_DECORBG_DEC_LIGHTHOUSE,
                                      /*[CVIMAP_DECOR_LAVA]                 =*/CVIMAPBACK_DECORBG_DEC_LAVA,
                                      /*[CVIMAP_DECOR_WATCHTOWER]           =*/CVIMAPBACK_DECORBG_DEC_WATCHTOWER,
                                      /*[CVIMAP_DECOR_STATUE]               =*/CVIMAPBACK_DECORBG_DEC_STATUE,
                                      /*[CVIMAP_DECOR_MONUMENT]             =*/CVIMAPBACK_DECORBG_DEC_MONUMENT,
                                      /*[CVIMAP_DECOR_RADIO_TOWER]          =*/CVIMAPBACK_DECORSPRITE_RADIO_TOWER,
                                      /*[CVIMAP_DECOR_BALLOON]              =*/CVIMAPBACK_DECORSPRITE_BALLOON,
                                      /*[CVIMAP_DECOR_WATERFALL_SPLASH]     =*/CVIMAPBACK_DECORSPRITE_WATERFALL_SPLASH,
                                      /*[CVIMAP_DECOR_PALM_TREE_1]          =*/CVIMAPBACK_DECORSPRITE_PALM_TREE_1,
                                      /*[CVIMAP_DECOR_PALM_TREE_2]          =*/CVIMAPBACK_DECORSPRITE_PALM_TREE_2,
                                      /*[CVIMAP_DECOR_PALM_TREE_3]          =*/CVIMAPBACK_DECORSPRITE_PALM_TREE_3,
                                      /*[CVIMAP_DECOR_SEAGULL]              =*/CVIMAPBACK_DECORSPRITE_SEAGULL,
                                      /*[CVIMAP_DECOR_VOLCANO_STEAM]        =*/CVIMAPBACK_DECORSPRITE_VOLCANO_STEAM,
                                      /*[CVIMAP_DECOR_SMALL_WINDMILL]       =*/CVIMAPBACK_DECORSPRITE_SMALL_WINDMILL,
                                      /*[CVIMAP_DECOR_DINOSAUR]             =*/CVIMAPBACK_DECORSPRITE_DINOSAUR,
                                      /*[CVIMAP_DECOR_FLAG]                 =*/CVIMAPBACK_DECORSPRITE_FLAG,
                                      /*[CVIMAP_DECOR_LARGE_WINDMILL]       =*/CVIMAPBACK_DECORSPRITE_LARGE_WINDMILL,
                                      /*[CVIMAP_DECOR_WHALE]                =*/CVIMAPBACK_DECORSPRITE_WHALE,
                                      /*[CVIMAP_DECOR_FLOWER_GARDEN]        =*/CVIMAPBACK_DECORSPRITE_FLOWER_GARDEN,
                                      /*[CVIMAP_DECOR_PRETTY_FLOWER_GARDEN] =*/CVIMAPBACK_DECORSPRITE_PRETTY_FLOWER_GARDEN };

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

static const CViMapBackDecorConfig mapBackDecorSpriteConfig[] = {
    [CVIMAPBACK_DECORSPRITE_ANIM_RADIO_TOWER]          = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_RADIO_TOWER },
    [CVIMAPBACK_DECORSPRITE_ANIM_BALLOON]              = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_BALLOON },
    [CVIMAPBACK_DECORSPRITE_ANIM_WATERFALL_SPLASH]     = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_WATERFALL_SPLASH },
    [CVIMAPBACK_DECORSPRITE_ANIM_PALM_TREE]            = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_PALM_TREE },
    [CVIMAPBACK_DECORSPRITE_ANIM_SEAGULL]              = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_SEAGULL_GLIDE },
    [CVIMAPBACK_DECORSPRITE_ANIM_VOLCANO_STEAM]        = { .flags = CVIMAPDECOR_FLAG_TRANSPARENT, .animID = CVIMAPDECOR_ANI_VOLCANO_STEAM },
    [CVIMAPBACK_DECORSPRITE_ANIM_SMALL_WINDMILL]       = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_SMALL_WINDMILL },
    [CVIMAPBACK_DECORSPRITE_ANIM_DINOSAUR]             = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_DINOSAUR },
    [CVIMAPBACK_DECORSPRITE_ANIM_FLAG]                 = { .flags = CVIMAPDECOR_FLAG_NONE, .animID = CVIMAPDECOR_ANI_FLAG },
    [CVIMAPBACK_DECORSPRITE_ANIM_LARGE_WINDMILL]       = { .flags = CVIMAPDECOR_FLAG_USE_SUB_OBJ, .animID = CVIMAPDECOR_ANI_LARGE_WINDMILL },
    [CVIMAPBACK_DECORSPRITE_ANIM_WHALE]                = { .flags = CVIMAPDECOR_FLAG_USE_SUB_OBJ, .animID = CVIMAPDECOR_ANI_WHALE },
    [CVIMAPBACK_DECORSPRITE_ANIM_FLOWER_GARDEN]        = { .flags = CVIMAPDECOR_FLAG_USE_SUB_OBJ, .animID = CVIMAPDECOR_ANI_FLOWER_GARDEN },
    [CVIMAPBACK_DECORSPRITE_ANIM_PRETTY_FLOWER_GARDEN] = { .flags = CVIMAPDECOR_FLAG_USE_SUB_OBJ, .animID = CVIMAPDECOR_ANI_PRETTY_FLOWER_GARDEN },
};

static const CViDockPreviewConfig dockPreviewConfig[] = {
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
        .mapArea             = MAPAREA_JET,
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
        .mapArea             = MAPAREA_BOAT,
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
        .mapArea             = MAPAREA_HOVER,
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
        .mapArea             = MAPAREA_SUBMARINE,
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
        .mapArea             = MAPAREA_DRILL,
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
                                              .mapArea             = MAPAREA_JET,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .unknown             = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_JET) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                              .mapArea             = MAPAREA_JET,
                                              .shipScale           = FLOAT_TO_FX32(0.0),
                                              .shipPosY            = FLOAT_TO_FX32(0.0),
                                              .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                              .msgSeqShipCompleted = 0,
                                              .materialCount       = 3,
                                              .unknown             = 0,
                                              .materials           = { SAVE_MATERIAL_BLUE, SAVE_MATERIAL_IRON, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .mapArea             = MAPAREA_BOAT,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .unknown             = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_BOAT) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                               .mapArea             = MAPAREA_BOAT,
                                               .shipScale           = FLOAT_TO_FX32(0.0),
                                               .shipPosY            = FLOAT_TO_FX32(0.0),
                                               .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                               .msgSeqShipCompleted = 0,
                                               .materialCount       = 3,
                                               .unknown             = 0,
                                               .materials           = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_BLACK, 0, 0, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .mapArea             = MAPAREA_HOVER,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .unknown             = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_HOVER) + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                                .mapArea             = MAPAREA_HOVER,
                                                .shipScale           = FLOAT_TO_FX32(0.0),
                                                .shipPosY            = FLOAT_TO_FX32(0.0),
                                                .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                                .msgSeqShipCompleted = 0,
                                                .materialCount       = 5,
                                                .unknown             = 0,
                                                .materials = { SAVE_MATERIAL_GREEN, SAVE_MATERIAL_BRONZE, SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_1 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .mapArea             = MAPAREA_SUBMARINE,
                                  .shipScale           = FLOAT_TO_FX32(0.0),
                                  .shipPosY            = FLOAT_TO_FX32(0.0),
                                  .rotationX           = FLOAT_DEG_TO_IDX(0.0),
                                  .msgSeqShipCompleted = 0,
                                  .materialCount       = 5,
                                  .unknown             = 0,
                                  .materials           = { SAVE_MATERIAL_RED, SAVE_MATERIAL_SILVER, SAVE_MATERIAL_AQUA, SAVE_MATERIAL_GOLD, SAVE_MATERIAL_BLACK, 0, 0, 0 } },

    [(2 * SHIP_SUBMARINE)
        + (SHIP_LEVEL_2 - 1)] = { .dockArea            = DOCKAREA_INVALID,
                                  .mapArea             = MAPAREA_SUBMARINE,
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
                        .allowTalkNpcCameraMove        = FALSE,
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
                             .allowTalkNpcCameraMove        = FALSE,
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
                       .allowTalkNpcCameraMove        = TRUE,
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
                        .allowTalkNpcCameraMove        = TRUE,
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
                         .allowTalkNpcCameraMove        = TRUE,
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
                             .allowTalkNpcCameraMove        = TRUE,
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
                         .allowTalkNpcCameraMove        = TRUE,
                         .scale          = FLOAT_TO_FX32(1.0), },

    // No stage for DOCKAREA_DRILL
};

static const CViMapAreaIconConfig mapAreaIconConfig[] = {
    [MAPAREA_BASE] = 
    {
        .position           = { 144, 148 },
        .dockArea           = DOCKAREA_BASE,
        .previewDockArea    = MAPAREA_BASE,
        .nextArea_Left      = { MAPAREA_HOVER, MAPAREA_SUBMARINE, MAPAREA_BEACH },
        .nextArea_Up        = { MAPAREA_DRILL, MAPAREA_SUBMARINE, MAPAREA_TUTORIAL },
        .nextArea_Right     = { MAPAREA_BOAT, MAPAREA_TUTORIAL, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .dockImageID        = CVIMAPBACK_DECORBG_BASE,
    },

    [MAPAREA_JET] = 
    {
        .position           = { 120, 212 },
        .dockArea           = DOCKAREA_JET,
        .previewDockArea    = MAPAREA_JET,
        .nextArea_Left      = { MAPAREA_BEACH, MAPAREA_HOVER, MAPAREA_SUBMARINE },
        .nextArea_Up        = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_BOAT, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .dockImageID        = CVIMAPBACK_DECORBG_DOCK_JET,
    },

    [MAPAREA_BOAT] = 
    {
        .position           = { 260, 190 },
        .dockArea           = DOCKAREA_BOAT,
        .previewDockArea    = MAPAREA_BOAT,
        .nextArea_Left      = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_TUTORIAL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .dockImageID        = CVIMAPBACK_DECORBG_DOCK_BOAT,
    },

    [MAPAREA_HOVER] = 
    {
        .position           = { 60, 158 },
        .dockArea           = DOCKAREA_HOVER,
        .previewDockArea    = MAPAREA_HOVER,
        .nextArea_Left      = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_SUBMARINE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_BEACH, MAPAREA_JET, MAPAREA_INVALID },
        .dockImageID        = CVIMAPBACK_DECORBG_DOCK_HOVER,
    },

    [MAPAREA_SUBMARINE] = 
    {
        .position           = { 80, 100 },
        .dockArea           = DOCKAREA_SUBMARINE,
        .previewDockArea    = MAPAREA_SUBMARINE,
        .nextArea_Left      = { MAPAREA_HOVER, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_DRILL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_DRILL, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_HOVER, MAPAREA_BASE, MAPAREA_JET },
        .dockImageID        = CVIMAPBACK_DECORBG_DOCK_SUBMARINE,
    },

    [MAPAREA_BEACH] = 
    {
        .position           = { 44, 204 },
        .dockArea           = DOCKAREA_BEACH,
        .previewDockArea    = MAPAREA_BEACH,
        .nextArea_Left      = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_HOVER, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_JET, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_JET, MAPAREA_INVALID, MAPAREA_INVALID },
        .dockImageID        = CVIEVTCMN_RESOURCE_NONE,
    },

    [MAPAREA_DRILL] = 
    {
        .position           = { 154, 80 },
        .dockArea           = DOCKAREA_COUNT,
        .previewDockArea    = MAPAREA_DRILL,
        .nextArea_Left      = { MAPAREA_SUBMARINE, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_TUTORIAL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_BASE, MAPAREA_INVALID, MAPAREA_INVALID },
        .dockImageID        = CVIMAPBACK_DECORBG_DOCK_DRILL,
    },

    [MAPAREA_TUTORIAL] = 
    {
        .position           = { 276, 104 },
        .dockArea           = DOCKAREA_COUNT,
        .previewDockArea    = MAPAREA_TUTORIAL,
        .nextArea_Left      = { MAPAREA_DRILL, MAPAREA_BASE, MAPAREA_INVALID },
        .nextArea_Up        = { MAPAREA_DRILL, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Right     = { MAPAREA_INVALID, MAPAREA_INVALID, MAPAREA_INVALID },
        .nextArea_Down      = { MAPAREA_BOAT, MAPAREA_BASE, MAPAREA_INVALID },
        .dockImageID        = CVIEVTCMN_RESOURCE_NONE,
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

const CViDockPreviewConfig *HubConfig__GetDockPreviewConfig(u16 area)
{
    return &dockPreviewConfig[area];
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

const u16 *HubConfig__GetMapBackDecorID(u16 id)
{
    return &mapBackDecorID[id];
}

const u16 *HubConfig__GetMapBackDecorBackgroundConfig(u16 id)
{
    return &mapBackDecorBackgroundConfig[id];
}

const u16 *HubConfig__GetMapBackDecorSpriteAnimator(u16 id)
{
    return &mapBackDecorSpriteAnimator[id];
}

const CViMapBackDecorConfig *HubConfig__GetMapBackDecorSpriteConfig(u16 id)
{
    return &mapBackDecorSpriteConfig[id];
}

// Island, Base, or any of the ship docks
BOOL HubConfig__CheckDecorConstructionIsBackground(u16 id)
{
    return id <= CVIMAP_DECOR_MONUMENT;
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