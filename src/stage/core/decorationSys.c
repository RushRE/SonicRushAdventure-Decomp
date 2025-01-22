#include <stage/core/decorationSys.h>
#include <game/stage/eventManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>

// Effects
#include <stage/effectTask.h>
#include <stage/effects/coralDebris.h>
#include <stage/effects/bridgeDebris.h>
#include <stage/effects/iceSparkles.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/waterWake.h>

// --------------------
// ENUMS
// --------------------

enum DecorationFlags_
{
    DECOR_FLAG_NONE = 0x00,

    DECOR_FLAG_FLIP_X        = (1 << 0),
    DECOR_FLAG_FLIP_Y        = (1 << 1),
    DECOR_FLAG_4             = (1 << 2),
    DECOR_FLAG_LOW_PRIORITY  = (1 << 3),
    DECOR_FLAG_10            = (1 << 4),
    DECOR_FLAG_HIGH_PRIORITY = (1 << 5),
    DECOR_FLAG_40            = (1 << 6),
    DECOR_FLAG_PREPEND       = (1 << 7),
};
typedef u8 DecorationFlags;

enum DecorationDrawOrder_
{
    DECOR_DRAWORDER_25 = 0,
    DECOR_DRAWORDER_26 = 1,

    DECOR_DRAWORDER_NONE = 0xFF,
};
typedef u8 DecorationDrawOrder;

enum DecorationAssets
{
    DECOR_ASSET_Flipmush,
    DECOR_ASSET_Grass,
    DECOR_ASSET_Flw,
    DECOR_ASSET_Kinoko,
    DECOR_ASSET_Kinoko2,
    DECOR_ASSET_Palm,
    DECOR_ASSET_PipeFlw,
    DECOR_ASSET_Water,
    DECOR_ASSET_Suimen,
    DECOR_ASSET_BigLeaf,
    DECOR_ASSET_FlwTubo,
    DECOR_ASSET_Mo,
    DECOR_ASSET_GstTree,
    DECOR_ASSET_Cloud,
    DECOR_ASSET_SteamPipe,
    DECOR_ASSET_Decopipe,
    DECOR_ASSET_Chimney,
    DECOR_ASSET_Coral,
    DECOR_ASSET_Boat,
    DECOR_ASSET_Cannon,
    DECOR_ASSET_Mast,
    DECOR_ASSET_Rudder,
    DECOR_ASSET_Rope,
    DECOR_ASSET_AnchorRope3D,
    DECOR_ASSET_Barrel,
    DECOR_ASSET_Sail,
    DECOR_ASSET_Trampoline,
    DECOR_ASSET_Saku,
    DECOR_ASSET_Icicle,
    DECOR_ASSET_IceTree,
    DECOR_ASSET_Thunder,
    DECOR_ASSET_CloudSt6,
    DECOR_ASSET_Grass6,
    DECOR_ASSET_FallingWater,
    DECOR_ASSET_LeafWater,
    DECOR_ASSET_KojimaPalm,

    DECOR_ASSET_COUNT,
};

// --------------------
// STRUCTS
// --------------------

struct Unknown2189EAC
{
    StageDecoration *lastDecor;
    s16 timer;
    u16 lastType;
};

struct DecorAsset
{
    const char *path;
    u16 fileID;
};

struct DecorConfig
{
    u8 assetID;
    DecorationFlags flags;
    u8 animID;
    u8 animID2;
    u8 animFlags2;
    DecorationDrawOrder oamOrder;
    u8 spriteID;
    u8 type;
};

struct DecorRect
{
    s8 left;
    s8 top;
    s8 right;
    s8 bottom;
};

// --------------------
// VARIABLES
// --------------------

static DecorationSys *DecorationSys__WorkSingleton;

NOT_DECOMPILED u32 DecorationSys__TempDecorBitfield[(STAGEDECOR_TEMPLIST_SIZE + (32 - 1)) / 32];
NOT_DECOMPILED struct Unknown2189EAC decorUnknownList[4];
NOT_DECOMPILED MapDecor DecorationSys__TempDecorList[STAGEDECOR_TEMPLIST_SIZE];
NOT_DECOMPILED OBS_DATA_WORK decorFileList[20];
NOT_DECOMPILED OBS_SPRITE_REF decorSpriteRefList[55];

NOT_DECOMPILED void *DecorationSys__rangeTable;
NOT_DECOMPILED void *DecorationSys__offsetTable;
NOT_DECOMPILED struct DecorRect DecorationSys__rectList[11];
NOT_DECOMPILED void (*DecorationSys__initTable[11])(StageDecoration *work);
NOT_DECOMPILED void *_021876CC;
NOT_DECOMPILED void *_021876D4;

NOT_DECOMPILED const struct DecorAsset decorAssets[DECOR_ASSET_COUNT];

/*
static const struct DecorAsset decorAssets[DECOR_ASSET_COUNT] = {
    [DECOR_ASSET_Flipmush]     = { .path = "/act/ac_gmk_flipmush.bac", .fileID = 0 },
    [DECOR_ASSET_Grass]        = { .path = "/act/ac_dec_grass.bac", .fileID = 1 },
    [DECOR_ASSET_Flw]          = { .path = "/act/ac_dec_flw.bac", .fileID = 2 },
    [DECOR_ASSET_Kinoko]       = { .path = "/act/ac_dec_kinoko.bac", .fileID = 3 },
    [DECOR_ASSET_Kinoko2]      = { .path = "/act/ac_dec_kinoko2.bac", .fileID = 4 },
    [DECOR_ASSET_Palm]         = { .path = "/act/ac_dec_palm.bac", .fileID = 5 },
    [DECOR_ASSET_PipeFlw]      = { .path = "/act/ac_dec_pipe_flw.bac", .fileID = 6 },
    [DECOR_ASSET_Water]        = { .path = "/act/ac_eff_water.bac", .fileID = 7 },
    [DECOR_ASSET_Suimen]       = { .path = "/act/ac_dec_suimen.bac", .fileID = 8 },
    [DECOR_ASSET_BigLeaf]      = { .path = "/act/ac_dec_big_leaf.bac", .fileID = 9 },
    [DECOR_ASSET_FlwTubo]      = { .path = "/act/ac_dec_flw_tubo.bac", .fileID = 10 },
    [DECOR_ASSET_Mo]           = { .path = "/act/ac_dec_mo.bac", .fileID = 11 },
    [DECOR_ASSET_GstTree]      = { .path = "/act/ac_dec_gst_tree.bac", .fileID = 12 },
    [DECOR_ASSET_Cloud]        = { .path = "/act/ac_dec_cloud.bac", .fileID = 13 },
    [DECOR_ASSET_SteamPipe]    = { .path = "/act/ac_dec_pipe_steam.bac", .fileID = 0 },
    [DECOR_ASSET_Decopipe]     = { .path = "/act/ac_dec_decopipe.bac", .fileID = 1 },
    [DECOR_ASSET_Chimney]      = { .path = "/act/ac_dec_chimney.bac", .fileID = 2 },
    [DECOR_ASSET_Coral]        = { .path = "/act/ac_dec_coral.bac", .fileID = 0 },
    [DECOR_ASSET_Boat]         = { .path = "/act/ac_dec_boat.bac", .fileID = 0 },
    [DECOR_ASSET_Cannon]       = { .path = "/act/ac_dec_cannon.bac", .fileID = 1 },
    [DECOR_ASSET_Mast]         = { .path = "/act/ac_dec_mast.bac", .fileID = 2 },
    [DECOR_ASSET_Rudder]       = { .path = "/act/ac_dec_rudder.bac", .fileID = 3 },
    [DECOR_ASSET_Rope]         = { .path = "/act/ac_dec_rope.bac", .fileID = 4 },
    [DECOR_ASSET_AnchorRope3D] = { .path = "/act/ac_dec_anchor_rope3d.bac", .fileID = 5 },
    [DECOR_ASSET_Barrel]       = { .path = "/act/ac_gmk_barrel.bac", .fileID = 6 },
    [DECOR_ASSET_Sail]         = { .path = "/act/ac_dec_sail.bac", .fileID = 7 },
    [DECOR_ASSET_Trampoline]   = { .path = "/act/ac_dec_trampoline.bac", .fileID = 8 },
    [DECOR_ASSET_Saku]         = { .path = "/act/ac_dec_saku.bac", .fileID = 9 },
    [DECOR_ASSET_Icicle]       = { .path = "/act/ac_dec_icicle.bac", .fileID = 0 },
    [DECOR_ASSET_IceTree]      = { .path = "/act/ac_dec_ice_tree.bac", .fileID = 1 },
    [DECOR_ASSET_Thunder]      = { .path = "/act/ac_dec_thunder.bac", .fileID = 0 },
    [DECOR_ASSET_CloudSt6]     = { .path = "/act/ac_dec_cloud_st6.bac", .fileID = 1 },
    [DECOR_ASSET_Grass6]       = { .path = "/act/ac_dec_grass6.bac", .fileID = 2 },
    [DECOR_ASSET_FallingWater] = { .path = "/act/ac_dec_falling_water.bac", .fileID = 0 },
    [DECOR_ASSET_LeafWater]    = { .path = "/act/ac_dec_leaf_water.bac", .fileID = 1 },
    [DECOR_ASSET_KojimaPalm]   = { .path = "/act/ac_dec_kojima_palm.bac", .fileID = 0 },
};
*/

static const struct DecorConfig decorInfo[MAPDECOR_COUNT] = {
    [MAPDECOR_0] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_1] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_2] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_3] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_4] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_5] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_6] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_7] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_8] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_9] = { .assetID    = DECOR_ASSET_Flipmush,
                     .flags      = DECOR_FLAG_NONE,
                     .animID     = 1,
                     .animID2    = 1,
                     .animFlags2 = 0x80,
                     .oamOrder   = DECOR_DRAWORDER_25,
                     .spriteID   = 0,
                     .type       = 0 },

    [MAPDECOR_10] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_11] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_12] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_13] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_14] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_15] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x80,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_16] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x0E,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0,
                      .type       = 0 },

    [MAPDECOR_17] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x0E,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 1,
                      .type       = 0 },

    [MAPDECOR_18] = { .assetID    = DECOR_ASSET_Flipmush,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x0E,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 1,
                      .type       = 0 },

    [MAPDECOR_19] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 2,
                      .type       = 0 },

    [MAPDECOR_20] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 2,
                      .type       = 0 },

    [MAPDECOR_21] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 3,
                      .type       = 0 },

    [MAPDECOR_22] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 3,
                      .type       = 0 },

    [MAPDECOR_23] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 4,
                      .type       = 0 },

    [MAPDECOR_24] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 4,
                      .type       = 0 },

    [MAPDECOR_25] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 5,
                      .type       = 0 },

    [MAPDECOR_26] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 5,
                      .type       = 0 },

    [MAPDECOR_27] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 6,
                      .type       = 0 },

    [MAPDECOR_28] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 6,
                      .type       = 0 },

    [MAPDECOR_29] = { .assetID    = DECOR_ASSET_Flw,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x10,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 7,
                      .type       = 0 },

    [MAPDECOR_30] = { .assetID    = DECOR_ASSET_Flw,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x10,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 7,
                      .type       = 0 },

    [MAPDECOR_31] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x12,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 8,
                      .type       = 0 },

    [MAPDECOR_32] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x12,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 9,
                      .type       = 0 },

    [MAPDECOR_33] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x12,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xA,
                      .type       = 0 },

    [MAPDECOR_34] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xB,
                      .type       = 0 },

    [MAPDECOR_35] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xB,
                      .type       = 0 },

    [MAPDECOR_36] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xC,
                      .type       = 0 },

    [MAPDECOR_37] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xC,
                      .type       = 0 },

    [MAPDECOR_38] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xD,
                      .type       = 0 },

    [MAPDECOR_39] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xD,
                      .type       = 0 },

    [MAPDECOR_40] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xE,
                      .type       = 0 },

    [MAPDECOR_41] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xE,
                      .type       = 0 },

    [MAPDECOR_42] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xF,
                      .type       = 0 },

    [MAPDECOR_43] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xF,
                      .type       = 0 },

    [MAPDECOR_44] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x10,
                      .type       = 0 },

    [MAPDECOR_45] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x11,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x10,
                      .type       = 0 },

    [MAPDECOR_46] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x11,
                      .type       = 0 },

    [MAPDECOR_47] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x11,
                      .type       = 0 },

    [MAPDECOR_48] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_26,
                      .spriteID   = 0x12,
                      .type       = 0 },

    [MAPDECOR_49] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_26,
                      .spriteID   = 0x12,
                      .type       = 0 },

    [MAPDECOR_50] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x13,
                      .type       = 0 },

    [MAPDECOR_51] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_26,
                      .spriteID   = 0x13,
                      .type       = 0 },

    [MAPDECOR_52] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x14,
                      .type       = 0 },

    [MAPDECOR_53] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x14,
                      .type       = 0 },

    [MAPDECOR_54] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x15,
                      .type       = 0 },

    [MAPDECOR_55] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x15,
                      .type       = 0 },

    [MAPDECOR_56] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x16,
                      .type       = 0 },

    [MAPDECOR_57] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x16,
                      .type       = 0 },

    [MAPDECOR_58] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 0x17,
                      .type       = 0 },

    [MAPDECOR_59] = { .assetID    = DECOR_ASSET_PipeFlw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x09,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 0x17,
                      .type       = 0 },

    [MAPDECOR_60] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x18,
                      .type       = 0 },

    [MAPDECOR_61] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x18,
                      .type       = 0 },

    [MAPDECOR_62] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 6,
                      .animID2    = 6,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x19,
                      .type       = 0 },

    [MAPDECOR_63] = { .assetID    = DECOR_ASSET_Grass,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 6,
                      .animID2    = 6,
                      .animFlags2 = 0x0F,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x19,
                      .type       = 0 },

    [MAPDECOR_64] = { .assetID    = DECOR_ASSET_Water,
                      .flags      = DECOR_FLAG_40,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x21,
                      .oamOrder   = DECOR_DRAWORDER_NONE,
                      .spriteID   = 0x1A,
                      .type       = 10 },

    [MAPDECOR_65] = { .assetID    = DECOR_ASSET_Suimen,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x16,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1B,
                      .type       = 0 },

    [MAPDECOR_66] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1C,
                      .type       = 0 },

    [MAPDECOR_67] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1D,
                      .type       = 0 },

    [MAPDECOR_68] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1E,
                      .type       = 0 },

    [MAPDECOR_69] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1E,
                      .type       = 0 },

    [MAPDECOR_70] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1F,
                      .type       = 0 },

    [MAPDECOR_71] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x1F,
                      .type       = 0 },

    [MAPDECOR_72] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x20,
                      .type       = 0 },

    [MAPDECOR_73] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x20,
                      .type       = 0 },

    [MAPDECOR_74] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x21,
                      .type       = 0 },

    [MAPDECOR_75] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 5,
                      .animID2    = 5,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x21,
                      .type       = 0 },

    [MAPDECOR_76] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 6,
                      .animID2    = 6,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x22,
                      .type       = 0 },

    [MAPDECOR_77] = { .assetID    = DECOR_ASSET_BigLeaf,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 6,
                      .animID2    = 6,
                      .animFlags2 = 0x18,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x22,
                      .type       = 0 },

    [MAPDECOR_78] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x23,
                      .type       = 0 },

    [MAPDECOR_79] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 2,
                      .animID2    = 2,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x24,
                      .type       = 0 },

    [MAPDECOR_80] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 3,
                      .animID2    = 3,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x25,
                      .type       = 0 },

    [MAPDECOR_81] = { .assetID    = DECOR_ASSET_Palm,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 4,
                      .animID2    = 4,
                      .animFlags2 = 0x13,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x26,
                      .type       = 0 },

    [MAPDECOR_82] = { .assetID    = DECOR_ASSET_Flw,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x10,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x27,
                      .type       = 0 },

    [MAPDECOR_83] = { .assetID    = DECOR_ASSET_Flw,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 1,
                      .animID2    = 1,
                      .animFlags2 = 0x10,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x27,
                      .type       = 0 },

    [MAPDECOR_84] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xB,
                      .type       = 0 },

    [MAPDECOR_85] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xB,
                      .type       = 0 },

    [MAPDECOR_86] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xD,
                      .type       = 0 },

    [MAPDECOR_87] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 2,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xD,
                      .type       = 0 },

    [MAPDECOR_88] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 4,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xF,
                      .type       = 0 },

    [MAPDECOR_89] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 4,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xF,
                      .type       = 0 },

    [MAPDECOR_90] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 5,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x10,
                      .type       = 0 },

    [MAPDECOR_91] = { .assetID    = DECOR_ASSET_Kinoko,
                      .flags      = DECOR_FLAG_FLIP_X,
                      .animID     = 5,
                      .animID2    = 6,
                      .animFlags2 = 0x19,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x10,
                      .type       = 0 },

    [MAPDECOR_92] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 3,
                      .animFlags2 = 0x1A,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 8,
                      .type       = 0 },

    [MAPDECOR_93] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 3,
                      .animFlags2 = 0x1A,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 9,
                      .type       = 0 },

    [MAPDECOR_94] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 3,
                      .animFlags2 = 0x1A,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xA,
                      .type       = 0 },

    [MAPDECOR_95] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 0,
                      .animID2    = 4,
                      .animFlags2 = 0x1B,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 8,
                      .type       = 0 },

    [MAPDECOR_96] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 1,
                      .animID2    = 4,
                      .animFlags2 = 0x1B,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 9,
                      .type       = 0 },

    [MAPDECOR_97] = { .assetID    = DECOR_ASSET_Kinoko2,
                      .flags      = DECOR_FLAG_NONE,
                      .animID     = 2,
                      .animID2    = 4,
                      .animFlags2 = 0x1B,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0xA,
                      .type       = 0 },

    [MAPDECOR_98] = { .assetID    = DECOR_ASSET_FlwTubo,
                      .flags      = DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x1C,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x28,
                      .type       = 0 },

    [MAPDECOR_99] = { .assetID    = DECOR_ASSET_FlwTubo,
                      .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                      .animID     = 0,
                      .animID2    = 0,
                      .animFlags2 = 0x1C,
                      .oamOrder   = DECOR_DRAWORDER_25,
                      .spriteID   = 0x28,
                      .type       = 0 },

    [MAPDECOR_100] = { .assetID    = DECOR_ASSET_FlwTubo,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x1C,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x29,
                       .type       = 0 },

    [MAPDECOR_101] = { .assetID    = DECOR_ASSET_FlwTubo,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x1C,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2A,
                       .type       = 0 },

    [MAPDECOR_102] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 4,
                       .animFlags2 = 0x1D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_103] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 4,
                       .animFlags2 = 0x1D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_104] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 4,
                       .animFlags2 = 0x1D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_105] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_10,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2B,
                       .type       = 0 },

    [MAPDECOR_106] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_10,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2C,
                       .type       = 0 },

    [MAPDECOR_107] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_10,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2D,
                       .type       = 0 },

    [MAPDECOR_108] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_LOW_PRIORITY | DECOR_FLAG_10,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2B,
                       .type       = 0 },

    [MAPDECOR_109] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_LOW_PRIORITY | DECOR_FLAG_10,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2C,
                       .type       = 0 },

    [MAPDECOR_110] = { .assetID    = DECOR_ASSET_Mo,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_LOW_PRIORITY | DECOR_FLAG_10,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x0A,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2D,
                       .type       = 0 },

    [MAPDECOR_111] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x00,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_112] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_113] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_114] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_115] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_116] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_117] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_118] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 6,
                       .animID2    = 6,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_119] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_120] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 8,
                       .animID2    = 8,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 8,
                       .type       = 0 },

    [MAPDECOR_121] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 9,
                       .animID2    = 9,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 9,
                       .type       = 0 },

    [MAPDECOR_122] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 10,
                       .animID2    = 10,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xA,
                       .type       = 0 },

    [MAPDECOR_123] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 11,
                       .animID2    = 11,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 0 },

    [MAPDECOR_124] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 12,
                       .animID2    = 12,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 0 },

    [MAPDECOR_125] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 13,
                       .animID2    = 13,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 0 },

    [MAPDECOR_126] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 14,
                       .animID2    = 14,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 0 },

    [MAPDECOR_127] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 15,
                       .animID2    = 15,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xF,
                       .type       = 0 },

    [MAPDECOR_128] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2E,
                       .type       = 0 },

    [MAPDECOR_129] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2E,
                       .type       = 0 },

    [MAPDECOR_130] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2F,
                       .type       = 0 },

    [MAPDECOR_131] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x2F,
                       .type       = 0 },

    [MAPDECOR_132] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x30,
                       .type       = 0 },

    [MAPDECOR_133] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x30,
                       .type       = 0 },

    [MAPDECOR_134] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x31,
                       .type       = 3 },

    [MAPDECOR_135] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x31,
                       .type       = 3 },

    [MAPDECOR_136] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x32,
                       .type       = 0 },

    [MAPDECOR_137] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x32,
                       .type       = 0 },

    [MAPDECOR_138] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x10,
                       .type       = 0 },

    [MAPDECOR_139] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x11,
                       .type       = 0 },

    [MAPDECOR_140] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x12,
                       .type       = 0 },

    [MAPDECOR_141] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x13,
                       .type       = 0 },

    [MAPDECOR_142] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x14,
                       .type       = 0 },

    [MAPDECOR_143] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x14,
                       .type       = 0 },

    [MAPDECOR_144] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_Y | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x14,
                       .type       = 0 },

    [MAPDECOR_145] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_FLIP_Y | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x14,
                       .type       = 0 },

    [MAPDECOR_146] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x15,
                       .type       = 0 },

    [MAPDECOR_147] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x15,
                       .type       = 0 },

    [MAPDECOR_148] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 6,
                       .animID2    = 6,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x16,
                       .type       = 0 },

    [MAPDECOR_149] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_Y | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 6,
                       .animID2    = 6,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x16,
                       .type       = 0 },

    [MAPDECOR_150] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x17,
                       .type       = 0 },

    [MAPDECOR_151] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 8,
                       .animID2    = 8,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x18,
                       .type       = 0 },

    [MAPDECOR_152] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 11,
                       .animID2    = 11,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x19,
                       .type       = 0 },

    [MAPDECOR_153] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 11,
                       .animID2    = 11,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x19,
                       .type       = 0 },

    [MAPDECOR_154] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 12,
                       .animID2    = 12,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1A,
                       .type       = 0 },

    [MAPDECOR_155] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_Y | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 12,
                       .animID2    = 12,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1A,
                       .type       = 0 },

    [MAPDECOR_156] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 9,
                       .animID2    = 9,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1B,
                       .type       = 0 },

    [MAPDECOR_157] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_Y | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 9,
                       .animID2    = 9,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1B,
                       .type       = 0 },

    [MAPDECOR_158] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 10,
                       .animID2    = 10,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1C,
                       .type       = 0 },

    [MAPDECOR_159] = { .assetID    = DECOR_ASSET_Decopipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 10,
                       .animID2    = 10,
                       .animFlags2 = 0x2E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1C,
                       .type       = 0 },

    [MAPDECOR_160] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1D,
                       .type       = 0 },

    [MAPDECOR_161] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1E,
                       .type       = 0 },

    [MAPDECOR_162] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1F,
                       .type       = 0 },

    [MAPDECOR_163] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x1F,
                       .type       = 0 },

    [MAPDECOR_164] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x20,
                       .type       = 0 },

    [MAPDECOR_165] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x20,
                       .type       = 0 },

    [MAPDECOR_166] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x21,
                       .type       = 0 },

    [MAPDECOR_167] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x21,
                       .type       = 0 },

    [MAPDECOR_168] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x22,
                       .type       = 0 },

    [MAPDECOR_169] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 6,
                       .animID2    = 6,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x23,
                       .type       = 0 },

    [MAPDECOR_170] = { .assetID    = DECOR_ASSET_Chimney,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x2F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x24,
                       .type       = 0 },

    [MAPDECOR_171] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 7 },

    [MAPDECOR_172] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 7 },

    [MAPDECOR_173] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 7 },

    [MAPDECOR_174] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 7 },

    [MAPDECOR_175] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 7 },

    [MAPDECOR_176] = { .assetID    = DECOR_ASSET_Icicle,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x3D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 7 },

    [MAPDECOR_177] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x3F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 8 },

    [MAPDECOR_178] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x3F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 8 },

    [MAPDECOR_179] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 8 },

    [MAPDECOR_180] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x3E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 8 },

    [MAPDECOR_181] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x40,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_182] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x40,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_183] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x40,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_184] = { .assetID    = DECOR_ASSET_IceTree,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x40,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_185] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x41,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_186] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x41,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_187] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_188] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_189] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_190] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_191] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_192] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_193] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_194] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_195] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 1 },

    [MAPDECOR_196] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 1 },

    [MAPDECOR_197] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 3,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 1 },

    [MAPDECOR_198] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 3,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 1 },

    [MAPDECOR_199] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 1 },

    [MAPDECOR_200] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 4,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 1 },

    [MAPDECOR_201] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 5,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 1 },

    [MAPDECOR_202] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 5,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 1 },

    [MAPDECOR_203] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x44,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_204] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x44,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_205] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 8,
                       .animID2    = 8,
                       .animFlags2 = 0x44,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_206] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 8,
                       .animID2    = 8,
                       .animFlags2 = 0x44,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_207] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 9,
                       .animID2    = 9,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 8,
                       .type       = 0 },

    [MAPDECOR_208] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 9,
                       .animID2    = 9,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 8,
                       .type       = 0 },

    [MAPDECOR_209] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 10,
                       .animID2    = 10,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 9,
                       .type       = 0 },

    [MAPDECOR_210] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 10,
                       .animID2    = 10,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 9,
                       .type       = 0 },

    [MAPDECOR_211] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 11,
                       .animID2    = 11,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xA,
                       .type       = 0 },

    [MAPDECOR_212] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 11,
                       .animID2    = 11,
                       .animFlags2 = 0x45,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xA,
                       .type       = 0 },

    [MAPDECOR_213] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 12,
                       .animID2    = 12,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 0 },

    [MAPDECOR_214] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 12,
                       .animID2    = 12,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 0 },

    [MAPDECOR_215] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 13,
                       .animID2    = 13,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 0 },

    [MAPDECOR_216] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 13,
                       .animID2    = 13,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 0 },

    [MAPDECOR_217] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 12,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 1 },

    [MAPDECOR_218] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 12,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 1 },

    [MAPDECOR_219] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 13,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 1 },

    [MAPDECOR_220] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 13,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 1 },

    [MAPDECOR_221] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 14,
                       .animID2    = 14,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 0 },

    [MAPDECOR_222] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 14,
                       .animID2    = 14,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 0 },

    [MAPDECOR_223] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 15,
                       .animID2    = 15,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 0 },

    [MAPDECOR_224] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 15,
                       .animID2    = 15,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 0 },

    [MAPDECOR_225] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 14,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 1 },

    [MAPDECOR_226] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 14,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 1 },

    [MAPDECOR_227] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 15,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 1 },

    [MAPDECOR_228] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 15,
                       .animID2    = 6,
                       .animFlags2 = 0x43,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 1 },

    [MAPDECOR_229] = { .assetID    = DECOR_ASSET_Boat,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x46,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_230] = { .assetID    = DECOR_ASSET_Cannon,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x47,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_231] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_232] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_233] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_Y,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_234] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_FLIP_Y,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_235] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_236] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_237] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_Y,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_238] = { .assetID    = DECOR_ASSET_Mast,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_FLIP_Y,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_239] = { .assetID    = DECOR_ASSET_Rudder,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x49,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_240] = { .assetID    = DECOR_ASSET_Rope,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x48,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_241] = { .assetID    = DECOR_ASSET_AnchorRope3D,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x00,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_242] = { .assetID    = DECOR_ASSET_AnchorRope3D,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 0,
                       .animFlags2 = 0x01,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_243] = { .assetID    = DECOR_ASSET_AnchorRope3D,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 0,
                       .animFlags2 = 0x02,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 8,
                       .type       = 0 },

    [MAPDECOR_244] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 16,
                       .animID2    = 16,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_245] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 16,
                       .animID2    = 16,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_246] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 17,
                       .animID2    = 17,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_247] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 17,
                       .animID2    = 17,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_248] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 18,
                       .animID2    = 18,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_249] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 18,
                       .animID2    = 18,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_250] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_4,
                       .animID     = 19,
                       .animID2    = 19,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 0 },

    [MAPDECOR_251] = { .assetID    = DECOR_ASSET_Coral,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_4,
                       .animID     = 19,
                       .animID2    = 19,
                       .animFlags2 = 0x42,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xB,
                       .type       = 0 },

    [MAPDECOR_252] = { .assetID    = DECOR_ASSET_Barrel,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x5E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xC,
                       .type       = 0 },

    [MAPDECOR_253] = { .assetID    = DECOR_ASSET_Barrel,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x54,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xD,
                       .type       = 0 },

    [MAPDECOR_254] = { .assetID    = DECOR_ASSET_Sail,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x58,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 10 },

    [MAPDECOR_255] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xF,
                       .type       = 0 },

    [MAPDECOR_256] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xF,
                       .type       = 0 },

    [MAPDECOR_257] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x10,
                       .type       = 0 },

    [MAPDECOR_258] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x10,
                       .type       = 0 },

    [MAPDECOR_259] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_FLIP_Y,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x10,
                       .type       = 0 },

    [MAPDECOR_260] = { .assetID    = DECOR_ASSET_Trampoline,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_FLIP_Y,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x10,
                       .type       = 0 },

    [MAPDECOR_261] = { .assetID    = DECOR_ASSET_Cloud,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x60,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x33,
                       .type       = 2 },

    [MAPDECOR_262] = { .assetID    = DECOR_ASSET_Cloud,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x60,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x34,
                       .type       = 2 },

    [MAPDECOR_263] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_264] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 0 },

    [MAPDECOR_265] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 0 },

    [MAPDECOR_266] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 0 },

    [MAPDECOR_267] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 0 },

    [MAPDECOR_268] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_269] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 6,
                       .animID2    = 6,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_270] = { .assetID    = DECOR_ASSET_SteamPipe,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x26,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_271] = { .assetID    = DECOR_ASSET_Thunder,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x66,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 10 },

    [MAPDECOR_272] = { .assetID    = DECOR_ASSET_CloudSt6,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x06,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 5 },

    [MAPDECOR_273] = { .assetID    = DECOR_ASSET_CloudSt6,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x06,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 2,
                       .type       = 5 },

    [MAPDECOR_274] = { .assetID    = DECOR_ASSET_CloudSt6,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x06,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 6 },

    [MAPDECOR_275] = { .assetID    = DECOR_ASSET_CloudSt6,
                       .flags      = DECOR_FLAG_HIGH_PRIORITY,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x06,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 4,
                       .type       = 6 },

    [MAPDECOR_276] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x00,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_277] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 10 },

    [MAPDECOR_278] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 10 },

    [MAPDECOR_279] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_NONE,
                       .spriteID   = 2,
                       .type       = 10 },

    [MAPDECOR_280] = { .assetID    = DECOR_ASSET_LeafWater,
                       .flags      = DECOR_FLAG_40,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x5F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 10 },

    [MAPDECOR_281] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x00,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_282] = { .assetID    = DECOR_ASSET_Flipmush,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x00,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_283] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 5,
                       .type       = 0 },

    [MAPDECOR_284] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 6,
                       .type       = 0 },

    [MAPDECOR_285] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_286] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 7,
                       .type       = 0 },

    [MAPDECOR_287] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 8,
                       .type       = 0 },

    [MAPDECOR_288] = { .assetID    = DECOR_ASSET_Grass6,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 4,
                       .animID2    = 4,
                       .animFlags2 = 0x68,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 9,
                       .type       = 0 },

    [MAPDECOR_289] = { .assetID    = DECOR_ASSET_Barrel,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 7,
                       .animID2    = 7,
                       .animFlags2 = 0x54,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x11,
                       .type       = 0 },

    [MAPDECOR_290] = { .assetID    = DECOR_ASSET_Saku,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x12,
                       .type       = 1 },

    [MAPDECOR_291] = { .assetID    = DECOR_ASSET_Saku,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x12,
                       .type       = 1 },

    [MAPDECOR_292] = { .assetID    = DECOR_ASSET_Saku,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x13,
                       .type       = 1 },

    [MAPDECOR_293] = { .assetID    = DECOR_ASSET_Saku,
                       .flags      = DECOR_FLAG_FLIP_X | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x13,
                       .type       = 1 },

    [MAPDECOR_294] = { .assetID    = DECOR_ASSET_Saku,
                       .flags      = DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x59,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0x14,
                       .type       = 1 },

    [MAPDECOR_295] = { .assetID    = DECOR_ASSET_KojimaPalm,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x6E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_296] = { .assetID    = DECOR_ASSET_KojimaPalm,
                       .flags      = DECOR_FLAG_FLIP_X,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x6E,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 0 },

    [MAPDECOR_297] = { .assetID    = DECOR_ASSET_GstTree,
                       .flags      = DECOR_FLAG_NONE,
                       .animID     = 5,
                       .animID2    = 5,
                       .animFlags2 = 0x27,
                       .oamOrder   = DECOR_DRAWORDER_26,
                       .spriteID   = 0x35,
                       .type       = 4 },

    [MAPDECOR_298] = { .assetID    = DECOR_ASSET_Thunder,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x66,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 9 },

    [MAPDECOR_299] = { .assetID    = DECOR_ASSET_Sail,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x58,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0xE,
                       .type       = 9 },

    [MAPDECOR_300] = { .assetID    = DECOR_ASSET_Water,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_LOW_PRIORITY,
                       .animID     = 3,
                       .animID2    = 3,
                       .animFlags2 = 0x21,
                       .oamOrder   = DECOR_DRAWORDER_NONE,
                       .spriteID   = 0x1A,
                       .type       = 9 },

    [MAPDECOR_301] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 0,
                       .type       = 9 },

    [MAPDECOR_302] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 1,
                       .animID2    = 1,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 1,
                       .type       = 9 },

    [MAPDECOR_303] = { .assetID    = DECOR_ASSET_FallingWater,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 2,
                       .animID2    = 2,
                       .animFlags2 = 0x5D,
                       .oamOrder   = DECOR_DRAWORDER_NONE,
                       .spriteID   = 2,
                       .type       = 9 },

    [MAPDECOR_304] = { .assetID    = DECOR_ASSET_LeafWater,
                       .flags      = DECOR_FLAG_4 | DECOR_FLAG_PREPEND,
                       .animID     = 0,
                       .animID2    = 0,
                       .animFlags2 = 0x5F,
                       .oamOrder   = DECOR_DRAWORDER_25,
                       .spriteID   = 3,
                       .type       = 9 },
};

NOT_DECOMPILED u8 _02188780[4];

static s8 iceSparkleOffsetTable[16] = { 1, -52, -5, -44, 15, -32, -2, -30, 19, -23, -5, -21, 14, -6, -13, -4 };

// --------------------
// FUNCTIONS
// --------------------

void DecorationSys__Create(void)
{
    if (DecorationSys__WorkSingleton != NULL)
        return;

    Task *task = TaskCreate(DecorationSys__Main, DecorationSys__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(3), DecorationSys);
    if (task == HeapNull)
        return;

    DecorationSys *work = TaskGetWork(task, DecorationSys);
    TaskInitWork8(work);

    DecorationSys__WorkSingleton = work;
}

StageDecoration *DecorationSys__Construct(size_t structSize, MapDecor *mapDecor, fx32 x, fx32 y, BOOL prepend)
{
    if (structSize < sizeof(StageDecoration))
        structSize = sizeof(StageDecoration);

    StageDecoration *work = HeapAllocHead(HEAP_SYSTEM, structSize);
    MI_CpuClear8(work, structSize);

    if (prepend)
        DecorationSys__AddEntry_Head(work);
    else
        DecorationSys__AddEntry_Tail(work);

    DecorationSys__InitMapDecor(work, mapDecor, x, y);

    return work;
}

void DecorationSys__DestroyDecor(StageDecoration *work)
{
    if (work == NULL)
        return;

    if (work->destructor != NULL)
        work->destructor(work);

    DecorationSys__RemoveEntry(work);
    HeapFree(HEAP_SYSTEM, work);
}

void DecorationSys__Release(void)
{
    if (DecorationSys__WorkSingleton == NULL)
        return;

    StageDecoration *decor = DecorationSys__WorkSingleton->listStart;
    while (decor != NULL)
    {
        StageDecoration *next = decor->next;
        DecorationSys__DestroyDecor(decor);
        decor = next;
    }
}

StageDecoration *DecorationSys__CreateTempDecoration(s32 type, fx32 x, fx32 y)
{
    StageDecoration *work = NULL;

    s32 slot = DecorationSys__GetNextTempSlot();
    if (slot < STAGEDECOR_TEMPLIST_SIZE)
    {
        DecorationSys__TempDecorList[slot].x  = -1;
        DecorationSys__TempDecorList[slot].y  = -1;
        DecorationSys__TempDecorList[slot].id = type;

        work = stageDecorationSpawnList[type](&DecorationSys__TempDecorList[slot], x, y, 0);
        if (work == NULL)
            DecorationSys__ReleaseTempDecor(&DecorationSys__TempDecorList[slot]);
    }

    return work;
}

NONMATCH_FUNC StageDecoration *DecorationSys__CreateCommonDecor(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
    // https://decomp.me/scratch/TSQVo -> 97.16%
#ifdef NON_MATCHING
    struct DecorAsset *asset;
    struct DecorConfig *config;

    config = &decorInfo[mapDecor->id];
    asset  = &decorAssets[config->assetID];

    DecorationCommon *work = (DecorationCommon *)DecorationSys__Construct(sizeof(DecorationCommon), mapDecor, x, y, ((config->flags & 0x80) != 0));

    work->decorWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->decorWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    if ((config->flags & 4) != 0 && (config->flags & 0x10) == 0)
    {
        ObjObjectAction2dBACLoad(&work->decorWork.objWork, &work->animator, asset->path, &decorFileList[asset->fileID], gameArchiveStage, OBJ_DATA_GFX_AUTO);
        ObjActionAllocSpritePalette(&work->decorWork.objWork, config->animID2, config->animFlags2);
        StageTask__SetAnimation(&work->decorWork.objWork, config->animID);
    }
    else
    {
        if ((config->flags & 0x40) == 0)
        {
            ObjObjectAction2dBACLoad(&work->decorWork.objWork, &work->animator, asset->path, &decorFileList[asset->fileID], gameArchiveStage, OBJ_DATA_GFX_NONE);
            ObjActionAllocSpritePalette(&work->decorWork.objWork, config->animID2, config->animFlags2);
            ObjObjectActionAllocSprite(&work->decorWork.objWork, Sprite__GetSpriteSize2FromAnim(work->animator.fileWork->fileData, config->animID),
                                       &decorSpriteRefList[config->spriteID]);
            StageTask__SetAnimation(&work->decorWork.objWork, config->animID);

            AnimatorSpriteDS *ani = &work->decorWork.objWork.obj_2d->ani;
            if ((decorSpriteRefList[config->spriteID].engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            {
                ani->work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
                AnimatorSpriteDS__ProcessAnimationFast(ani);
                StageTask__SetAnimation(&work->decorWork.objWork, config->animID);
            }
            ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
        }
    }

    if ((config->flags & (0x40 | 0x04)) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    else
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

    if ((config->flags & 1) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((config->flags & 2) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    u8 priority;
    if ((config->flags & 8) != 0)
    {
        priority = SPRITE_PRIORITY_0;
    }
    else if ((config->flags & 0x20) != 0)
    {
        priority = SPRITE_PRIORITY_3;
    }
    else
    {
        priority = SPRITE_PRIORITY_2;
    }
    StageTask__SetAnimatorOAMOrder(&work->decorWork.objWork, config->oamOrder + SPRITE_ORDER_25);
    StageTask__SetAnimatorPriority(&work->decorWork.objWork, priority);

    if (DecorationSys__initTable[config->type] != NULL)
        DecorationSys__initTable[config->type](&work->decorWork);

    return &work->decorWork;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldrh r3, [r0, #2]
	ldr r4, =decorInfo
	mov lr, r1
	add r5, r4, r3, lsl #3
	ldrb r6, [r4, r3, lsl #3]
	ldrb r4, [r5, #1]
	ldr ip, =decorAssets
	mov r3, r2
	tst r4, #0x80
	movne r4, #1
	moveq r4, #0
	mov r1, r0
	mov r2, lr
	mov r0, #0x2dc
	add r6, ip, r6, lsl #3
	str r4, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldrb r1, [r5, #1]
	tst r1, #4
	beq _02152C10
	tst r1, #0x10
	bne _02152C10
	ldr r1, =gameArchiveStage
	ldr r2, =0x0000FFFF
	ldr r1, [r1, #0]
	ldr ip, =decorFileList
	stmia sp, {r1, r2}
	ldrh r3, [r6, #4]
	ldr r2, [r6, #0]
	add r1, r4, #0x22c
	add r3, ip, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r5, #3]
	ldrb r2, [r5, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	b _02152CDC
_02152C10:
	tst r1, #0x40
	bne _02152CDC
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r0, [r0, #0]
	ldr ip, =decorFileList
	stmia sp, {r0, r1}
	ldrh r3, [r6, #4]
	ldr r2, [r6, #0]
	mov r0, r4
	add r1, r4, #0x22c
	add r3, ip, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r5, #3]
	ldrb r2, [r5, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x2d0]
	ldrb r1, [r5, #2]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	ldrb r2, [r5, #6]
	ldr r3, =decorSpriteRefList
	mov r0, r4
	add r2, r3, r2, lsl #4
	bl ObjObjectActionAllocSprite
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	ldrb r1, [r5, #6]
	ldr r0, =0x02189FF0
	ldr r6, [r4, #0x128]
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02152CD0
	ldr r0, [r6, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r6
	mov r2, r1
	str r3, [r6, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
_02152CD0:
	ldr r0, [r6, #0x3c]
	orr r0, r0, #0x18
	str r0, [r6, #0x3c]
_02152CDC:
	ldrb r0, [r5, #1]
	tst r0, #0x44
	ldr r0, [r4, #0x20]
	orrne r0, r0, #4
	orreq r0, r0, #0x10
	str r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #2
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #8
	movne r6, #0
	bne _02152D38
	tst r0, #0x20
	movne r6, #3
	moveq r6, #2
_02152D38:
	ldrsb r1, [r5, #5]
	mov r0, r4
	add r1, r1, #0x19
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, r6
	bl StageTask__SetAnimatorPriority
	ldrb r1, [r5, #7]
	ldr r0, =DecorationSys__initTable
	ldr r1, [r0, r1, lsl #2]
	cmp r1, #0
	beq _02152D70
	mov r0, r4
	blx r1
_02152D70:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageDecoration *DecorationSys__CreateUnknown2152D9C(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	ldrh r3, [r0, #2]
	ldr r4, =decorInfo
	ldr lr, =_021876D4
	add r5, r4, r3, lsl #3
	ldrb r9, [r5, #4]
	ldrb r6, [r5, #1]
	ldrb r7, [r4, r3, lsl #3]
	ldrb r8, [lr, r9, lsl #3]
	ldr ip, =decorAssets
	mov r4, r1
	tst r6, #0x80
	add r6, lr, r9, lsl #3
	movne r9, #1
	mov r3, r2
	moveq r9, #0
	mov r1, r0
	mov r2, r4
	mov r0, #0x3f0
	add r7, ip, r7, lsl #3
	add r8, ip, r8, lsl #3
	str r9, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldrb r1, [r5, #1]
	tst r1, #4
	beq _02152EB8
	tst r1, #0x10
	bne _02152EB8
	ldr r3, =0x0000FFFF
	ldr ip, =decorFileList
	str r3, [sp]
	ldrh r9, [r7, #4]
	ldr r2, =gameArchiveStage
	add r1, r4, #0x2dc
	add r9, ip, r9, lsl #3
	str r9, [sp, #4]
	ldr r2, [r2, #0]
	str r2, [sp, #8]
	ldr r2, [r7, #0]
	bl ObjObjectAction3dBACLoad
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldrh r3, [r8, #4]
	ldr r2, [r8, #0]
	add r1, r4, #0x22c
	ldr r7, =decorFileList
	add r3, r7, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	ldrb r1, [r6, #3]
	ldrb r2, [r6, #4]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	ldrb r1, [r6, #2]
	bl DecorationSys__SetAnimation
	b _02153054
_02152EB8:
	mov r3, #0
	str r3, [sp]
	ldrh r1, [r7, #4]
	ldr r2, =decorFileList
	ldr r0, =gameArchiveStage
	add r1, r2, r1, lsl #3
	str r1, [sp, #4]
	ldr r1, [r0, #0]
	mov r0, r4
	str r1, [sp, #8]
	ldr r2, [r7, #0]
	add r1, r4, #0x2dc
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x3e4]
	ldrb r1, [r5, #2]
	ldr r0, [r0, #0]
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, [r4, #0x3e4]
	mov r9, r0
	ldr r0, [r1, #0]
	ldrb r1, [r5, #2]
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, r9
	mov r2, r0
	mov r0, r4
	ldr r9, =decorSpriteRefList
	ldrb r3, [r5, #6]
	add r3, r9, r3, lsl #4
	bl ObjObjectActionAllocTexture
	mov r0, r4
	ldrb r1, [r5, #2]
	bl StageTask__SetAnimation
	ldr r9, [r4, #0x134]
	ldrb r1, [r5, #6]
	ldr r0, =0x02189FF0
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02152F80
	ldr r0, [r9, #0xcc]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r9
	mov r2, r1
	str r3, [r9, #0xcc]
	bl AnimatorSprite3D__ProcessAnimation
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
_02152F80:
	ldr r1, [r9, #0xcc]
	ldr r0, =gameArchiveStage
	orr r1, r1, #0x18
	str r1, [r9, #0xcc]
	ldr r1, [r0, #0]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldrh r3, [r8, #4]
	ldr r8, =decorFileList
	ldr r2, [r7, #0]
	mov r0, r4
	add r1, r4, #0x22c
	add r3, r8, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r6, #3]
	ldrb r2, [r6, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x2d0]
	ldrb r1, [r6, #2]
	ldr r0, [r0, #0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	ldrb r2, [r6, #6]
	mov r0, r4
	ldr r3, =decorSpriteRefList
	add r2, r3, r2, lsl #4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	ldrb r1, [r6, #2]
	bl DecorationSys__SetAnimation
	ldr r7, [r4, #0x128]
	ldrb r1, [r6, #6]
	ldr r0, =0x02189FF0
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02153048
	ldr r0, [r7, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r7
	mov r2, r1
	str r3, [r7, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	ldrb r1, [r6, #2]
	mov r0, r4
	bl DecorationSys__SetAnimation
_02153048:
	ldr r0, [r7, #0x3c]
	orr r0, r0, #0x18
	str r0, [r7, #0x3c]
_02153054:
	ldrb r0, [r5, #1]
	tst r0, #4
	ldr r0, [r4, #0x20]
	orrne r0, r0, #4
	orreq r0, r0, #0x10
	str r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #2
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	ldrb r0, [r6, #1]
	tst r0, #8
	movne r7, #0
	bne _021530B0
	tst r0, #0x20
	movne r7, #3
	moveq r7, #2
_021530B0:
	ldrsb r1, [r6, #5]
	mov r0, r4
	add r1, r1, #0x19
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, r7
	bl StageTask__SetAnimatorPriority
	ldrb r1, [r5, #7]
	ldr r0, =DecorationSys__initTable
	ldr r1, [r0, r1, lsl #2]
	cmp r1, #0
	beq _021530E8
	mov r0, r4
	blx r1
_021530E8:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

StageDecoration *DecorationSys__CreateUnknown2153118(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
    StageDecoration *work = DecorationSys__Construct(sizeof(StageDecoration), mapDecor, x, y, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SetTaskState(&work->objWork, DecorationSys__CreateWaterBubble);
    return work;
}

void DecorationSys__Destructor(Task *task)
{
    UNUSED(task);

    if (DecorationSys__WorkSingleton == NULL)
        return;

    DecorationSys__Release();
    DecorationSys__WorkSingleton = NULL;
}

void DecorationSys__Main(void)
{
    StageDecoration *decor = DecorationSys__WorkSingleton->listStart;
    while (decor != NULL)
    {
        StageDecoration *next = decor->next;
        DecorationSys__Decor_Main(decor);
        decor = next;
    }
}

void DecorationSys__Decor_Main(StageDecoration *work)
{
    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        DecorationSys__DestroyDecor(work);
        return;
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROY_NEXT_FRAME) != 0)
    {
        work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        return;
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) == 0)
    {
        if (work->objWork.ppViewCheck != NULL)
        {
            if (work->objWork.ppViewCheck(&work->objWork))
            {
                work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
                return;
            }
        }
    }

    if (work->objWork.parentObj != NULL && (work->objWork.parentObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        if ((work->objWork.flag & STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT) == 0)
        {
            work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
            work->objWork.parentObj = NULL;
            return;
        }

        work->objWork.parentObj = NULL;
    }

    if (!ObjectPauseCheck(work->objWork.flag))
    {
        if ((work->objWork.flag & STAGE_TASK_FLAG_DISABLE_STATE) == 0)
        {
            if (work->objWork.state != NULL)
            {
                ((StageDecorState)work->objWork.state)(work);
            }
        }

        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT) == 0)
        {
            if (work->objWork.ppMove != NULL)
                ((StageDecorMoveFunc)work->objWork.ppMove)(work);
            else
                StageTask__Move(&work->objWork);
        }
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROYED) == 0)
    {
        if (work->objWork.ppOut == NULL || (work->objWork.displayFlag & DISPLAY_FLAG_NO_DRAW_EVENT) != 0)
            DecorationSys__Draw(work);

        if (work->objWork.ppOut != NULL)
            ((StageDecorOutFunc)work->objWork.ppOut)(work);
    }

    if (!ObjectPauseCheck(work->objWork.flag))
    {
        if (work->objWork.ppCollide != NULL)
        {
            ((StageDecorCollideFunc)work->objWork.ppCollide)(work);
        }
        else
        {
            for (s32 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
            {
                if (work->objWork.colliderList[c] != NULL)
                    StageTask__HandleCollider(&work->objWork, work->objWork.colliderList[c]);
            }
        }

        work->objWork.prevOffset.x = work->objWork.offset.x;
        work->objWork.prevOffset.y = work->objWork.offset.y;
        work->objWork.prevOffset.z = work->objWork.offset.z;

        work->objWork.offset.x = 0;
        work->objWork.offset.y = 0;
        work->objWork.offset.z = 0;

        work->objWork.flow.x = 0;
        work->objWork.flow.y = 0;
        work->objWork.flow.z = 0;
    }
}

void DecorationSys__Draw(StageDecoration *work)
{
    if (work->objWork.obj_2d != NULL)
    {
        StageDisplayFlags displayFlag;
        if (work->objWork.obj_3d != NULL || work->objWork.obj_3des != NULL || work->objWork.obj_2dIn3d != NULL)
            displayFlag = work->objWork.displayFlag;

        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);

        if (work->objWork.obj_3d != NULL || work->objWork.obj_3des != NULL || work->objWork.obj_2dIn3d != NULL)
            work->objWork.displayFlag = displayFlag;
    }

    if (work->objWork.obj_2dIn3d != NULL)
        StageTask__Draw3D(&work->objWork, &work->objWork.obj_2dIn3d->ani.work);
}

void DecorationSys__ReleaseDecor(StageDecoration *work)
{
    ObjObjectActionReleaseGfxRefs(&work->objWork);

    if (work->objWork.obj_2d != NULL)
    {
        ObjDrawReleaseSpritePalette(work->objWork.obj_2d->ani.cParam[0].palette);

        if (work->objWork.obj_2d->fileWork != NULL)
        {
            ObjDataRelease(work->objWork.obj_2d->fileWork);
        }
        else if (work->objWork.obj_2d->ani.work.fileData != NULL && (work->objWork.flag & STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE) == 0)
        {
            HeapFree(HEAP_USER, work->objWork.obj_2d->ani.work.fileData);
        }
    }

    if (work->objWork.obj_2dIn3d != NULL)
    {
        if (work->objWork.obj_2dIn3d->fileWork != NULL)
        {
            ObjDataRelease(work->objWork.obj_2dIn3d->fileWork);
            work->objWork.obj_2dIn3d->fileData = NULL;
        }
        else if (work->objWork.obj_2dIn3d->fileData != NULL && (work->objWork.obj_2dIn3d->flags & 1) == 0)
        {
            HeapFree(HEAP_USER, work->objWork.obj_2dIn3d->fileData);
            work->objWork.obj_2dIn3d->fileData = NULL;
        }
    }
}

void DecorationSys__InitMapDecor(StageDecoration *work, MapDecor *mapDecor, fx32 x, fx32 y)
{
    SetTaskSpriteCallback(&work->objWork, DecorationSys__SpriteCallback_Default);
    SetDecorCollideFunc(&work->objWork, DecorationSys__Collide_Default);
    SetTaskViewCheckFunc(&work->objWork, StageTask__ViewCheck_Default);

    work->originPos.x        = x;
    work->originPos.y        = y;
    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.scale.x = work->objWork.scale.y = work->objWork.scale.z = FLOAT_TO_FX32(1.0);
    work->objWork.objType                                                 = STAGE_OBJ_TYPE_DECORATION;

    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.1640625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(15.0);

    work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;

    StageTask__SetHitbox(&work->objWork, -2, -6, 2, 0);
    ObjRect__SetGroupFlags(&work->rect[0], 2, 1);
    ObjRect__SetAttackStat(&work->rect[0], 0, 0);
    ObjRect__SetDefenceStat(&work->rect[0], ~1, 0x3F);
    work->rect[0].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;

    if (mapDecor != NULL)
    {
        work->mapDecor    = mapDecor;
        work->mapDecor->x = MAPOBJECT_DESTROYED;
    }

    work->objWork.viewOutOffset = 264 - GameDecoration__ViewOffsetTable[mapDecor->id];
    work->destructor            = DecorationSys__Destructor_21535B8;
}

void DecorationSys__Destructor_21535B8(StageDecoration *work)
{
    MapDecor *mapDecor = work->mapDecor;
    if (mapDecor != NULL && mapDecor->x == MAPOBJECT_DESTROYED && mapDecor->y == MAPOBJECT_DESTROYED)
    {
        DecorationSys__ReleaseTempDecor(mapDecor);
    }
    else
    {
        if ((work->flags & 0x10000) == 0 && mapDecor != NULL)
            mapDecor->x = FX32_TO_WHOLE(work->originPos.x);
    }

    DecorationSys__ReleaseDecor(work);
}

void DecorationSys__AddEntry_Tail(StageDecoration *work)
{
    if (DecorationSys__WorkSingleton->listEnd != NULL)
    {
        DecorationSys__WorkSingleton->listEnd->next = work;
        work->prev                                  = DecorationSys__WorkSingleton->listEnd;
        work->next                                  = NULL;
        DecorationSys__WorkSingleton->listEnd       = work;
    }
    else
    {
        DecorationSys__WorkSingleton->listEnd   = work;
        DecorationSys__WorkSingleton->listStart = DecorationSys__WorkSingleton->listEnd;

        work->next = NULL;
        work->prev = NULL;
    }
}

void DecorationSys__AddEntry_Head(StageDecoration *work)
{
    if (DecorationSys__WorkSingleton->listStart != NULL)
    {
        DecorationSys__WorkSingleton->listStart->prev = work;
        work->next                                    = DecorationSys__WorkSingleton->listStart;
        work->prev                                    = NULL;
        DecorationSys__WorkSingleton->listStart       = work;
    }
    else
    {
        DecorationSys__WorkSingleton->listEnd   = work;
        DecorationSys__WorkSingleton->listStart = DecorationSys__WorkSingleton->listEnd;
        work->next                              = NULL;
        work->prev                              = NULL;
    }
}

void DecorationSys__RemoveEntry(StageDecoration *work)
{
    StageDecoration *prev = work->prev;
    if (prev != NULL)
        prev->next = work->next;
    else
        DecorationSys__WorkSingleton->listStart = work->next;

    StageDecoration *next = work->next;
    if (next != NULL)
        next->prev = work->prev;
    else
        DecorationSys__WorkSingleton->listEnd = work->prev;
}

void DecorationSys__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, StageDecoration *work)
{
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        switch (block->id)
        {
            case 0:
                work->rect[block->id].parent = &work->objWork;
                ObjRect__SetBox2D(&work->rect[block->id].rect, block->hitbox.left, block->hitbox.top, block->hitbox.right, block->hitbox.bottom);
                break;
        }
    }
}

void DecorationSys__Collide_Default(StageDecoration *work)
{
    if ((work->objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) == 0)
    {
        if (work->rect[0].parent != NULL)
            StageTask__HandleCollider(&work->objWork, work->rect);
    }
}

s16 DecorationSys__GetNextTempSlot(void)
{
    s16 slot = 0;

    for (slot = 0; slot < STAGEDECOR_TEMPLIST_SIZE; slot++)
    {
        if ((DecorationSys__TempDecorBitfield[slot >> 5] & (1 << (slot & 0x1F))) == 0)
        {
            DecorationSys__TempDecorBitfield[slot >> 5] |= (1 << (slot & 0x1F));
            return slot;
        }
    }

    return slot;
}

void DecorationSys__ReleaseTempDecor(MapDecor *mapDecor)
{
    u32 slot = FX_DivS32((size_t)mapDecor - (size_t)DecorationSys__TempDecorList, 4);

    DecorationSys__TempDecorBitfield[slot >> 5] &= ~(1 << (slot & 0x1F));
}

void DecorationSys__CreateWaterBubble(StageDecoration *work)
{
    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0)
    {
        EffectWaterBubble__Create(work->objWork.position.x + FX32_FROM_WHOLE(((mtMathRand() & 7) - 3)), work->objWork.position.y - FLOAT_TO_FX32(4.0), (u16)(mtMathRand() & 1),
                                  mapCamera.camera[0].waterLevel);

        work->objWork.userTimer = (mtMathRand() & 0x3F) + 8;
    }
}

NONMATCH_FUNC void DecorationSys__InitFunc_21538D0(StageDecoration *work)
{
    // https://decomp.me/scratch/HeuQt -> 85.54%
#ifdef NON_MATCHING
    s32 type;

    u16 id = work->mapDecor->id;
    if (id >= MAPDECOR_195 && id <= MAPDECOR_202)
    {
        type = id - MAPDECOR_195;
    }
    else if (id >= MAPDECOR_217 && id <= MAPDECOR_220)
    {
        type = id - MAPDECOR_209;
    }
    else if (id >= MAPDECOR_225 && id <= MAPDECOR_228)
    {
        type = id - MAPDECOR_213;
    }
    else if (id >= MAPDECOR_290)
    {
        type = id - MAPDECOR_274;
    }
    else
    {
        type = id - MAPDECOR_290;
    }

    ObjRect__SetBox2D(&work->rect[0].rect, DecorationSys__rectList[type >> 1].left, DecorationSys__rectList[type >> 1].top, DecorationSys__rectList[type >> 1].right,
                      DecorationSys__rectList[type >> 1].bottom);

    work->rect[0].parent = &work->objWork;
    ObjRect__SetOnDefend(&work->rect[0], DecorationSys__OnDefend_21539B0);
    work->rect[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x20c]
	ldrh r1, [r0, #2]
	cmp r1, #0xc3
	blo _021538F8
	cmp r1, #0xca
	subls r0, r1, #0xc3
	bls _02153934
_021538F8:
	cmp r1, #0xd9
	blo _0215390C
	cmp r1, #0xdc
	subls r0, r1, #0xd1
	bls _02153934
_0215390C:
	cmp r1, #0xe1
	blo _02153920
	cmp r1, #0xe4
	subls r0, r1, #0xd5
	bls _02153934
_02153920:
	ldr r0, =0x00000122
	cmp r1, r0
	sub r0, r0, #0x234
	addhs r0, r1, r0
	addlo r0, r1, r0
_02153934:
	mov r0, r0, asr #1
	ldr r3, =0x02187677
	mov lr, r0, lsl #2
	ldr r1, =DecorationSys__rectList
	ldr r2, =0x02187675
	ldr r0, =0x02187676
	ldrsb ip, [r3, lr]
	ldrsb r1, [r1, lr]
	ldrsb r2, [r2, lr]
	ldrsb r3, [r0, lr]
	add r0, r4, #0x168
	str ip, [sp]
	bl ObjRect__SetBox2D
	ldr r0, =DecorationSys__OnDefend_21539B0
	str r4, [r4, #0x184]
	str r0, [r4, #0x18c]
	ldr r0, [r4, #0x180]
	orr r0, r0, #4
	orr r0, r0, #0x400
	str r0, [r4, #0x180]
	ldr r0, [r4, #0x18]
	bic r0, r0, #2
	str r0, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DecorationSys__OnDefend_21539B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r4, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r4, #0
	cmpne r2, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r3, [r2, #0]
	cmp r3, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r3, [r2, #0x1c]
	tst r3, #0x40
	beq _021539FC
	ldr r5, [r2, #0xc8]
	cmp r5, #0
	rsblt r5, r5, #0
	b _02153A18
_021539FC:
	ldr r3, [r2, #0x9c]
	ldr r5, [r2, #0x98]
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r5, #0
	rsblt r5, r5, #0
	add r5, r5, r3
_02153A18:
	ldr r3, [r2, #0x64c]
	cmp r5, r3
	bge _02153A30
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02153A30:
	ldr r0, [r2, #0x5d8]
	tst r0, #0x80
	beq _02153C1C
	ldr r1, [r4, #0x20c]
	ldr r0, =0x00000122
	ldrh r1, [r1, #2]
	cmp r1, r0
	ldr r0, [r2, #0xc0]
	blo _02153B34
	sub r0, r0, #0x5000
	ldr r6, [r2, #0xbc]
	ldr r10, =_mt_math_rand
	ldr r7, =0x00196225
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	str r0, [sp, #4]
	mov r5, #0
_02153A74:
	ldr r1, [r10, #0]
	ldr r2, [r9, #0]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla r11, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov ip, r3, lsr #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsl #0x10
	mov ip, r3, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsr #0x10
	and r1, r1, #7
	and r3, r3, #3
	and r0, r0, #1
	str r11, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10, #0]
	ldr r0, [r9, #0]
	mov r11, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, r11, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #6
	rsb r2, r2, #3
	ldr r11, [r4, #0x48]
	sub r1, r1, #3
	add r1, r11, r1, lsl #12
	ldr ip, [r4, #0x44]
	sub r0, r0, #3
	ldr r11, [sp, #4]
	add r3, r3, #4
	add r0, ip, r0, lsl #12
	add r2, r6, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r5, r5, #1
	cmp r5, #2
	blt _02153A74
	b _02153FD8
_02153B34:
	sub r6, r0, #0x5000
	ldr r0, =0x00001FFF
	ldr r5, [r2, #0xbc]
	rsb r0, r0, #0x1000
	str r0, [sp, #0xc]
	ldr r0, =0x00001FFF
	ldr r10, =_mt_math_rand
	sub r0, r0, #0x1800
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	mov r7, #0
	str r0, [sp, #8]
_02153B64:
	ldr r0, [r10, #0]
	mla r3, r0, r8, r9
	mla r1, r3, r8, r9
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r8, r9
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #8]
	and r1, r1, r3, lsr #16
	sub r3, r6, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r8, r9
	ldr r2, =0x00001FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0xc]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r8, r9
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10, #0]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r2, r5, lsl #1
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r7, r7, #1
	cmp r7, #3
	blt _02153B64
	b _02153FD8
_02153C1C:
	ldr r1, [r4, #0x20c]
	tst r0, #0x100
	ldr r0, =0x00000122
	ldrh r1, [r1, #2]
	mov r6, #0
	beq _02153E04
	cmp r1, r0
	ldr r7, =0x00196225
	blo _02153D1C
	ldr r0, [r2, #0xbc]
	mov r11, #0x5000
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	mov r5, r0, asr #1
	rsb r11, r11, #0
_02153C5C:
	ldr r1, [r10, #0]
	ldr r2, [r9, #0]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla ip, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, r3, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	and r3, r3, #3
	add r3, r3, #3
	and r0, r0, #1
	str ip, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10, #0]
	ldr r0, [r9, #0]
	mov ip, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #2
	rsb r2, r2, #1
	ldr lr, [r4, #0x44]
	sub r0, r0, #3
	ldr ip, [r4, #0x48]
	sub r1, r1, #3
	add r0, lr, r0, lsl #12
	add r1, ip, r1, lsl #12
	add r2, r5, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r6, r6, #1
	cmp r6, #2
	rsb r5, r5, #0
	blt _02153C5C
	b _02153FD8
_02153D1C:
	ldr r0, =0x00001FFF
	mov r9, #0x5000
	rsb r0, r0, #0x1000
	str r0, [sp, #0x14]
	ldr r0, =0x00001FFF
	ldr r5, [r2, #0xbc]
	sub r0, r0, #0x1800
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	str r0, [sp, #0x10]
	rsb r9, r9, #0
_02153D48:
	ldr r0, [r10, #0]
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r7, r8
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #0x10]
	and r1, r1, r3, lsr #16
	sub r3, r9, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r7, r8
	ldr r2, =0x00001FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0x14]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r7, r8
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10, #0]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r5, r2
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r6, r6, #1
	cmp r6, #3
	rsb r5, r5, #0
	blt _02153D48
	b _02153FD8
_02153E04:
	cmp r1, r0
	ldr r0, [r2, #0xbc]
	ldr r7, =0x00196225
	blo _02153EF4
	mov r5, r0, asr #2
	mov r0, #0x3000
	rsb r0, r0, #0
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	str r0, [sp, #0x18]
_02153E30:
	ldr r1, [r10, #0]
	ldr r2, [r9, #0]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla r11, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov ip, r3, lsr #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsl #0x10
	mov ip, r3, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsr #0x10
	and r1, r1, #7
	and r3, r3, #1
	and r0, r0, #1
	str r11, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10, #0]
	ldr r0, [r9, #0]
	mov r11, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, r11, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #2
	rsb r2, r2, #1
	ldr r11, [r4, #0x48]
	sub r1, r1, #3
	add r1, r11, r1, lsl #12
	ldr ip, [r4, #0x44]
	sub r0, r0, #3
	ldr r11, [sp, #0x18]
	add r3, r3, #1
	add r0, ip, r0, lsl #12
	add r2, r5, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r6, r6, #1
	cmp r6, #2
	rsb r5, r5, #0
	blt _02153E30
	b _02153FD8
_02153EF4:
	mov r5, r0, asr #1
	ldr r0, =0x00000FFF
	mov r9, #0x3000
	rsb r0, r0, #0x800
	str r0, [sp, #0x20]
	ldr r0, =0x00000FFF
	ldr r10, =_mt_math_rand
	sub r0, r0, #0xc00
	ldr r8, =0x3C6EF35F
	str r0, [sp, #0x1c]
	rsb r9, r9, #0
_02153F20:
	ldr r0, [r10, #0]
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r7, r8
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #0x1c]
	and r1, r1, r3, lsr #16
	sub r3, r9, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r7, r8
	ldr r2, =0x00000FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0x20]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r7, r8
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10, #0]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r5, r2
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r6, r6, #1
	cmp r6, #3
	rsb r5, r5, #0
	blt _02153F20
_02153FD8:
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x218]
	orr r0, r0, #0x10000
	str r0, [r4, #0x218]
	ldr r0, [r4, #0x18]
	orr r0, r0, #8
	str r0, [r4, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154030(StageDecoration *work)
{
    work->objWork.prevPosition.x = work->objWork.position.x - g_obj.camera[0].x;
    work->objWork.prevPosition.y = work->objWork.position.y - g_obj.camera[0].y;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    SetTaskState(&work->objWork, DecorationSys__State_2154074);
}

NONMATCH_FUNC void DecorationSys__State_2154074(StageDecoration *work)
{
    // https://decomp.me/scratch/ggt64 -> 99.45%
#ifdef NON_MATCHING
    static s16 rangeTable[]  = { 0x32, 0x40 };
    static s16 offsetTable[] = { -0x400, -0x500 };

    work->objWork.position.x = work->objWork.prevPosition.x + g_obj.camera[0].x;
    work->objWork.position.y = work->objWork.prevPosition.y + g_obj.camera[0].y;
    work->objWork.position.x = work->objWork.position.x + offsetTable[work->mapDecor->id - MAPDECOR_261];

    u32 type = work->mapDecor->id - MAPDECOR_261;
    if (work->objWork.position.x - g_obj.camera[0].x < -FX32_FROM_WHOLE(rangeTable[type]))
    {
        work->objWork.position.x += FLOAT_TO_FX32(256.0) + (rangeTable[type] << 1);
    }
    else if (work->objWork.position.x - g_obj.camera[0].x > FX32_FROM_WHOLE(rangeTable[type]) + FLOAT_TO_FX32(256.0))
    {
        work->objWork.position.x -= FLOAT_TO_FX32(256.0) + (rangeTable[type] << 1);
    }

    work->objWork.prevPosition.x = work->objWork.position.x - g_obj.camera[0].x;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r2, =g_obj
	ldr r4, [r0, #0x8c]
	ldr r3, [r2, #0x2c]
	mvn r1, #0x104
	add r3, r4, r3
	str r3, [r0, #0x44]
	ldr r4, [r0, #0x90]
	ldr r3, [r2, #0x30]
	ldr ip, =DecorationSys__offsetTable
	add r3, r4, r3
	str r3, [r0, #0x48]
	ldr r3, [r0, #0x20c]
	ldr r4, [r0, #0x44]
	ldrh lr, [r3, #2]
	ldr r3, =DecorationSys__rangeTable
	add lr, lr, r1
	mov lr, lr, lsl #1
	ldrsh ip, [ip, lr]
	add r4, r4, ip
	str r4, [r0, #0x44]
	ldr ip, [r0, #0x20c]
	ldr r2, [r2, #0x2c]
	ldrh ip, [ip, #2]
	sub r2, r4, r2
	add r1, ip, r1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	mov r3, r1, lsl #0xc
	rsb r1, r3, #0
	cmp r2, r1
	bge _0215410C
	mov r1, r3, lsl #1
	ldr r2, [r0, #0x44]
	add r1, r1, #0x100000
	add r1, r2, r1
	str r1, [r0, #0x44]
	b _0215412C
_0215410C:
	add r1, r3, #0x100000
	cmp r2, r1
	ble _0215412C
	mov r1, r3, lsl #1
	ldr r2, [r0, #0x44]
	add r1, r1, #0x100000
	sub r1, r2, r1
	str r1, [r0, #0x44]
_0215412C:
	ldr r1, =g_obj
	ldr r2, [r0, #0x44]
	ldr r1, [r1, #0x2c]
	sub r1, r2, r1
	str r1, [r0, #0x8c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154150(StageDecoration *work)
{
    s32 offset;
    if (work->mapDecor->id != MAPDECOR_134)
        offset = -FLOAT_TO_FX32(43.0);
    else
        offset = FLOAT_TO_FX32(43.0);

    StageDecoration *decor = DecorationSys__CreateTempDecoration(MAPDECOR_297, work->objWork.position.x + offset, work->objWork.position.y - FLOAT_TO_FX32(38.0));
    if (decor != NULL)
        decor->objWork.parentObj = &work->objWork;
}

void DecorationSys__InitFunc_2154194(StageDecoration *work)
{
    work->objWork.userTimer = work->objWork.position.x;
    work->objWork.userWork  = work->objWork.position.y;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    SetTaskState(&work->objWork, DecorationSys__State_21541C0);
}

NONMATCH_FUNC void DecorationSys__State_21541C0(StageDecoration *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =gPlayer
	mov r4, r0
	ldr r0, [r1, #0]
	ldr r2, [r4, #0x2c]
	ldr r3, [r0, #0x44]
	ldr r1, [r0, #0x48]
	ldr r0, [r4, #0x28]
	sub r5, r3, r2
	sub r6, r1, r0
	mov r0, r6
	mov r1, r5
	bl FX_Atan2Idx
	mov r2, r6, asr #6
	mul r1, r2, r2
	mov r2, r5, asr #6
	mla r1, r2, r2, r1
	mov r5, r0
	cmp r1, #0x40000
	movgt r0, #0x4000
	bgt _02154220
	mov r0, r1, lsl #2
	mov r1, #0x40000
	bl FX_Div
_02154220:
	mov r1, r5, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov ip, r1, lsl #1
	add r1, ip, #1
	ldr r3, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r2, [r3, r1]
	mov r1, ip, lsl #1
	ldrsh r1, [r3, r1]
	smull r2, r3, r0, r2
	adds ip, r2, #0x800
	smull r2, r1, r0, r1
	adc r0, r3, #0
	adds r2, r2, #0x800
	mov r3, ip, lsr #0xc
	ldr ip, [r4, #0x2c]
	orr r3, r3, r0, lsl #20
	add r0, ip, r3
	str r0, [r4, #0x44]
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r4, #0x28]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4, #0x48]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154294(StageDecoration *work)
{
    work->objWork.viewOutOffset = 145;
    SetDecorOutFunc(&work->objWork, DecorationSys__Draw_21542BC);
    work->objWork.userTimer = (u16)work->objWork.position.x;
}

void DecorationSys__Draw_21542BC(StageDecoration *work)
{
    work->objWork.userTimer = (s32)(u16)(work->objWork.userTimer + 256);
    work->objWork.offset.y  = MultiplyFX(0x7FFF, SinFX((s32)(u16)work->objWork.userTimer));

    if ((g_obj.flag & OBJECTMANAGER_FLAG_800) != 0)
    {
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[0].x + FLOAT_TO_FX32(128.0))) >> 3;

        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
    }
    else
    {
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[0].x + FLOAT_TO_FX32(128.0))) >> 3;

        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;
        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[1].x + FLOAT_TO_FX32(128.0))) >> 3;
        work->objWork.obj_2d->ani.screensToDraw &= ~SCREEN_DRAW_B;

        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_A;
        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
        work->objWork.obj_2d->ani.screensToDraw &= ~SCREEN_DRAW_A;
    }
}

void DecorationSys__InitFunc_21543E8(StageDecoration *work)
{
    work->objWork.userTimer = (u16)work->objWork.position.x;
    SetTaskState(&work->objWork, DecorationSys__State_2154408);
}

void DecorationSys__State_2154408(StageDecoration *work)
{
    work->objWork.userTimer = (s32)(u16)(work->objWork.userTimer + 256);
    work->objWork.offset.y  = MultiplyFX(0x3FFF, SinFX((s32)(u16)work->objWork.userTimer));
}

void DecorationSys__InitFunc_2154478(StageDecoration *work)
{
    ObjRect__SetBox2D(&work->rect[0].rect, 0, -48, 32, 0);
    work->rect[0].parent = &work->objWork;
    ObjRect__SetOnDefend(&work->rect[0], DecorationSys__OnDefend_21544D0);
    work->rect[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
}

void DecorationSys__OnDefend_21544D0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    StageDecoration *decor = (StageDecoration *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (decor != NULL && player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        decor->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        decor->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        decor->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }
}

void DecorationSys__InitFunc_2154510(StageDecoration *work)
{
    SetTaskState(&work->objWork, DecorationSys__State_2154520);
}

void DecorationSys__State_2154520(StageDecoration *work)
{
    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0)
    {
        u32 type = mtMathRand() & 0xF;
        type     = (type << 0x1D) >> 0x1C;

        // BUG(?)
        // shouldn't it be "(type + 1) & 0xF" instead of "(type & 0xF) + 1"?
        // this could potentially cause a minor buffer overflow!
        EffectIceSparkles *sparkle = EffectIceSparkles__Create(work->objWork.position.x + FX32_FROM_WHOLE(iceSparkleOffsetTable[type]),
                                                               work->objWork.position.y + FX32_FROM_WHOLE(iceSparkleOffsetTable[type + 1]), 0, 0, 0);
        if (sparkle != NULL)
            StageTask__SetAnimatorPriority(&sparkle->objWork, work->objWork.obj_2d->ani.work.oamPriority);

        work->objWork.userTimer = (mtMathRand() & 0x1F) + 60;
    }
}

void DecorationSys__CreateTripleGrindRailLeaf(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 anim)
{
    EffectGrind3Leaf *work = CreateEffect(EffectGrind3Leaf, 0);
    if (work == NULL)
        return;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/act/ac_eff_grd3l_leaf.bac", GetObjectDataWork(OBJDATAWORK_158), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 19);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    StageTask__SetAnimation(&work->objWork, anim);

    u32 dir = mtMathRand();
    if ((dir & DISPLAY_FLAG_FLIP_X) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((dir & DISPLAY_FLAG_FLIP_Y) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.gravityStrength >>= 2;
    work->objWork.terminalVelocity >>= 2;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    InitEffectTaskViewCheck(&work->objWork, 32, 0, 0, 0, 0);

    SetTaskState(&work->objWork, DecorationSys__State_215475C);
}

void DecorationSys__State_215475C(StageDecoration *work)
{
    if ((mtMathRand() & 0x1F) == 0)
        work->objWork.velocity.x = -work->objWork.velocity.x;

    if ((mtMathRand() & 0x1F) == 0)
        work->objWork.velocity.y >>= 2;
}

NONMATCH_FUNC void DecorationSys__CreateUnknown21547D4(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, r1
	mov r3, r2
	mov r4, #0
	mov r1, r5
	mov r2, r0
	mov r0, #0x22c
	str r4, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r0, [r4, #0x1c]
	ldr r1, =DecorationSys__State_21548A8
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r0, =DecorationSys__OnDefend_21548D4
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	str r4, [r4, #0x184]
	str r0, [r4, #0x18c]
	ldr r0, [r4, #0x180]
	orr r0, r0, #0xc4
	str r0, [r4, #0x180]
	ldrh r1, [r5, #2]
	cmp r1, #0x114
	beq _0215485C
	ldr r0, =0x00000119
	cmp r1, r0
	addne r0, r0, #1
	cmpne r1, r0
	beq _02154878
	b _02154894
_0215485C:
	mov r3, #0x20
	sub r1, r3, #0x40
	mov r2, r1
	add r0, r4, #0x168
	str r3, [sp]
	bl ObjRect__SetBox2D
	b _02154894
_02154878:
	mov r5, #0x10
	add r0, r4, #0x168
	sub r1, r5, #0x30
	sub r2, r5, #0x20
	mov r3, #0x20
	str r5, [sp]
	bl ObjRect__SetBox2D
_02154894:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void DecorationSys__State_21548A8(StageDecoration *work)
{
    if ((work->objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
    {
        work->objWork.userTimer--;
        if (work->objWork.userTimer <= 0)
            work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

NONMATCH_FUNC void DecorationSys__OnDefend_21548D4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/7Cnee -> 82.27%
#ifdef NON_MATCHING
    static u8 animTable[] = { 0, 1, 4, 5 };

    DecorationCommon *decor = (DecorationCommon *)rect2->parent;
    Player *player          = (Player *)rect1->parent;

    if (decor == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    switch (decor->decorWork.mapDecor->id)
    {
        case MAPDECOR_276:
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
            {
                if (MATH_ABS(player->objWork.move.x) + MATH_ABS(player->objWork.move.y) > FLOAT_TO_FX32(1.0))
                {
                    decor->decorWork.objWork.userTimer = 32;

                    if ((mtMathRand() & 1) != 0)
                    {
                        s32 count = (mtMathRand() & 1) + 3;

                        fx32 moveX = player->objWork.move.x >> 1;
                        fx32 moveY = player->objWork.move.y >> 1;
                        fx32 leafX = player->objWork.position.x - moveX * (count >> 1);
                        fx32 leafY = player->objWork.position.y - moveY * (count >> 1);

                        fx32 velY = 0;
                        for (s32 i = 0; i < count; i++)
                        {
                            DecorationSys__CreateTripleGrindRailLeaf(leafX + FLOAT_TO_FX32(8.0) - (mtMathRand() & 0xFFFF), leafY + FLOAT_TO_FX32(4.0) - (mtMathRand() & 0x7FFF),
                                                                FLOAT_TO_FX32(2.0) - (mtMathRand() & 0x3FFF), FLOAT_TO_FX32(1.0) - (mtMathRand() & 0x1FFF) + velY, animTable[i]);

                            leafX += moveX;
                            velY -= FLOAT_TO_FX32(0.25);
                            leafY += moveY;
                        }
                    }
                }
            }
            break;

        case MAPDECOR_281:
        case MAPDECOR_282:
            if ((player->objWork.moveFlag & (STAGE_TASK_MOVE_FLAG_400000 | STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR)) != 0)
            {
                if (MATH_ABS(player->objWork.move.x) > FLOAT_TO_FX32(0.5) || player->objWork.move.y)
                {
                    decor->decorWork.objWork.userTimer = 4;

                    EffectWaterWake *effect = CreateEffectWaterWakeForPlayer2(player);
                    if (decor->decorWork.mapDecor->id == MAPDECOR_281)
                        StageTask__SetAnimatorPriority(&effect->objWork, SPRITE_PRIORITY_1);
                }
            }
            break;
    }

    decor->decorWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	str r1, [sp, #0x14]
	cmpne r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x14]
	ldr r1, [r1, #0x20c]
	ldrh r2, [r1, #2]
	cmp r2, #0x114
	beq _02154934
	ldr r1, =0x00000119
	cmp r2, r1
	addne r1, r1, #1
	cmpne r2, r1
	beq _02154AE4
	b _02154B44
_02154934:
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02154B44
	ldr r1, [r0, #0xc0]
	ldr r2, [r0, #0xbc]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	add r1, r2, r1
	cmp r1, #0x1000
	ble _02154B44
	ldr r11, =_mt_math_rand
	ldr r1, [sp, #0x14]
	mov r2, #0x20
	str r2, [r1, #0x2c]
	ldr r1, [r11, #0]
	ldr r5, =0x00196225
	ldr r6, =0x3C6EF35F
	mla r3, r1, r5, r6
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r3, [r11]
	tst r1, #1
	beq _02154B44
	mla r2, r3, r5, r6
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	str r2, [r11]
	add r1, r1, #3
	str r1, [sp, #8]
	ldr r1, [r0, #0xbc]
	ldr r3, [r0, #0xc0]
	mov r1, r1, asr #1
	str r1, [sp, #0x10]
	ldr r1, [sp, #8]
	ldr r4, [r0, #0x44]
	mov r2, r1, asr #1
	mov r1, r3, asr #1
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x10]
	mov r9, #0
	mul r3, r1, r2
	ldr r1, [sp, #0xc]
	sub r7, r4, r3
	mul r2, r1, r2
	ldr r1, [r0, #0x48]
	ldr r0, [sp, #8]
	sub r8, r1, r2
	cmp r0, #0
	ble _02154B44
	ldr r0, =_02188780
	ldr r4, =0x0000FFFE
	str r0, [sp, #4]
	sub r0, r4, #0x8000
	str r0, [sp, #0x20]
	sub r0, r4, #0xc000
	str r0, [sp, #0x1c]
	sub r0, r4, #0xe000
	mov r10, r9
	str r0, [sp, #0x18]
_02154A34:
	ldr r0, [sp, #4]
	ldr r2, [r11, #0]
	ldrb r1, [r0], #1
	str r0, [sp, #4]
	mla r0, r2, r5, r6
	mov r2, r0, lsr #0x10
	mov r3, r2, lsl #0x10
	mla r2, r0, r5, r6
	mla lr, r2, r5, r6
	ldr r0, [sp, #0x18]
	mla ip, lr, r5, r6
	and r0, r0, r3, lsr #16
	rsb r0, r0, r4, lsr #4
	add r3, r10, r0
	mov r0, r2, lsr #0x10
	str ip, [r11]
	str r1, [sp]
	ldr r2, [sp, #0x1c]
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	rsb r2, r0, r4, lsr #3
	mov r0, lr, lsr #0x10
	ldr r1, [sp, #0x20]
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	rsb r0, r0, r4, lsr #2
	add r1, r8, r0
	ldr r0, [r11, #0]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r4, r0, lsr #16
	rsb r0, r0, r4, lsr #1
	add r0, r7, r0
	bl DecorationSys__CreateTripleGrindRailLeaf
	ldr r0, [sp, #0x10]
	add r9, r9, #1
	add r7, r7, r0
	ldr r0, [sp, #0xc]
	sub r10, r10, #0x400
	add r8, r8, r0
	ldr r0, [sp, #8]
	cmp r9, r0
	blt _02154A34
	b _02154B44
_02154AE4:
	ldr r2, [r0, #0x1c]
	ldr r1, =0x00400001
	tst r2, r1
	beq _02154B44
	ldr r1, [r0, #0xbc]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, #0x800
	bgt _02154B14
	ldr r1, [r0, #0xc0]
	cmp r1, #0
	beq _02154B44
_02154B14:
	ldr r1, [sp, #0x14]
	mov r2, #4
	str r2, [r1, #0x2c]
	bl CreateEffectWaterWakeForPlayer2
	ldr r1, [sp, #0x14]
	ldr r2, [r1, #0x20c]
	ldr r1, =0x00000119
	ldrh r2, [r2, #2]
	cmp r2, r1
	bne _02154B44
	mov r1, #1
	bl StageTask__SetAnimatorPriority
_02154B44:
	ldr r0, [sp, #0x14]
	ldr r0, [r0, #0x18]
	orr r1, r0, #2
	ldr r0, [sp, #0x14]
	str r1, [r0, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 DecorationSys__Func_2154B7C(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mvn r0, #0
	ldr r3, =decorUnknownList
	mov r4, r0
	mov ip, #0
_02154B94:
	add r2, r3, ip, lsl #3
	ldrsh r1, [r2, #4]
	cmp r1, #0
	beq _02154BB8
	ldrh r1, [r2, #6]
	cmp r5, r1
	bne _02154BBC
	mov r0, ip
	b _02154BC8
_02154BB8:
	mov r4, ip
_02154BBC:
	add ip, ip, #1
	cmp ip, #4
	blt _02154B94
_02154BC8:
	mvn r1, #0
	cmp r0, r1
	bne _02154C0C
	cmp r4, r1
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl DecorationSys__CreateTempDecoration
	ldr r1, =decorUnknownList
	mov r2, r4, lsl #3
	str r0, [r1, r4, lsl #3]
	str r4, [r0, #0x2c]
	ldr r1, =0x02189EB2
	mov r0, r4
	strh r5, [r1, r2]
_02154C0C:
	ldr r3, =0x02189EB0
	mov r2, r0, lsl #3
	ldrsh r1, [r3, r2]
	add r1, r1, #1
	strh r1, [r3, r2]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void DecorationSys__Func_2154C30(s32 id)
{
    if (decorUnknownList[id].timer != 0)
    {
        decorUnknownList[id].timer--;
        if (decorUnknownList[id].timer == 0)
        {
            decorUnknownList[id].lastDecor->objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME;
            decorUnknownList[id].lastDecor = NULL;
            decorUnknownList[id].lastType  = MAPDECOR_0;
        }
    }
}

void DecorationSys__InitFunc_2154C90(StageDecoration *work)
{
    SetDecorOutFunc(&work->objWork, DecorationSys__Draw_2154D14);
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->destructor = DecorationSys__Destructor_2154CCC;
    AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
}

void DecorationSys__Destructor_2154CCC(StageDecoration *work)
{
    s32 id = work->objWork.userTimer;
    if (decorUnknownList[id].lastDecor == work)
    {
        decorUnknownList[id].lastDecor = NULL;
        decorUnknownList[id].timer     = 0;
        decorUnknownList[id].lastType  = MAPDECOR_0;
    }

    DecorationSys__Destructor_21535B8(work);
}

void DecorationSys__Draw_2154D14(StageDecoration *work)
{
    AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
}

void DecorationSys__InitFunc_2154D2C(StageDecoration *work)
{
    u16 type = 0xFFFF;
    switch (work->mapDecor->id)
    {
        case MAPDECOR_271:
            type = 298;
            break;

        case MAPDECOR_254:
            type = 299;
            break;

        case MAPDECOR_64:
            type = 300;
            break;

        case MAPDECOR_277:
            type = 301;
            break;

        case MAPDECOR_278:
            type = 302;
            break;

        case MAPDECOR_279:
            type = 303;
            break;

        case MAPDECOR_280:
            type = 304;
            break;
    }

    if (type != 0xFFFF)
    {
        s32 id = DecorationSys__Func_2154B7C(type);
        if (id != -1)
        {
            StageDecoration *lastDecor = decorUnknownList[id].lastDecor;

            work->objWork.userTimer = id;
            work->objWork.obj_2d    = lastDecor->objWork.obj_2d;
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB;
            work->destructor = DecorationSys__Destructor_2154E20;
        }
    }
}

void DecorationSys__Destructor_2154E20(StageDecoration *work)
{
    work->objWork.obj_2d = NULL;

    DecorationSys__Func_2154C30(work->objWork.userTimer);
    DecorationSys__Destructor_21535B8(work);
}

void DecorationSys__SetAnimation(StageDecoration *work, u16 anim)
{
    AnimatorSpriteDS__SetAnimation(&work->objWork.obj_2d->ani, anim);

    for (s32 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
    {
        if (work->objWork.colliderList[c] != NULL && work->objWork.colliderFlags[c] != STAGE_TASK_COLLIDER_FLAGS_NONE)
            work->objWork.colliderList[c]->flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }
}
