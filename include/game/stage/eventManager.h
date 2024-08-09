#ifndef RUSH2_EVENT_MANAGER_H
#define RUSH2_EVENT_MANAGER_H

#include <global.h>
#include <game/stage/mapSys.h>
#include <stage/gameObject.h>

// --------------------
// TYPES
// --------------------

typedef GameObjectTask *(*CreateObjectFunc)(MapObject *mapObject, fx32 x, fx32 y, s32 param);
typedef void (*CreateRingFunc)(MapRing *mapRing, fx32 x, fx32 y, s32 param);
typedef struct StageDecoration_ *(*CreateDecorationFunc)(MapDecor *mapDecor, fx32 x, fx32 y, s32 param);

// --------------------
// ENUMS
// --------------------

enum FileList_ArchiveEve
{
    ARC_EVE_FILE_DECOR,
    ARC_EVE_FILE_EVENTS,
    ARC_EVE_FILE_RINGS,
    ARC_EVE_FILE_DRAWSTATE,
};

// --------------------
// STRUCTS
// --------------------

typedef struct EventManager_
{
    void (*state)(struct EventManager_ *work);
    s32 field_4;
    s32 field_8;
    Vec2Fx32 prevPos[2];
} EventManager;

typedef struct EventManagerStaticVars_
{
    u16 field_0;
    u16 viewOffset;
    u16 field_4;
    u16 field_6;
    void (*objectSpawnFunc2)(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
    void (*objectSpawnFunc4)(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
    void (*objectSpawnFunc)(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
    void (*objectSpawnFunc3)(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
    Task *task;
    void *archive;
    void *objectLayout;
    void *ringLayout;
    void *decorLayout;
} EventManagerStaticVars;

// --------------------
// VARIABLES
// --------------------

extern const CreateDecorationFunc stageDecorationSpawnList[MAPDECOR_COUNT];
extern const CreateObjectFunc stageObjectSpawnList[MAPOBJECT_COUNT];

extern u8 GameDecoration__ViewOffsetTable[];
extern u8 GameObject__ViewOffsetTable[];

// --------------------
// FUNCTIONS
// --------------------

void EventManager__Init(void);
void EventManager__Create(void);
void EventManager__Release(void);
void EventManager__LoadObjectLayout(void);
void EventManager__ReleaseObjectLayout(void);
void EventManager__CreateEventEnforce(void);
void EventManager__CreateEventsUnknown(u16 left, u16 top, u16 right, u16 bottom);
void *EventManager__GetObjectLayout(void);

void EventManager__Destructor(Task *task);
void EventManager__Main(void);

void EventManager__State_Init(EventManager *work);
void EventManager__State_SingleScr(EventManager *work);
void EventManager__State_MultiScr(EventManager *work);
void EventManager__State_Boss(EventManager *work);

void EventManager__CreateAllEvents(EventManager *work);
void EventManager__CreateEventsInRect(EventManager *work, s32 id, s32 flags);
void EventManager__CreateEventLCD(EventManager *work, s32 id, s32 flags);
void EventManager__CreateStageObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
void EventManager__CreateRingObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);
void EventManager__CreateDecorObjects(EventManager *evtMgr, s32 blockX, s32 blockY, ViewRect *r_on, ViewRect *r_off, u8 flags);

#endif // RUSH2_EVENT_MANAGER_H
