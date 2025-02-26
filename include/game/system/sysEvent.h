#ifndef RUSH_SYSEVENT_H
#define RUSH_SYSEVENT_H

#include <global.h>
#include <game/system/task.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define OVERLAY_NONE -1

// --------------------
// ENUMS
// --------------------

enum EventID_
{
    SYSEVENT_INVALID = -1,

    SYSEVENT_NONE = 0,
#ifdef RUSH_CONTEST
    SYSEVENT_LOAD_STAGE,
    SYSEVENT_ZONEACT,
    SYSEVENT_BOSS1,
    SYSEVENT_BOSS2,
    SYSEVENT_VSBATTLE,
    SYSEVENT_TITLECARD,
    SYSEVENT_STAGE_ACTIVE,
    SYSEVENT_VS_STAGE_CLEAR,
    SYSEVENT_VS_LOBBY_MENU,
    SYSEVENT_NETWORK_ERROR_MENU,
    SYSEVENT_VS_UNKNOWN,
    SYSEVENT_DOWNLOADPLAY_END_SCREEN,
#else
    SYSEVENT_SPLASH_SCREEN,
    SYSEVENT_OPENING,
    SYSEVENT_TITLE,
    SYSEVENT_DEMO,
    SYSEVENT_ZONE_DEMO,
    SYSEVENT_CREDITS,
    SYSEVENT_7,
    SYSEVENT_LOAD_STAGE,
    SYSEVENT_ZONEACT,
    SYSEVENT_BOSS1,
    SYSEVENT_BOSS2,
    SYSEVENT_VSBATTLE,
    SYSEVENT_TITLECARD,
    SYSEVENT_STAGE_ACTIVE,
    SYSEVENT_STAGE_CLEAR,
    SYSEVENT_VS_STAGE_CLEAR,
    SYSEVENT_EXBOSS,
    SYSEVENT_STAGE_CLEAR_EX,
    SYSEVENT_19,
    SYSEVENT_20,
    SYSEVENT_21,
    SYSEVENT_22,
    SYSEVENT_VS_MENU,
    SYSEVENT_24,
    SYSEVENT_VS_LOBBY_MENU,
    SYSEVENT_NETWORK_ERROR_MENU,
    SYSEVENT_SAILING,
    SYSEVENT_RETURN_TO_HUB,
    SYSEVENT_MAIN_MENU,
    SYSEVENT_PLAYER_NAME_MENU,
    SYSEVENT_EMERALD_COLLECTED,
    SYSEVENT_CORRUPT_SAVE_WARNING,
    SYSEVENT_NETCONFIG,
    SYSEVENT_CUTSCENE,
    SYSEVENT_SEAMAP_UNKNOWN,
    SYSEVENT_CHANGE_CHARTED_COURSE,
    SYSEVENT_SEAMAP_TRAINING,
    SYSEVENT_SEAMAPCUTSCENE,
    SYSEVENT_DELETE_SAVE_MENU,
    SYSEVENT_UPDATE_PROGRESS,
    SYSEVENT_SOUND_TEST,
    SYSEVENT_DOOR_PUZZLE,
    SYSEVENT_VIKING_CUP,
    SYSEVENT_SAVE_INIT,
    SYSEVENT_AUTOSAVE,
#endif

    SYSEVENT_COUNT,
};
typedef s16 EventID;

enum SysEventStatus_
{
    SYSEVENT_STATUS_IDLE,
    SYSEVENT_STATUS_CHANGE_REQUESTED,
    SYSEVENT_STATUS_CHANGE_FINISHED,
};
typedef u32 SysEventStatus;

// --------------------
// STRUCTS
// --------------------

struct SysEvent
{
    void (*initFunc)(void);
    void (*exitFunc)(void);
    void (*resetFunc)(void);
    void (*initSysFunc)(void);
    void (*exitSysFunc)(void);
    EventID nextEvents[8];
    u32 attribute;
    FSOverlayID overlay;
};

typedef struct SysEventList_
{
    const struct SysEvent *eventList;
    u32 eventListCount;
    const struct SysEvent *currentEventData;

    // Cleanest way to represent the "opaque" value used for the create function
    union
    {
        struct
        {
            EventID currentEventID;
            EventID prevEventID;
        };
        s32 eventID_Opaque;
    };

    const struct SysEvent *nextEventData;

    // Cleanest way to represent the "opaque" value used for the create function
    union
    {
        struct
        {
            EventID requestedEventID;
            s16 requestedEventCase;
        };
        s32 requestedEventID_Opaque;
    };

    SysEventStatus status;
} SysEventList;

// --------------------
// VARIABLES
// --------------------

extern const struct SysEvent sysEventList[SYSEVENT_COUNT];

// --------------------
// FUNCTIONS
// --------------------

void CreateSysEventEx(const struct SysEvent *eventList, u32 eventCount, u32 eventID, BOOL createTask, u16 priority, TaskGroup group);
SysEventList *GetSysEventList(void);
void RequestSysEventChange(s32 id);    // pick an event using current event's "next events" list
void RequestNewSysEventChange(s32 id); // pick a sys event manually
void NextSysEvent(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void CreateSysEvent(u32 eventID, BOOL createTask, u16 priority, TaskGroup group)
{
    CreateSysEventEx(sysEventList, ARRAY_COUNT(sysEventList), eventID, createTask, priority, group);
}

RUSH_INLINE EventID GetCurSysEvent(void)
{
    return GetSysEventList()->currentEventID;
}

RUSH_INLINE EventID GetReqSysEvent(void)
{
    return GetSysEventList()->requestedEventID;
}

#ifdef __cplusplus
}
#endif

#endif // RUSH_SYSEVENT_H