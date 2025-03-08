#ifndef RUSH_SEAMAPEVENTTRIGGER_H
#define RUSH_SEAMAPEVENTTRIGGER_H

#include <seaMap/seaMapEventManager.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapEventTriggerType_
{
    SEAMAPEVENTTRIGGER_TYPE_0,
    SEAMAPEVENTTRIGGER_TYPE_1,
    SEAMAPEVENTTRIGGER_TYPE_2,
    SEAMAPEVENTTRIGGER_TYPE_3,
    SEAMAPEVENTTRIGGER_TYPE_4,
    SEAMAPEVENTTRIGGER_TYPE_5,
    SEAMAPEVENTTRIGGER_TYPE_6,
    SEAMAPEVENTTRIGGER_TYPE_7,
    SEAMAPEVENTTRIGGER_TYPE_8,
    SEAMAPEVENTTRIGGER_TYPE_9,
};
typedef u32 SeaMapEventTriggerType;

// --------------------
// TYPES
// --------------------

typedef BOOL (*SeaMapEventTriggerCallback)(SeaMapEventTriggerType type, void *work, void *eventData, s32 unknown);

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
void SeaMapEventTrigger_DoEvent(SeaMapEventTriggerType type, void *eventData, s32 unknown);

#endif // RUSH_SEAMAPEVENTTRIGGER_H