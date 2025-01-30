#ifndef RUSH_EXGAMESYSTEM_H
#define RUSH_EXGAMESYSTEM_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exGameSystemTask_
{
    u16 unknownCount;
    u16 unknownCounter;
    u16 timer;
    s32 unknown;
    exSysTaskStatus *status;
} exGameSystemTask;

// --------------------
// FUNCTIONS
// --------------------

// ExGameSystem
void CreateExGameSystem(void);
void DestroyExGameSystem(void);

#endif // RUSH_EXGAMESYSTEM_H
