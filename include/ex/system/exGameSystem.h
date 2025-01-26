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
    u16 field_0;
    u16 field_2;
    u16 timer;
    u16 field_6;
    s32 field_8;
    exSysTaskStatus *status;
} exGameSystemTask;

// --------------------
// FUNCTIONS
// --------------------

// ExGameSystem
void CreateExGameSystem(void);
void DestroyExGameSystem(void);

#endif // RUSH_EXGAMESYSTEM_H
