#ifndef RUSH_EXBOSSFIREBLUE_H
#define RUSH_EXBOSSFIREBLUE_H

#include <ex/exTask.h>
#include <ex/exDrawReq.h>
#include <ex/exBoss.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct exBossFireBlueTask_
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
} exBossFireBlueTask;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

void exBossFireBlueTask__BossFunc_21581C0(void);
void exBossFireBlueTask__LoadAssets(EX_ACTION_NN_WORK *work);
void exBossFireBlueTask__Func_2158474(EX_ACTION_NN_WORK *work);
void exBossFireBlueTask__Main(void);
void exBossFireBlueTask__Func8(void);
void exBossFireBlueTask__Destructor(void);
void exBossFireBlueTask__Main_215862C(void);
void exBossFireBlueTask__Func_2158888(void);
void exBossFireBlueTask__Main_21588A8(void);
void exBossFireBlueTask__Func_21589B8(void);
void exBossFireBlueTask__Main_2158B64(void);
s32 exBossFireBlueTask__Create(void);

#endif // RUSH_EXBOSSFIREBLUE_H
