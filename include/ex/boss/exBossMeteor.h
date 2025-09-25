#ifndef RUSH_EXBOSSMETEOR_H
#define RUSH_EXBOSSMETEOR_H

#include <ex/boss/exBoss.h>
#include <ex/player/exPlayerHelpers.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossMeteBombTask_
{
    u16 timer;
    VecFx32 targetPos;
    VecFx32 modelScaleSpeed;
    VecFx32 hitboxScaleSpeed;
    u16 field_28;
    u16 unknownTimer1;
    s32 field_2C;
    u16 unknownTimer2;
    u16 field_32;
    EX_ACTION_NN_WORK animator;
} exBossMeteBombTask;

typedef struct exBossMeteLockOnTask_
{
    s16 timer;
    BOOL exploded;
    s16 targetScale;
    s32 unused;
    EX_ACTION_NN_WORK animator;
    exBossSysAdminTask *parent;
} exBossMeteLockOnTask;

typedef struct exBossMeteMeteoTask
{
    s16 timer;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    VecFx32 velocity;
    s32 field_24;
    VecU16 field_28;
    VecU16 field_2E;
    VecU16 angle;
    BOOL exploded;
    VecFx32 startPosition;
    VecFx32 targetPosition;
    s32 field_58;
    s32 field_5C;
    s32 field_60;
    s32 field_64;
    s32 field_68;
    s32 field_6C;
    s32 field_70;
    s32 field_74;
    s32 field_78;
    s32 field_7C;
    s32 field_80;
    s32 field_84;
    EX_ACTION_NN_WORK animator;
    exBossSysAdminTask *parent;
    ExPlayerUnknown2152FB0 int568;
    s32 field_588;
} exBossMeteMeteoTask;

typedef struct exBossMeteAdminTask_
{
    exBossMeteMeteoTask *meteor;
    exBossMeteLockOnTask *lockOn;
    void *unknown;
} exBossMeteAdminTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossMeteorBomb(VecFx32 *targetPos);
BOOL CreateExBossMeteorLockOn(void);
BOOL CreateExBossMeteor(void);
BOOL CreateExBossMeteorAdmin(void);

#endif // RUSH_EXBOSSMETEOR_H