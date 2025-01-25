#ifndef RUSH_EXTIMEGAMEPLAY_H
#define RUSH_EXTIMEGAMEPLAY_H

#include <ex/exTask.h>
#include <ex/exSysTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exTimeGamePlayTask_
{
  u64 frameCounter;
  ExSysTaskTime *time;
} exTimeGamePlayTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExTimeGameplay(void);
void DestroyExTimeGameplay(void);
BOOL CheckExTimeGameplayIsTimeOver(void);
void ResetExTimeGameplayTimeOverFlag(void);

#endif // RUSH_EXTIMEGAMEPLAY_H