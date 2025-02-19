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
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapUnknown__Create(void);
NOT_DECOMPILED void SeaMapUnknown__Main(void);
NOT_DECOMPILED void SeaMapUnknown__Destructor(Task *task);
NOT_DECOMPILED void SeaMapUnknown__Destroy(SeaMapUnknown *work);
NOT_DECOMPILED void SeaMapUnknown__RunState(SeaMapUnknown *work);
NOT_DECOMPILED void SeaMapUnknown__InitDisplay(void);
NOT_DECOMPILED void SeaMapUnknown__State_216FE9C(SeaMapUnknown *work);
NOT_DECOMPILED void SeaMapUnknown__State_216FEAC(SeaMapUnknown *work);
NOT_DECOMPILED void SeaMapUnknown__State_216FF10(SeaMapUnknown *work);
NOT_DECOMPILED void SeaMapUnknown__State_216FF40(SeaMapUnknown *work);

#endif // RUSH_SEAMAPUNKNOWN_H