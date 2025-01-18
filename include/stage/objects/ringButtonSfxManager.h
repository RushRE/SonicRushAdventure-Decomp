#ifndef RUSH_RINGBUTTONSFXMANAGER_H
#define RUSH_RINGBUTTONSFXMANAGER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct RingButtonSfxManager_
{
  NNSSndHandle *sndHandle;
  s16 type;
  u16 changedTempo;
  u16 playerActive;
} RingButtonSfxManager;

// --------------------
// VARIABLES
// --------------------

extern s32 RingButtonSfxManager__timerTable[32];

// --------------------
// FUNCTIONS
// --------------------

void RingButtonSfxManager__Create(s16 type, BOOL allocSndHandle);

#endif // RUSH_RINGBUTTONSFXMANAGER_H