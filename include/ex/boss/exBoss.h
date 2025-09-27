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

#define EXBOSS_LINE_MISSILE_COUNT 6
#define EXBOSS_HOMING_LASER_COUNT 6
#define EXBOSS_FIRE_DRAGON_COUNT  3

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

enum ExBossHurtVoiceClip_
{
    EXBOSS_HURT_VOICECLIP_YOU, // "You...!"
    EXBOSS_HURT_VOICECLIP_OW,  // "Ow!"
};
typedef s32 ExBossHurtVoiceClip;

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
        u8 flashTimer : 1;
    } moveFlags;
    struct
    {
        u8 unused : 7;
        u8 isAttackReady : 1;
    } flags;
    struct
    {
        u8 doHurt : 1;
        u8 isHurt : 1;
        u8 doMeteor : 1;
        u8 doFireball : 1;
        u8 doHomingLaser : 1;
        u8 doDragon : 1;
        u8 doMagmaWave : 1;
        u8 doLineMissile : 1;
    } attackFlags;
    ExBossHurtVoiceClip nextHurtVoiceClip;
    s32 unused;
    BOOL isMagmaEruptionOscillatingLeft;
    BOOL isMagmaEruptionMovingLeft;
    VecFx32 magmaEruptionTargetPosL;
    VecFx32 magmaEruptionTargetPosR;
    VecFx32 magmaEruptionUnknownPos;
    VecFx32 fleeVelocity;
    s16 projectileRepeatCount;
    VecFx32 targetPos;
    s16 hitVoiceClipCooldown;
    s16 genericAttackTimer;
    s16 genericCooldown;
    s16 hitEffectCooldown;
    s16 hurtInvulnDuration;
    s16 idleDuration;
    s16 moveDuration;
    s16 health;
    s16 maxHealth;
    u16 projectileID;
    struct exBossMeteAdminTask_ *currentMeteor;
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
void SetExBossFightStarted(BOOL hasStarted);
BOOL CreateExBoss(void);
Task *GetExBossTask(void);
void DestroyExBoss(void);

// ExBoss Helpers
void HandleExBossMovement(void);

// ExBoss - Intermission
void LoadExBossAssets(EX_ACTION_NN_WORK *work);
void SetExBossAnimation(EX_ACTION_NN_WORK *work, ExBossAnimIDs animID);
void ReleaseExBossAssets(EX_ACTION_NN_WORK *work);
EX_ACTION_NN_WORK *GetExBossAssets(void);
void ExBoss_BossRenderCallback(NNSG3dRS *rs);
void ExBoss_Action_StartHurt(void);
void ExBoss_Action_StartPhase1Defeat(void);
void ExBoss_Action_StartPhase2Defeat(void);
void ExBoss_Action_StartPhase3Defeat(void);
BOOL ExBoss_IsBossFleeing(void);
void ExBoss_SetBossFleeing(BOOL isFleeing);

// ExBoss - Fire Dragon Attack
void ExBoss_Action_StartFireDragonAttack(void);

// ExBoss - Fireball Attack
void ExBoss_Action_StartFireballAttack(void);

// ExBoss - Homing Laser Attack
void ExBoss_Action_StartHomingLaserAttack(void);

// ExBoss - Line Missile Attack
void ExBoss_Action_StartLineMissileAttack(void);

// ExBoss - Meteor Attack
void ExBoss_RunTaskUnknownEvent(void);
void ExBoss_Action_StartMeteorAttack(void);

// ExBoss - Magma Eruption Attack
void ExBoss_Action_StartMagmaEruptionAttack(void);

#endif // RUSH_EXBOSS_H
