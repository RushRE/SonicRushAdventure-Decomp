#ifndef RUSH_EXBOSSFIREBLUE_H
#define RUSH_EXBOSSFIREBLUE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>
#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossFireBlueTask_
{
  s32 field_0;
  VecFx32 velocity;
  VecFx32 targetPos;
  s32 field_1C;
  u16 spinSpeed;
  s32 spinDirection;
  exBossSysAdminTask *parent;
  EX_ACTION_NN_WORK animator;
} exBossFireBlueTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossFireBlue(void);

#endif // RUSH_EXBOSSFIREBLUE_H
