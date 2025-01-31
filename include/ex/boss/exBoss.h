#ifndef RUSH_EXBOSS_H
#define RUSH_EXBOSS_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// MACROS/CONSTANTS
// --------------------

#define EXBOSS_HEALTH_NONE     (0)
#define EXBOSS_HEALTH_CRITICAL (8)
#define EXBOSS_HEALTH_MAX      (176)

// --------------------
// ENUMS
// --------------------

enum ExBossAnimIDs_
{
    bse_body_fw0,
    bse_body_mete0,
    bse_body_mete1,
    bse_body_mete2,
    bse_body_fire0,
    bse_body_fire1,
    bse_body_fire2,
    bse_body_fire3,
    bse_body_fire4,
    bse_body_homi0,
    bse_body_homi1,
    bse_body_homi2,
    bse_body_dora0,
    bse_body_dora1,
    bse_body_dora2,
    bse_body_wave0,
    bse_body_wave1,
    bse_body_wave2,
    bse_body_wave3,
    bse_body_wave4,
    bse_body_line0,
    bse_body_line1,
    bse_body_line2,
    bse_body_dmg0,
    bse_body_dmg1,
    bse_body_bdmg0,
    bse_body_bdmg1,
};
typedef u16 ExBossAnimIDs;

// --------------------
// STRUCTS
// --------------------

typedef struct exBossSysAdminTask_
{
    struct
    {
        u8 up : 1;
        u8 down : 1;
        u8 left : 1;
        u8 right : 1;
    } moveFlags;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 isAttackReady : 1;
    } flags;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 doMeteor : 1;
        u8 doFireball : 1;
        u8 doHomingLaser : 1;
        u8 doDragon : 1;
        u8 doMagmaWave : 1;
        u8 doLineMissile : 1;
    } attackFlags;
    s32 nextHurtVoiceClip;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    VecFx32 fleeVelocity;
    s16 fireballShootTimer;
    s16 field_46;
    VecFx32 targetPos;
    s16 hitVoiceClipCooldown;
    s16 field_56;
    u16 flashEffectCooldown;
    s16 hitEffectCooldown;
    s16 hurtInvulnDuration;
    s16 idleDuration;
    s16 moveDuration;
    s16 health;
    s16 maxHealth;
    s32 field_68;
    EX_ACTION_NN_WORK aniBoss;
    void (*nextAttackState)(void);
    ExTaskMain stateAttack;
} exBossSysAdminTask;

// needed for ExTaskCreate
typedef exBossSysAdminTask exBossSysAdminBiforTask;

// --------------------
// FUNCTIONS
// --------------------

// ExBoss
exBossSysAdminTask *GetExBossWork(void);
BOOL GetExBossFightStarted(void);
void SetExBossFightStarted(BOOL value);
BOOL CreateExBoss(void);
Task *GetExBossTask(void);
void DestroyExBoss(void);

// ExBoss Helpers
void HandleExBossMovement(void);

#endif // RUSH_EXBOSS_H
