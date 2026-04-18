#ifndef RUSH_SEAMAPMANAGER_H
#define RUSH_SEAMAPMANAGER_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>
#include <seaMap/seaMapCommon.h>
#include <seaMap/seaMapEventManager.h>
#include <game/save/saveGame.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define SEAMAP_WIDTH 192
#define SEAMAP_HEIGHT 72

// --------------------
// ENUMS
// --------------------

enum SeaMapManagerSaveFlag_
{
    SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND,
    SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM,
    SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH,
    SEAMAPMANAGER_DISCOVER_CORAL_CAVE,
    SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP,
    SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS,
    SEAMAPMANAGER_DISCOVER_SKY_BABYLON,
    SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND,
    SEAMAPMANAGER_DISCOVER_BIG_SWELL,
    SEAMAPMANAGER_DISCOVER_DEEP_CORE,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2,
    SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND,
    SEAMAPMANAGER_DISCOVER_13, // Unknown
    SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5,
    SEAMAPMANAGER_DISCOVER_18, // Unknown
    SEAMAPMANAGER_DISCOVER_19, // Unknown
    SEAMAPMANAGER_DISCOVER_20, // Unknown
    SEAMAPMANAGER_DISCOVER_21, // Unknown
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15,
    SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16,
    SEAMAPMANAGER_DISCOVER_33, // Unknown
    SEAMAPMANAGER_DISCOVER_34, // Unknown
    SEAMAPMANAGER_DISCOVER_35, // Unknown
    SEAMAPMANAGER_DISCOVER_36, // Unknown
    SEAMAPMANAGER_DISCOVER_37, // Unknown
    SEAMAPMANAGER_DISCOVER_38, // Unknown
    SEAMAPMANAGER_DISCOVER_39, // Unknown
    SEAMAPMANAGER_DISCOVER_40, // Unknown
    SEAMAPMANAGER_DISCOVER_41, // Unknown
    SEAMAPMANAGER_DISCOVER_42, // Unknown

    SEAMAPMANAGER_DISCOVER_43, // Unknown
    SEAMAPMANAGER_DISCOVER_44, // Unknown
    SEAMAPMANAGER_DISCOVER_45, // Unused
    SEAMAPMANAGER_DISCOVER_46, // Unused
    SEAMAPMANAGER_DISCOVER_47, // Unused
    SEAMAPMANAGER_DISCOVER_48, // Unused
    SEAMAPMANAGER_DISCOVER_49, // Unused
    SEAMAPMANAGER_DISCOVER_50, // Unused
    SEAMAPMANAGER_DISCOVER_51, // Unused
    SEAMAPMANAGER_DISCOVER_52, // Unused
    SEAMAPMANAGER_DISCOVER_53, // Unused
    SEAMAPMANAGER_DISCOVER_54, // Unused
    SEAMAPMANAGER_DISCOVER_55, // Unused
    SEAMAPMANAGER_DISCOVER_56, // Unused
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_1,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_2,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_3,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_4,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_5,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_6,
    SEAMAPMANAGER_DISCOVER_VS_JOHNNY_7,

    SEAMAPMANAGER_DISCOVER_COUNT,
    SEAMAPMANAGER_DISCOVER_ISLAND_COUNT = 42,
};
typedef u32 SeaMapManagerSaveFlag;

enum SeaMapManagerMapPixel_
{
    SEAMAPMANAGER_PIXEL_DISCOVERED,
    SEAMAPMANAGER_PIXEL_UNDISCOVERED,
};
typedef s32 SeaMapManagerMapPixel;

enum SeaMapManagerDrawFlags_
{
    SEAMAPMANAGER_DRAWFLAG_NONE = 0x00,

    SEAMAPMANAGER_DRAWFLAG_MAPMASK = 1 << 0,
    SEAMAPMANAGER_DRAWFLAG_MAPISLAND = 1 << 1,
    SEAMAPMANAGER_DRAWFLAG_MAPSEA = 1 << 2,
    SEAMAPMANAGER_DRAWFLAG_UNKNOWN = 1 << 3,

    SEAMAPMANAGER_DRAWFLAG_ALL = SEAMAPMANAGER_DRAWFLAG_MAPMASK | SEAMAPMANAGER_DRAWFLAG_MAPISLAND | SEAMAPMANAGER_DRAWFLAG_MAPSEA | SEAMAPMANAGER_DRAWFLAG_UNKNOWN,
};
typedef u32 SeaMapManagerDrawFlags;

enum SeaMapCollisionType_
{
    SEAMAP_COLLISION_0,
    SEAMAP_COLLISION_1,
    SEAMAP_COLLISION_2,
    SEAMAP_COLLISION_3,
    SEAMAP_COLLISION_4,
    SEAMAP_COLLISION_5,
    SEAMAP_COLLISION_6,
    SEAMAP_COLLISION_7,
    SEAMAP_COLLISION_8,
    SEAMAP_COLLISION_9,
    SEAMAP_COLLISION_10,
    SEAMAP_COLLISION_11,
    SEAMAP_COLLISION_12,
    SEAMAP_COLLISION_13,
    SEAMAP_COLLISION_14,
    SEAMAP_COLLISION_15,

    SEAMAP_COLLISION_COUNT,
};
typedef u8 SeaMapCollisionType;

// --------------------
// STRUCTS
// --------------------

struct SeaMapLayoutHeader
{
    u16 width;
    u16 height;
};

struct SeaMapAttributeLayoutValue
{
    u8 value1 : 4;
    u8 value2 : 4;
};

struct CHLVValue
{
    u8 value1 : 2;
    u8 value2 : 2;
    u8 value3 : 2;
    u8 value4 : 2;
};

struct SeaMapCollisionLayoutValue
{
    SeaMapCollisionType value1 : 4;
    SeaMapCollisionType value2 : 4;
};

struct SeaMapAttributeLayout
{
    struct SeaMapLayoutHeader header;
    struct SeaMapAttributeLayoutValue data[1]; // C-variable length array
};

struct CHLV
{
    struct SeaMapLayoutHeader header;
    struct CHLVValue data[1]; // C-variable length array
};

struct SeaMapCollisionLayout
{
    struct SeaMapLayoutHeader header;
    struct SeaMapCollisionLayoutValue data[1]; // C-variable length array
};

typedef struct SeaMapManagerAssets_
{
    void *sprChCommon;
    SeaMapObjectLayout *objectLayout;
    struct SeaMapAttributeLayout *attributeLayout;
    struct CHLV *chlv;
    void *mapMask[SEAMAP_ZOOM_COUNT];
    void *mapIsland[SEAMAP_ZOOM_COUNT];
    void *mapSea[SEAMAP_ZOOM_COUNT];
    struct SeaMapCollisionLayout *mapCollision;
} SeaMapManagerAssets;

typedef struct SeaMapManagerUnknown_
{
    u8 field_0[96 * 288];
    u32 pixelBuffer[96 / 2][128 / 2];
    u16 ptr1[288];
    u16 ptr2[288];
    SeaMapManagerNodeList nodeList;
} SeaMapManagerUnknown;

typedef struct SeaMapManagerMapLayout_
{
    u32 layout[SEAMAP_HEIGHT / 32][SEAMAP_WIDTH / 32];
} SeaMapManagerMapLayout;

typedef struct SeaMapManagerMapFlags_
{
    u8 values[256 / 32];
} SeaMapManagerMapFlags;

typedef struct SeaMapManager_
{
    SeaMapZoomLevel zoomLevel;
    Vec2Fx32 position;
    Vec2Fx32 lastPosition;

    union
    {
        struct
        {
            Background mapMask;
            Background mapIsland;
            Background mapSea;
        };

        Background array[3];
    } backgrounds;

    s32 field_EC;
    s32 field_F0;
    s32 field_F4;
    s32 field_F8;
    s32 field_FC;
    s32 field_100;
    s32 field_104;
    s32 field_108;
    s32 field_10C;
    s32 field_110;
    s32 field_114;
    s32 field_118;
    s32 field_11C;
    s32 field_120;
    s32 field_124;
    s32 field_128;
    s32 field_12C;
    s32 field_130;
    SeaMapManagerDrawFlags drawFlags;
    SeaMapManagerUnknown *unknownPtr;
    TouchField touchField;
    BOOL touchFieldActive;
    BOOL useEngineB;
    SeaMapManagerAssets assets;
    ShipType shipType;
    void (*state)(struct SeaMapManager_ *work);
} SeaMapManager;

// --------------------
// FUNCTIONS
// --------------------

void SeaMapManager__SaveClearCallback_Chart(SaveGame *save, SaveBlockFlags blockFlags);
void SeaMapManager__Create(BOOL useEngineB, ShipType shipType, BOOL isSailing);
void SeaMapManager__Destroy(void);
BOOL SeaMapManager__IsActive(void);
SeaMapManager *SeaMapManager__GetWork(void);
void SeaMapManager__EnableTouchField(BOOL enabled);
void SeaMapManager__EnableDrawFlags(SeaMapManagerDrawFlags flags);
void SeaMapManager__SetZoomLevel(SeaMapZoomLevel level);
SeaMapZoomLevel SeaMapManager__GetZoomLevel(void);
fx32 SeaMapManager__GetZoomOutScale(void);
fx32 SeaMapManager__GetZoomInScale(void);
void SeaMapManager__Draw(SeaMapManager *work);
void SeaMapManager__Draw_MapMask(SeaMapManager *work);
void SeaMapManager__Draw_MapIsland(SeaMapManager *work);
void SeaMapManager__Draw_MapSea(SeaMapManager *work);
void SeaMapManager__Draw_Unknown(SeaMapManager *work);
void SeaMapManager__Func_2043974(fx32 x, fx32 y);
fx32 SeaMapManager__GetXPos(void);
fx32 SeaMapManager__GetYPos(void);
void SeaMapManager__GetPosition(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
void SeaMapManager__Func_2043A04(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__ConvertWorldPosToMapPos(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043A9C(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043AD4(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043B0C(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043B28(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__GetPosition2(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
void SeaMapManager__Func_2043B60(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043B7C(u8 inX, u8 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043BB4(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043BD0(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043BEC(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
void SeaMapManager__Func_2043C08(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
void SeaMapManager__ClearSaveFlags(u8 *flags);
BOOL SeaMapManager__GetSaveFlag_(SeaMapManagerMapFlags *flags, s32 id);
BOOL SeaMapManager__GetSaveFlag(SeaMapManagerSaveFlag id);
void SeaMapManager__SetSaveFlag_(SeaMapManagerMapFlags *flags, s32 id, BOOL state);
void SeaMapManager__SetSaveFlag(SeaMapManagerSaveFlag id, BOOL state);
void SeaMapManager__LoadMapBackground(void);
SeaMapManagerMapPixel SeaMapManager__GetMapPixel(u16 x, u16 y);
void SeaMapManager__DiscoverMap_Pixel(s32 x, s32 y);
void SeaMapManager__DiscoverMap_Rect(u16 left, u16 top, u16 right, u16 bottom);
void SeaMapManager__DiscoverMap_Elipse(u16 centerX, u16 centerY, u16 radiusX, u16 radiusY);
void SeaMapManager__ClearGlobalNodeList(void);
void SeaMapManager__UpdateGlobalNodeList(void);
void SeaMapManager__LoadNodeList(void);
void SeaMapManager__SetUnknown1(s32 a1);
s32 SeaMapManager__GetUnknown1(void);
void SeaMapManager__ClearSeaMap(void *saveBlockChart);
SeaMapManagerMapFlags *SeaMapManager__GetSaveBlockFlags(void);
SeaMapManagerMapLayout *SeaMapManager__GetSaveMap(void);
void SeaMapManager__InitArchives(ShipType shipType, BOOL isSailing);
void SeaMapManager__Release(void);
void SeaMapManager__LoadAssets(SeaMapManagerAssets *work);
void SeaMapManager__InitBackgrounds(SeaMapManager *work);
void SeaMapManager__SetupDisplay(BOOL useEngineB);
void SeaMapManager__GetOBJBankInfo(BOOL useEngineB, GXOBJVRamModeChar *bankMode, u16 *bankSize);
void SeaMapManager__LoadBackgroundPixels(SeaMapManager *work);
void SeaMapManager__LoadBackgroundPalette(SeaMapManager *work);
void SeaMapManager__Main(void);
void SeaMapManager__Destructor(Task *task);
void SeaMapManager__State_2044DC8(SeaMapManager *work);
void SeaMapManager__DrawNodeLine2(u16 x1, u16 y1, u16 x2, u16 y2, u16 type);
void SeaMapManager__DrawNodeLine(s32 x, s32 y, u32 a3);
void SeaMapManager__Func_2044F24(u16 x, u16 y);
void SeaMapManager__ClearUnknownPtr(void);
void SeaMapManager__Func_204506C(Vec2Fx32 *a1, MtxFx22 *mtx, Vec2Fx32 *a3, Vec2Fx32 *a4);
void SeaMapManager__ResetPtr1Ptr2(void *ptr1, void *ptr2);
void SeaMapManager__Func_2045128(u8 *a1, u16 *ptr1, u16 *ptr2, u32 pos, u32 size);
void SeaMapManager__Func_20451A4(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, u32 *a5, u32 *a6, s32 a7);
void SeaMapManager__Func_20452F0(s32 a1, s32 a2, s32 a3, s32 a4, u32 a5, u32 *a6, u32 *a7, u32 *a8, u32 *a9);
void SeaMapManager__Func_2045380(u32 *a1, u32 *a2, s32 *a3, s32 *a4, s32 a5, s32 a6);
void SeaMapManager__DrawThickLine(u8 *field_0, u16 *ptr1, u16 *ptr2, u16 x1, u16 y1, u16 x2, u16 y2, u16 thickness);
void SeaMapManager__DrawThinLine(u8 *pixels, u16 startX, u16 startY, u16 endX, u16 endY);
void SeaMapManager__Func_2045A58(s32 a1, s16 a2, u32 a3, s32 a4, s32 a5);
void SeaMapManager__Func_2045BF8(fx32 targetDistance, fx32 *x, fx32 *y);
fx32 SeaMapManager__AddNode(u16 x, u16 y);
u32 SeaMapManager__RemoveNode(void);
void SeaMapManager__RemoveAllNodes(void);
SeaMapManagerNode *SeaMapManager__GetStartNode(void);
SeaMapManagerNode *SeaMapManager__GetEndNode(void);
SeaMapManagerNode *SeaMapManager__GetNextNode(SeaMapManagerNode *node);
SeaMapManagerNode *SeaMapManager__GetPrevNode(SeaMapManagerNode *node);
u32 SeaMapManager__GetNodeCount(void);
fx32 SeaMapManager__GetTotalDistance(void);
void SeaMapManager__GetLastNodePosition(fx16 *x, fx16 *y);
void SeaMapManager__Func_2045E58(u32 nodeCount);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SEAMAPMANAGER_H