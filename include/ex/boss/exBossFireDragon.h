#ifndef RUSH_EXBOSSFIREDRAGON_H
#define RUSH_EXBOSSFIREDRAGON_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossFireDoraTask_
{
    u16 id;
    s16 explodeTimer;
    s16 trailUpdateTimer;
    s16 field_6;
    VecFx32 velocity;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    VecU16 angle;
    s16 angleUnknown;
    float moveSpeed;
    s16 field_2C;
    u16 spinSpeed;
    s32 field_30;
    BOOL spinClockwise;
    EX_ACTION_NN_WORK aniDragonModel;
    EX_ACTION_BAC3D_WORK aniExplosion;
    exBossSysAdminTask *parent;
    EX_ACTION_TRAIL_WORK aniTrail;
} exBossFireDoraTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL GetActiveExBossFireDragonCount(void);
BOOL CreateExBossFireDragon(void);

#endif // RUSH_EXBOSSFIREDRAGON_H