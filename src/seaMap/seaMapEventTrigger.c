#include <seaMap/seaMapEventTrigger.h>

// --------------------
// MACROS
// --------------------

#define SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE 32

// --------------------
// VARIABLES
// --------------------

static u32 sInitialized;

struct
{
    NNSFndList allocatedListeners;
    SeaMapEventListener listenerStorage[SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE];
    SeaMapEventListener *availableListeners[SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE];
} sListenerList;

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
    sInitialized = TRUE;
}

void ReleaseSeaMapEventTriggerSystem(void)
{
    SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_SHUTDOWN, NULL, NULL);
    InitSeaMapEventTriggerList();
}

SeaMapEventListener *SeaMapEventTrigger_AddEventListener(SeaMapEventTriggerCallback callback, void *work)
{
    s32 slot = (SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE - 1) - sListenerList.allocatedListeners.numObjects;

    SeaMapEventListener *listener = sListenerList.availableListeners[slot];
    sListenerList.availableListeners[slot]  = NULL;

    NNS_FndAppendListObject(&sListenerList.allocatedListeners, listener);

    listener->callback = callback;
    listener->work     = work;

    return listener;
}

void SeaMapEventTrigger_RemoveEventListener(SeaMapEventListener *listener)
{
    NNS_FndRemoveListObject(&sListenerList.allocatedListeners, listener);

    s32 slot                          = (SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE - 1) - sListenerList.allocatedListeners.numObjects;
    sListenerList.availableListeners[slot] = listener;

    MI_CpuClear16(listener, sizeof(*listener));
}

void SeaMapEventTrigger_DoEvent(SeaMapEventTriggerType type, void *eventData, void* param)
{
    NNSFndList *list = &sListenerList.allocatedListeners;

    SeaMapEventListener *listener = (SeaMapEventListener *)sListenerList.allocatedListeners.headObject;
    while (listener != NULL)
    {
        listener->callback(type, listener->work, eventData, param);

        listener = (SeaMapEventListener *)NNS_FndGetNextListObject(list, listener);
    }
}

void InitSeaMapEventTriggerList(void)
{
    NNS_FND_INIT_LIST(&sListenerList.allocatedListeners, SeaMapEventListener, link);

    for (s32 i = 0; i < SEAMAPEVENTTRIGGER_LISTENER_LIST_SIZE; i++)
    {
        sListenerList.availableListeners[i] = &sListenerList.listenerStorage[i];
    }

    MI_CpuClear16(sListenerList.listenerStorage, sizeof(sListenerList.listenerStorage));
}
