#ifndef RUSH_SEAMAPEVENTMANAGER_H
#define RUSH_SEAMAPEVENTMANAGER_H

#include <global.h>
#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/stage/mapSys.h>

// --------------------
// TYPES
// --------------------

typedef struct CHEVObject_ CHEVObject;
typedef struct CHEVObjectType_ CHEVObjectType;

typedef struct SeaMapObject_ SeaMapObject;

typedef SeaMapObject *(*SeaMapObjCreateFunc)(const CHEVObjectType *objectType, CHEVObject *mapObject);
typedef BOOL (*SeaMapObjViewCheck)(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag);

typedef struct SeaMapIslandDrawIcon_ SeaMapIslandDrawIcon;
typedef struct SeaMapBoatIcon_ SeaMapBoatIcon;

// --------------------
// ENUMS
// --------------------

enum SeaMapObjectIDs
{
    SEAMAPOBJECT_ISLAND_DRAW_ICON,
    SEAMAPOBJECT_UNUSED,
    SEAMAPOBJECT_ISLAND_ICON_1,
    SEAMAPOBJECT_ISLAND_ICON_2,
    SEAMAPOBJECT_JOHNNY_ICON,
    SEAMAPOBJECT_UNKNOWN,
    SEAMAPOBJECT_CORAL_CAVE_ICON,
    SEAMAPOBJECT_SKY_BABYLON_ICON,
    SEAMAPOBJECT_TARGET_FLAG_ICON,
    SEAMAPOBJECT_BOAT_ICON,
    SEAMAPOBJECT_STYLUS_PROMPT,
    SEAMAPOBJECT_DS_POPUP,
    SEAMAPOBJECT_SPARKLES_1,
    SEAMAPOBJECT_SPARKLES_2,

    SEAMAPOBJECT_COUNT,
};

// --------------------
// STRUCTS
// --------------------

struct CHEVObject_
{
    u16 type;
    Vec2Fx16 position;
    u8 flags1;
    u8 flags2;
    HitboxRect box;
    s16 unlockID;
};

struct CHEVObjectType_
{
    u16 animID;
    u16 palette;
    u8 viewBounds[2];
    SeaMapObjCreateFunc createFunc;
    SeaMapObjViewCheck viewCheckFunc;
};

struct SeaMapObject_
{
    Task *task;
    const CHEVObjectType *objectType;
    CHEVObject *mapObject;
    Vec2Fx16 position;
};

typedef struct CHEV_
{
    u16 count;
    CHEVObject entries[1];
} CHEV;

typedef struct SeaMapVoyageVisibleIsland_
{
    CHEVObject *object;
    u32 radius;
} SeaMapVoyageVisibleIsland;

typedef struct SeaMapEventManager_
{
    s32 lastTouchedIconType;
    SeaMapIslandDrawIcon *lastTouchedIcon;
    CHEVObject objectList[16];
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

extern const CHEVObjectType gSeaMapObjectTypeList[SEAMAPOBJECT_COUNT];

// --------------------
// FUNCTIONS
// --------------------

BOOL SeaMapEventManager__CheckFeatureUnlocked(u32 id);
void SeaMapEventManager__Create(void);
void SeaMapEventManager__Destroy(void);
SeaMapObject *SeaMapEventManager__CreateObject(s32 type, s16 x, s16 y, u8 flags, HitboxRect *box, s16 unlockID);
SeaMapEventManager *SeaMapEventManager__GetWork2(void);
void SeaMapEventManager__Func_2046A78(void);
void SeaMapEventManager__Func_2046A94(void *a1);
CHEVObject *SeaMapEventManager__GetObjectFromID(u32 id);
void SeaMapEventManager__FindVisibleIslands(fx32 shipX, fx32 shipY, fx32 distanceThreshold, SeaMapVoyageVisibleIsland *islandList, u16 *islandCount);
u32 SeaMapEventManager__GetObjectType(CHEVObject *mapObject);
BOOL SeaMapEventManager__ObjectIsActive(CHEVObject *mapObject);
u32 SeaMapEventManager__Func_2046CE8(s16 id);
u32 SeaMapEventManager__Func_2046EEC(u32 id);
void SeaMapEventManager__SetBoatFlipX(SeaMapBoatIcon *boat, BOOL enabled);
SeaMapObject *SeaMapEventManager__CreateStylusIcon(fx32 startX, fx32 startY, fx32 endX, fx32 endY, s16 speed);
void SeaMapEventManager__DestroyStylusIcon(SeaMapObject *work);
void SeaMapEventManager__CreateDSPopup(void);
void SeaMapEventManager__DestroyDSPopup(void);
void SeaMapEventManager__UnlockCoralCave(void);
void SeaMapEventManager__UnlockSkyBabylon(void);
void SeaMapEventManager__Func_20471B8(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData);
BOOL SeaMapEventManager__IslandEnabled(u32 id);
SeaMapEventManager *SeaMapEventManager__GetWork(void);
void SeaMapEventManager_SpawnInitialObjects(void);
void SeaMapEventManager_Main(void);
void SeaMapEventManager_Destructor(Task *task);
void SeaMapEventManager__InitMapObject(SeaMapObject *work, Task *task, const CHEVObjectType *objectType, CHEVObject *mapObject);
void SeaMapEventManager__DestroyObject(SeaMapObject *work);
BOOL SeaMapEventManager__ObjectInBounds(Vec2Fx16 *objPos, const s8 *viewBounds);
void SeaMapEventManager__Func_20474FC(Vec2Fx16 *a1, Vec2Fx16 *a2);
void SeaMapEventManager__SetObjectAsActive(SeaMapObject *work);
void SeaMapEventManager__SetObjectAsInactive(SeaMapObject *work);
BOOL SeaMapEventManager__Func_204756C(CHEVObject *mapObject);
void SeaMapEventManager__GetViewRect2(HitboxRect *rect, fx32 x, fx32 y, s32 *startX, s32 *startY, s32 *width, s32 *height);
void SeaMapEventManager__GetViewRect(HitboxRect *rect, fx32 x, fx32 y, ViewRect *viewRect);
BOOL SeaMapEventManager__PointInViewRect2(s32 startX, s32 startY, s32 width, s32 height, fx32 x, fx32 y);
BOOL SeaMapEventManager__PointInViewRect(s32 left, s32 top, s32 right, s32 bottom, fx32 x, fx32 y);
BOOL SeaMapEventManager__ViewRectCheck(CHEVObject *mapObject, fx32 x, fx32 y);
BOOL SeaMapEventManager__ViewRectCheck2(CHEVObject *mapObject, fx32 x, fx32 y);

#endif // RUSH_SEAMAPEVENTMANAGER_H