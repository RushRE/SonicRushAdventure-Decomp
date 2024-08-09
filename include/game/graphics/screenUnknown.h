#ifndef RUSH2_SCREENUNKNOWN_H
#define RUSH2_SCREENUNKNOWN_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct ScreenUnknownEvent_
{
    u16 animID;
    u8 duration;
    u8 flags;
} ScreenUnknownEvent;

typedef struct ScreenUnknown_
{
    void *spriteFile;
    u16 paletteRow;
    u16 eventID;
    u16 flags;
    u16 timer;
    ScreenUnknownEvent *events;
} ScreenUnknown;

// --------------------
// FUNCTIONS
// --------------------

void ReleaseScreenUnknown(u16 paletteRow);

#endif // RUSH2_SCREENUNKNOWN_H
