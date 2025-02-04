#ifndef RUSH_SEAMAPMANAGER_H
#define RUSH_SEAMAPMANAGER_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum ShipType_
{
    SHIP_JET,
    SHIP_BOAT,
    SHIP_HOVER,
    SHIP_SUBMARINE,

    SHIP_COUNT,

    SHIP_MENU = SHIP_COUNT, // SeaMap menu
};
typedef u32 ShipType;

enum ShipLevel_
{
    SHIP_LEVEL_0,
    SHIP_LEVEL_1,
    SHIP_LEVEL_2,

    SHIP_LEVEL_MAX = SHIP_LEVEL_2,
};
typedef u32 ShipLevel;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapManagerAssets_
{
    void *sprChCommon;
    void *objectLayout;
    void *chat;
    void *chlv;
    void *mapMask[3];
    void *mapIsland[3];
    void *mapSea[3];
    void *mapCollision;
} SeaMapManagerAssets;

typedef struct SeaMapManagerNode_
{
    NNSFndLink link;
    TouchPos position;
    fx32 distance;
} SeaMapManagerNode;

typedef struct SeaMapManagerNodeGroup_
{
    NNSFndLink link;
    SeaMapManagerNode entryList[64];
    u16 entryCount;
} SeaMapManagerNodeGroup;

typedef struct SeaMapManagerNodeList_
{
    NNSFndList nodes;
    NNSFndList groups;
} SeaMapManagerNodeList;

typedef struct SeaMapManager_
{
    s32 zoomLevel;
    Vec2Fx32 position;
    Vec2Fx32 lastPosition;
    Background backgrounds[3];
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
    u32 drawFlags;
    void *unknownPtr;
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

NOT_DECOMPILED void SeaMapManager__SaveClearCallback_Chart(void *saveGame, u8 flags);
NOT_DECOMPILED void SeaMapManager__Create(BOOL useEngineB, ShipType shipType, BOOL isSailing);
NOT_DECOMPILED void SeaMapManager__Destroy(void);
NOT_DECOMPILED BOOL SeaMapManager__IsActive(void);
NOT_DECOMPILED SeaMapManager *SeaMapManager__GetWork(void);
NOT_DECOMPILED void SeaMapManager__EnableTouchField(BOOL enabled);
NOT_DECOMPILED void SeaMapManager__EnableDrawFlags(u32 flags);
NOT_DECOMPILED void SeaMapManager__SetZoomLevel(u32 level);
NOT_DECOMPILED u32 SeaMapManager__GetZoomLevel(void);
NOT_DECOMPILED fx32 SeaMapManager__GetZoomOutScale(void);
NOT_DECOMPILED fx32 SeaMapManager__GetZoomInScale(void);
NOT_DECOMPILED void SeaMapManager__Draw(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Draw0(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Draw1(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Draw2(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Draw3(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Func_2043974(fx32 x, fx32 y);
NOT_DECOMPILED fx32 SeaMapManager__GetXPos(void);
NOT_DECOMPILED fx32 SeaMapManager__GetYPos(void);
NOT_DECOMPILED void SeaMapManager__GetPosition(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043A04(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043A80(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043A9C(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043AD4(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043B0C(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043B28(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__GetPosition2(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043B60(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043B7C(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043BB4(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043BD0(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043BEC(fx32 inX, fx32 inY, fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2043C08(fx32 inX, fx32 inY, fx32 *x, fx32 *y);
NOT_DECOMPILED void SeaMapManager__ClearSaveFlags(u8 *flags);
NOT_DECOMPILED BOOL SeaMapManager__GetSaveFlag_(u8 *flags, u32 id);
NOT_DECOMPILED BOOL SeaMapManager__GetSaveFlag(u32 id);
NOT_DECOMPILED void SeaMapManager__SetSaveFlag_(u8 *flags, u32 id, BOOL state);
NOT_DECOMPILED void SeaMapManager__SetSaveFlag(u32 id, BOOL state);
NOT_DECOMPILED void SeaMapManager__Func_2043D08(void);
NOT_DECOMPILED s32 SeaMapManager__GetMapPixel(s32 x, s32 y);
NOT_DECOMPILED void SeaMapManager__Func_2043FDC(s32 x, s32 y);
NOT_DECOMPILED void SeaMapManager__Func_2044268(s32 x, u32 y, u32 a3, u32 a4);
NOT_DECOMPILED void SeaMapManager__Func_20442C8(u32 x, s32 y, s32 a3, s32 a4);
NOT_DECOMPILED void SeaMapManager__ClearGlobalNodeList(void);
NOT_DECOMPILED void SeaMapManager__UpdateGlobalNodeList(void);
NOT_DECOMPILED void SeaMapManager__Func_20444E8(void);
NOT_DECOMPILED void SeaMapManager__SetUnknown1(s32 a1);
NOT_DECOMPILED s32 SeaMapManager__GetUnknown1(void);
NOT_DECOMPILED void SeaMapManager__ClearSeaMap(void *saveBlockChart);
NOT_DECOMPILED u8 *SeaMapManager__GetSaveBlockFlags(void);
NOT_DECOMPILED u32 *SeaMapManager__GetSaveMap(void);
NOT_DECOMPILED void SeaMapManager__InitArchives(ShipType shipType, BOOL isSailing);
NOT_DECOMPILED void SeaMapManager__Release(void);
NOT_DECOMPILED void SeaMapManager__LoadAssets(SeaMapManagerAssets *work);
NOT_DECOMPILED void SeaMapManager__InitBackgrounds(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__SetupDisplay(BOOL useEngineB);
NOT_DECOMPILED void SeaMapManager__GetOBJBankInfo(BOOL useEngineB, GXOBJVRamModeChar *bankMode, u16 *bankSize);
NOT_DECOMPILED void SeaMapManager__LoadBackgroundPixels(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__LoadBackgroundPalette(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Main(void);
NOT_DECOMPILED void SeaMapManager__Destructor(Task *task);
NOT_DECOMPILED void SeaMapManager__State_2044DC8(SeaMapManager *work);
NOT_DECOMPILED void SeaMapManager__Func_2044DCC(u32 a1, u32 a2, u32 a3, u32 a4, u16 a5);
NOT_DECOMPILED void SeaMapManager__Func_2044E60(s32 x, s32 y, u32 a3);
NOT_DECOMPILED void SeaMapManager__Func_2044F24(s16 a1, s16 a2);
NOT_DECOMPILED void SeaMapManager__ClearUnknownPtr(void);
NOT_DECOMPILED void SeaMapManager__Func_204506C(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4);
NOT_DECOMPILED void SeaMapManager__ResetPtr1Ptr2(void *ptr1, void *ptr2);
NOT_DECOMPILED void SeaMapManager__Func_2045128(u8 *a1, u16 *ptr1, u16 *ptr2, u32 pos, u32 size);
NOT_DECOMPILED void SeaMapManager__Func_20451A4(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, u32 *a5, u32 *a6, s32 a7);
NOT_DECOMPILED void SeaMapManager__Func_20452F0(s32 a1, s32 a2, s32 a3, s32 a4, u32 a5, u32 *a6, u32 *a7, u32 *a8, u32 *a9);
NOT_DECOMPILED void SeaMapManager__Func_2045380(u32 *a1, u32 *a2, s32 *a3, s32 *a4, s32 a5, s32 a6);
NOT_DECOMPILED void SeaMapManager__Func_2045798(u8 *a1, u16 *ptr1, u16 *ptr2, s32 a4, u16 a5, u16 a6, u16 a7, u16 a8);
NOT_DECOMPILED void SeaMapManager__Func_20458C8(s32 a1, s32 a2, u32 a3, u32 a4, u32 a5);
NOT_DECOMPILED void SeaMapManager__Func_2045A58(s32 a1, s16 a2, u32 a3, s32 a4, s32 a5);
NOT_DECOMPILED void SeaMapManager__Func_2045BF8(fx32 targetDistance, fx32 *x, fx32 *y);
NOT_DECOMPILED void SeaMapManager__AddNode(s16 x, s16 y);
NOT_DECOMPILED u32 SeaMapManager__RemoveNode(void);
NOT_DECOMPILED void SeaMapManager__RemoveAllNodes(void);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManager__GetStartNode(void);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManager__GetEndNode(void);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManager__GetNextNode(SeaMapManagerNode *node);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManager__GetPrevNode(SeaMapManagerNode *node);
NOT_DECOMPILED u32 SeaMapManager__GetNodeCount(void);
NOT_DECOMPILED fx32 SeaMapManager__GetTotalDistance(void);
NOT_DECOMPILED void SeaMapManager__GetLastNodePosition(fx16 *x, fx16 *y);
NOT_DECOMPILED void SeaMapManager__Func_2045E58(u32 nodeCount);

NOT_DECOMPILED void SeaMapManagerNodeList__Init(SeaMapManagerNodeList *work);
NOT_DECOMPILED void SeaMapManagerNodeList__Release(SeaMapManagerNodeList *work);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManagerNodeList__CopyNodes(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2);
NOT_DECOMPILED fx32 SeaMapManagerNodeList__GetNodeDistance(SeaMapManagerNode *node);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManagerNodeList__CopyNodesEx(SeaMapManagerNodeList *list1, SeaMapManagerNodeList *list2, u32 count);
NOT_DECOMPILED SeaMapManagerNodeGroup *SeaMapManagerNodeList__AddGroup(SeaMapManagerNodeList *list);
NOT_DECOMPILED u32 SeaMapManagerNodeList__RemoveLastGroup(SeaMapManagerNodeList *list);
NOT_DECOMPILED SeaMapManagerNodeGroup *SeaMapManagerNodeList__GetLastGroup(SeaMapManagerNodeList *list);
NOT_DECOMPILED u32 SeaMapManagerNodeList__GetGroupAvailableSize(SeaMapManagerNodeList *list);
NOT_DECOMPILED SeaMapManagerNode *SeaMapManagerNodeList__AddNode(SeaMapManagerNodeList *list);
NOT_DECOMPILED u32 SeaMapManagerNodeList__RemoveLastNode(SeaMapManagerNodeList *list);
NOT_DECOMPILED void SeaMapManagerNodeList__RemoveAllNodes(SeaMapManagerNodeList *list);
NOT_DECOMPILED void SeaMapManagerNodeList__CopyNode(SeaMapManagerNode *src, SeaMapManagerNode *dst);
NOT_DECOMPILED void SeaMapManagerNodeList__Func_204611C(SeaMapManagerNodeList *list, u32 count);
NOT_DECOMPILED void SeaMapManagerNodeList__Func_2046154(s32 x1, s32 y1, s32 x2, s32 y2);
NOT_DECOMPILED void SeaMapManagerNodeList__Func_2046240(SeaMapManagerNodeList *list, u32 count);
NOT_DECOMPILED void SeaMapManagerNodeList__Func_204634C(SeaMapManagerNodeList *list, u32 count);
NOT_DECOMPILED void SeaMapManagerNodeList__Func_204652C(SeaMapManagerNodeList *list, u32 count);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SEAMAPMANAGER_H