#ifndef RUSH_EXBOSSFIRERED_H
#define RUSH_EXBOSSFIRERED_H

#include <ex/exTask.h>
#include <ex/exDrawReq.h>
#include <ex/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossFireRedTask_
{
  s32 field_0;
  VecFx32 velocity;
  VecFx32 targetPos;
  s32 field_1C;
  u16 spinSpeed;
  s32 spinDirection;
  exBossSysAdminTask *parent;
  EX_ACTION_NN_WORK animator;
} exBossFireRedTask;

// --------------------
// FUNCTIONS
// --------------------

// TRIVIA: despite being the "Red" variant, the model used is actually green!
// It seems likely that at some point the fireball _was_ red and was changed to green later on!
BOOL CreateExBossFireRed(void);

#endif // RUSH_EXBOSSFIRERED_H
