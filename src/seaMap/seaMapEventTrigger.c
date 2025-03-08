#include <seaMap/seaMapEventTrigger.h>

// --------------------
// MACROS
// --------------------

#define SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE 32

// --------------------
// VARIABLES
// --------------------

static u32 initialized;

struct
{
    NNSFndList allocatedListeners;
    SeaMapEventListener listenerStorage[SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE];
    SeaMapEventListener *availableListeners[SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE];
} listenerList;

// --------------------
// FUNCTION DECLS
// --------------------

static void InitSeaMapEventTriggerList(void);

// --------------------
// FUNCTIONS
// --------------------

void InitSeaMapEventTriggerSystem(void)
{
    InitSeaMapEventTriggerList();
    initialized = TRUE;
}

void ReleaseSeaMapEventTriggerSystem(void)
{
    SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_TYPE_8, NULL, 0);
    InitSeaMapEventTriggerList();
}

SeaMapEventListener *SeaMapEventTrigger_AddEventListener(SeaMapEventTriggerCallback callback, void *work)
{
    s32 slot = (SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE - 1) - listenerList.allocatedListeners.numObjects;

    SeaMapEventListener *listener = listenerList.availableListeners[slot];
    listenerList.availableListeners[slot]  = NULL;

    NNS_FndAppendListObject(&listenerList.allocatedListeners, listener);

    listener->callback = callback;
    listener->work     = work;

    return listener;
}

void SeaMapEventTrigger_RemoveEventListener(SeaMapEventListener *listener)
{
    NNS_FndRemoveListObject(&listenerList.allocatedListeners, listener);

    s32 slot                          = (SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE - 1) - listenerList.allocatedListeners.numObjects;
    listenerList.availableListeners[slot] = listener;

    MI_CpuClear16(listener, sizeof(*listener));
}

void SeaMapEventTrigger_DoEvent(SeaMapEventTriggerType type, void *eventData, s32 unknown)
{
    NNSFndList *list = &listenerList.allocatedListeners;

    SeaMapEventListener *listener = (SeaMapEventListener *)listenerList.allocatedListeners.headObject;
    while (listener != NULL)
    {
        listener->callback(type, listener->work, eventData, unknown);

        listener = (SeaMapEventListener *)NNS_FndGetNextListObject(list, listener);
    }
}

void InitSeaMapEventTriggerList(void)
{
    NNS_FND_INIT_LIST(&listenerList.allocatedListeners, SeaMapEventListener, link);

    for (s32 i = 0; i < SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE; i++)
    {
        listenerList.availableListeners[i] = &listenerList.listenerStorage[i];
    }

    MI_CpuClear16(listenerList.listenerStorage, sizeof(listenerList.listenerStorage));
}
