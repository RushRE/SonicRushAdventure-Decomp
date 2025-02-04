#ifndef RUSH_QUEUE_H
#define RUSH_QUEUE_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define QUEUE_MAX_ACTIVE_SIZE 256

// --------------------
// MACROS
// --------------------

#define QUEUE_ADDRESS_TO_LOCATION(address)  (size_t)(void *)(address)
#define QUEUE_LOCATION_TO_ADDRESS(location) (void *)(size_t)(location)

// --------------------
// STRUCTS
// --------------------

typedef union VRAMAddress_
{
    u32 location;
    void *address;
} VRAMAddress;

typedef struct QueueEntry_
{
    s32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
} QueueEntry;

// --------------------
// FUNCTIONS
// --------------------

void InitQueueSystem(void);
QueueEntry *AllocQueueEntry(void);
void FreeQueueEntry(QueueEntry *entry);

#ifdef __cplusplus
}
#endif

#endif // RUSH_QUEUE_H
