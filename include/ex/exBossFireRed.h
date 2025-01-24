#ifndef RUSH_EXBOSSFIRERED_H
#define RUSH_EXBOSSFIRERED_H

#include <ex/exTask.h>
#include <ex/exDrawReq.h>
#include <ex/exBoss.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct exBossFireRedTask_
{
  s32 field_0;
  VecFx32 field_4;
  VecFx32 field_10;
  s32 field_1C;
  s16 field_20;
  s16 field_22;
  s32 field_24;
  exBossSysAdminTask *parent;
  EX_ACTION_NN_WORK animator;
} exBossFireRedTask;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

void exBossFireRedTask__LoadAssets(EX_ACTION_NN_WORK *work);
void exBossFireRedTask__ReleaseAssets(EX_ACTION_NN_WORK *work);
void exBossFireRedTask__Main(void);
void exBossFireRedTask__Func8(void);
void exBossFireRedTask__Destructor(void);
void exBossFireRedTask__Main_2159140(void);
void ovl09_215938C(void);
void exBossFireRedTask__Func_21593AC(void);
void exBossFireRedTask__Func_21594B0(void);
void exBossFireRedTask__Main_215965C(void);
s32 exBossFireRedTask__Create(void);

#endif // RUSH_EXBOSSFIRERED_H
