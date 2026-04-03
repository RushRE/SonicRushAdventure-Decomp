#ifndef RUSH_SEAMAPEVENTTRIGGER_H
#define RUSH_SEAMAPEVENTTRIGGER_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapEventTriggerType_
{
    SEAMAPEVENTTRIGGER_EVENT_NONE,
    SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_CHART_MAP,
    SEAMAPEVENTTRIGGER_EVENT_ISLAND_ON_SAIL_MAP,
    SEAMAPEVENTTRIGGER_EVENT_SAILING_UNKNOWN, // Never called
    SEAMAPEVENTTRIGGER_EVENT_REACHED_END,
    SEAMAPEVENTTRIGGER_EVENT_RIVAL_ENCOUNTER,
    SEAMAPEVENTTRIGGER_EVENT_UNKNOWN_ENCOUNTER, // Never listened for
    SEAMAPEVENTTRIGGER_EVENT_ISLAND_DISCOVERY,
    SEAMAPEVENTTRIGGER_EVENT_SHUTDOWN,

    SEAMAPEVENTTRIGGER_EVENT_COUNT,
};
typedef u32 SeaMapEventTriggerType;

// --------------------
// TYPES
// --------------------

typedef void (*SeaMapEventTriggerCallback)(SeaMapEventTriggerType type, void *work, void *eventData, void *param);

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapEventListener_
{
    NNSFndLink link;
    SeaMapEventTriggerCallback callback;
    void *work;
} SeaMapEventListener;

// --------------------
// FUNCTIONS
// --------------------

void InitSeaMapEventTriggerSystem(void);
void ReleaseSeaMapEventTriggerSystem(void);
SeaMapEventListener *SeaMapEventTrigger_AddEventListener(SeaMapEventTriggerCallback callback, void *work);
void SeaMapEventTrigger_RemoveEventListener(SeaMapEventListener *work);
void SeaMapEventTrigger_DoEvent(SeaMapEventTriggerType type, void *eventData, void *param);

#endif // RUSH_SEAMAPEVENTTRIGGER_H