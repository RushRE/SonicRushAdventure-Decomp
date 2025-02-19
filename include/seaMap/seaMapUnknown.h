#ifndef RUSH_SEAMAPUNKNOWN_H
#define RUSH_SEAMAPUNKNOWN_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapUnknown_
{
    void (*state)(struct SeaMapUnknown_ *work);
    BOOL destroyQueued;
    u32 field_8;
} SeaMapUnknown;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapUnknown(void);

#endif // RUSH_SEAMAPUNKNOWN_H