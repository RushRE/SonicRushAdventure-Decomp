#ifndef RUSH_STAGESTART_H
#define RUSH_STAGESTART_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct StageStart_
{
    u16 timer;
} StageStart;

// --------------------
// FUNCTIONS
// --------------------

void CreateStageStart(void);

#endif // RUSH_STAGESTART_H