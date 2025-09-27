#ifndef RUSH_EXBOSSHOMINGLASER_H
#define RUSH_EXBOSSHOMINGLASER_H

#include <ex/boss/exBoss.h>
#include <ex/system/exUtils.h>

typedef struct exBossHomingLaserTask_
{
    u16 id;
    s16 timer;
    s16 trailUpdateTimer;
    VecFx32 velocity;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    VecU16 angle;
    s16 angleUnknown;
    float moveSpeed;
    VecFx32 position;
    s16 field_38;
    u16 startAngle;
    s32 field_3C;
    exBossSysAdminTask *parent;
    EX_ACTION_BAC3D_WORK aniSprite3D;
    EX_ACTION_TRAIL_WORK aniTrail;
} exBossHomingLaserTask;

// --------------------
// FUNCTIONS
// --------------------

s32 GetActiveExBossHomingLaserCount(void);
BOOL CreateExBossHomingLaser(void);

#endif // RUSH_EXBOSSHOMINGLASER_H
