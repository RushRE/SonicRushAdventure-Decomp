#ifndef RUSH_EXBOSSLINEMISSILE_H
#define RUSH_EXBOSSLINEMISSILE_H

#include <ex/boss/exBoss.h>
#include <ex/system/exUtils.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossLineMissileTask_
{
    u16 id;
    VecFx32 velocity;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    u16 spinSpeed;
    BOOL spinClockwise;
    exBossSysAdminTask *parent;
    EX_ACTION_NN_WORK animator;
    ExUtilMissileMover missileMover;
    VecFx32 positions[EXBOSS_LINE_MISSILE_COUNT];
} exBossLineMissileTask;

typedef struct exBossLineNeedleTask_
{
    u16 id;
    VecFx32 velocity;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    u16 unknown;
    exBossSysAdminTask *parent;
    EX_ACTION_NN_WORK animator;
    ExUtilMissileMover missileMover;
    VecFx32 positions[EXBOSS_LINE_MISSILE_COUNT];
} exBossLineNeedleTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossSpikedLineMissile(void);
BOOL CreateExBossBluntLineMissile(void);

#endif // RUSH_EXBOSSLINEMISSILE_H
