#ifndef RUSH_EXTIMEGAMEPLAY_H
#define RUSH_EXTIMEGAMEPLAY_H

#include <ex/system/exTask.h>
#include <ex/system/exSystem.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exTimeGamePlayTask_
{
  u64 frameCounter;
  exSysTaskTime *time;
} exTimeGamePlayTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExTimeGameplay(void);
void DestroyExTimeGameplay(void);
BOOL CheckExTimeGameplayIsTimeOver(void);
void ResetExTimeGameplayTimeOverFlag(void);

#endif // RUSH_EXTIMEGAMEPLAY_H