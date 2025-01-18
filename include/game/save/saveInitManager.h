#ifndef RUSH_SAVEINITMANAGER_H
#define RUSH_SAVEINITMANAGER_H

#include <game/save/saveManager.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SaveInitManager_
{
  s32 field_0;
  s32 saveFailed;
  s32 corruptFlags;
  s32 saveFlags;
  SaveGameCreateManager saveCreator;
  SaveGameLoadManager saveLoader;
  BOOL messageFinished;
  BOOL messageReady;
  s32 messageDisplayTimer;
  s32 eventChangeTimer;
  s32 field_1D4;
} SaveInitManager;

// --------------------
// FUNCTIONS
// --------------------

void CreateSaveInitManager(void);

#endif // RUSH_SAVEINITMANAGER_H
