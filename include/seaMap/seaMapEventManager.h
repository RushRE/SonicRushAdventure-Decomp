#ifndef RUSH_SEAMAPEVENTMANAGER_H
#define RUSH_SEAMAPEVENTMANAGER_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/stage/mapSys.h>

// --------------------
// TYPES
// --------------------

typedef struct SeaMapLayoutObject_ SeaMapLayoutObject;
typedef struct SeaMapLayoutObjectType_ SeaMapLayoutObjectType;

typedef struct SeaMapObject_ SeaMapObject;

typedef SeaMapObject *(*SeaMapObjCreateFunc)(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);
typedef BOOL (*SeaMapObjArrivalCheck)(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL flag);

typedef struct SeaMapIslandDrawIcon_ SeaMapIslandDrawIcon;
typedef struct SeaMapBoatIcon_ SeaMapBoatIcon;

// --------------------
// CONSTANTS
// --------------------

#define SEAMAPEVENTMANAGER_CREATE_OBJECT_LIST_SIZE 16

// --------------------
// ENUMS
// --------------------

enum SeaMapObjectIDs
{
    SEAMAPOBJECT_ISLAND_DRAW_ICON,
    SEAMAPOBJECT_UNUSED,             // Empty slot
    SEAMAPOBJECT_ISLAND_ICON_ELIPSE, // Never placed, created once when discovering coral cave to mark discovery area
    SEAMAPOBJECT_ISLAND_ICON_RECT,
    SEAMAPOBJECT_JOHNNY_ICON,
    SEAMAPOBJECT_UNKNOWN_ENCOUNTER, // Never placed, never meaningfully referenced
    SEAMAPOBJECT_CORAL_CAVE_ICON,
    SEAMAPOBJECT_SKY_BABYLON_ICON,
    SEAMAPOBJECT_TARGET_FLAG_ICON,
    SEAMAPOBJECT_BOAT_ICON,
    SEAMAPOBJECT_STYLUS_PROMPT,
    SEAMAPOBJECT_DS_POPUP,
    SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND, // Major island discovery (zones)
    SEAMAPOBJECT_SPARKLES_MINOR_ISLAND, // Minor island discovery (hidden islands + extras)

    SEAMAPOBJECT_COUNT,

    SEAMAPOBJECT_NONE = -1,
};

enum SeaMapLayoutObjectSysFlags_
{
    SEAMAPLAYOUTOBJECT_SYSFLAG_NONE = 0x00,

    SEAMAPLAYOUTOBJECT_SYSFLAG_SPAWN_INSTANTLY = 1 << 0,
    SEAMAPLAYOUTOBJECT_SYSFLAG_NON_MAP_OBJECT  = 1 << 7,
};
typedef u8 SeaMapLayoutObjectSysFlags;
typedef u8 SeaMapLayoutObjectUserFlags;

// --------------------
// STRUCTS
// --------------------

struct SeaMapLayoutObject_
{
    u16 type;
    Vec2Fx16 position;
    SeaMapLayoutObjectSysFlags sysFlags;
    SeaMapLayoutObjectUserFlags usrFlags;
    HitboxRect box;
    s16 id;
};

struct SeaMapLayoutObjectType_
{
    u16 animID;
    u16 palette;
    s8 viewBounds[2];
    SeaMapObjCreateFunc createFunc;
    SeaMapObjArrivalCheck arrivalCheck;
};

struct SeaMapObject_
{
    Task *task;
    const SeaMapLayoutObjectType *objectType;
    SeaMapLayoutObject *mapObject;
    Vec2Fx16 position;
};

typedef struct SeaMapObjectLayoutDrawIconList_
{
    u16 count;
    u16 iconList[1];
} SeaMapObjectLayoutDrawIconList;

typedef struct SeaMapObjectLayout_
{
    u16 count;
    SeaMapLayoutObject objectList[1];
} SeaMapObjectLayout;

typedef struct SeaMapVoyageVisibleIsland_
{
    SeaMapLayoutObject *object;
    u32 radius;
} SeaMapVoyageVisibleIsland;

typedef struct SeaMapEventManager_
{
    s32 lastTouchedIconType;
    SeaMapIslandDrawIcon *lastTouchedIcon;
    SeaMapLayoutObject objectList[SEAMAPEVENTMANAGER_CREATE_OBJECT_LIST_SIZE];
    AnimatorSprite aniJohnny;
    AnimatorSprite aniJohnnyDefeated;
    AnimatorSprite aniTargetFlag;
    Task *dsPopup;
    Task *coralCaveIcon;
    Task *skyBabylonIcon;
} SeaMapEventManager;

// --------------------
// VARIABLES
// --------------------

extern Task *gSeaMapEventManagerTaskSingleton;

extern const SeaMapLayoutObjectType gSeaMapObjectTypeList[SEAMAPOBJECT_COUNT];

// --------------------
// FUNCTIONS
// --------------------

BOOL SeaMapEventManager_CheckIslandUnlocked(u32 id);
void CreateSeaMapEventManager(void);
void DestroySeaMapEventManager(void);
SeaMapObject *SeaMapEventManager_CreateObject(s32 type, s16 x, s16 y, u8 flags, HitboxRect *box, s16 id);
SeaMapEventManager *GetSeaMapEventManagerWork2(void);
void SeaMapEventManager_ClearLastTouchedIcon(void);
void SeaMapEventManager_ClearDrawIconButtonState(SeaMapIslandDrawIcon *icon);
SeaMapLayoutObject *SeaMapEventManager_GetObjectFromID(u32 id);
void SeaMapEventManager_FindVisibleIslands(fx32 shipX, fx32 shipY, fx32 distanceThreshold, SeaMapVoyageVisibleIsland *islandList, u16 *islandCount);
u32 SeaMapEventManager_GetObjectType(SeaMapLayoutObject *mapObject);
BOOL SeaMapEventManager__IsObjectActive(SeaMapLayoutObject *mapObject);
u32 SeaMapEventManager_GetDiscoverableIslandID(s16 id);
u32 SeaMapEventManager_GetLandableIslandID(u32 id);
void SeaMapEventManager_SetBoatDirection(SeaMapBoatIcon *boat, BOOL facingLeft);
SeaMapObject *CreateSeaMapEventManagerStylusIcon(fx32 startX, fx32 startY, fx32 endX, fx32 endY, s16 speed);
void DestroySeaMapEventManagerStylusIcon(SeaMapObject *work);
void CreateSeaMapEventManagerDSPopup(void);
void DestroySeaMapEventManagerDSPopup(void);
void SeaMapEventManager_UnlockCoralCave(void);
void SeaMapEventManager_UnlockSkyBabylon(void);
void SeaMapEventManager_ProcessAnimator(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
BOOL SeaMapEventManager_CheckIslandDiscovered(u32 id);
SeaMapEventManager *GetSeaMapEventManagerWork(void);
void SeaMapEventManager_SpawnInitialObjects(void);
void SeaMapEventManager_Main(void);
void SeaMapEventManager_Destructor(Task *task);
void InitSeaMapEventManagerObject(SeaMapObject *work, Task *task, const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);
void DestroySeaMapEventManagerObject(SeaMapObject *work);
BOOL SeaMapEventManager_CheckVisible(Vec2Fx16 *objPos, const s8 *viewBounds);
void SeaMapEventManager_GetMapLocalPosition(Vec2Fx16 *a1, Vec2Fx16 *a2);
void SeaMapEventManager_SetObjectAsActive(SeaMapObject *work);
void SeaMapEventManager_SetObjectAsInactive(SeaMapObject *work);
BOOL SeaMapEventManager_CheckObjectPosDiscoveredOnMap(SeaMapLayoutObject *mapObject);
void SeaMapEventManager_GetViewElipse(HitboxRect *rect, fx32 x, fx32 y, s32 *centerX, s32 *centerY, s32 *width, s32 *height);
void SeaMapEventManager_GetViewRect(HitboxRect *rect, fx32 x, fx32 y, ViewRect *viewRect);
BOOL SeaMapEventManager_PointInViewElipse(s32 centerX, s32 centerY, s32 width, s32 height, fx32 x, fx32 y);
BOOL SeaMapEventManager_PointInViewRect(s32 left, s32 top, s32 right, s32 bottom, fx32 x, fx32 y);
BOOL SeaMapEventManager_ViewRectCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y);
BOOL SeaMapEventManager_ViewElipseCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y);

#endif // RUSH_SEAMAPEVENTMANAGER_H