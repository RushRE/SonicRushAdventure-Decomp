#ifndef RUSH_EXHITCHECK_H
#define RUSH_EXHITCHECK_H

#include <ex/system/exTask.h>

// --------------------
// ENUMS
// --------------------

enum exHitCheckType_
{
    EXHITCHECK_TYPE_NOT_SOLID,
    EXHITCHECK_TYPE_HAZARD,
    EXHITCHECK_TYPE_ACTIVE_PLAYER,
    EXHITCHECK_TYPE_INACTIVE_PLAYER,
    EXHITCHECK_TYPE_RING,
    EXHITCHECK_TYPE_INTRO_METEOR,
};
typedef u8 exHitCheckType;

// --------------------
// STRUCTS
// --------------------

typedef struct exHitCheckTaskUnknown_
{
    VecFx32 size;
    VecFx32 *position;
} exHitCheckTaskUnknown;

typedef struct exHitCheck_
{
    exHitCheckType type;
    struct
    {
        u8 isBoss : 1;
        u8 isBossFireEffect : 1;
        u8 isBossShotEffect : 1;
        u8 isBossHomingEffect : 1;
        u8 isBossFireballShotEffect : 1;
        u8 isBossFireballEffect : 1;
        u8 isBossMeteorEffect : 1;
        u8 isBossMeteor : 1;
        u8 isBossMeteorBomb : 1;
        u8 isBossFireRed : 1;
        u8 isBossFireBlue : 1;
        u8 isBossMagmaWave : 1;
        u8 isBossMagmaWaveAttack : 1;
        u8 isBossDragon : 1;
        u8 isBossDragonExplosion : 1;
        u8 isBluntLineMissile : 1;
        u8 isSpikedLineMissile : 1;
        u8 isBossHomingLaserTrail : 1;
        u8 isHomingLaserSprite : 1;
        u8 isSuperSonicPlayer : 1;
        u8 isSonicPlayer : 1;
        u8 isBurningBlazePlayer : 1;
        u8 isBlazePlayer : 1;
        u8 isSonicBarrierEffect : 1;
        u8 isUnknown : 1;
        u8 isRepelledProjectile : 1;
        u8 isBlazeFireballEffect : 1;
        u8 isRing : 1;
        u8 isIntroMeteor : 1;
        u8 isBrokenIntroMeteor : 1;
        u8 isBossHitEffect : 1;
        u8 isStageGeometry : 1;
        u8 isSpriteOrModelVFX : 1;
        u8 isTrailVFX : 1;
        u8 isPlayerSprite : 1;
    } input;
    struct
    {
        u8 hasCollision : 1;
        u8 isHurt : 1;
        u8 isStunned : 1;
        u8 isInvincible : 1;
        u8 willExplodeOnContact : 1;
        u8 unused : 1;
        u8 wasOutOfBounds : 1;
        u8 touchingBoundaryT : 1;
        
        u8 touchingBoundaryB : 1;
        u8 touchingBoundaryL : 1;
        u8 touchingBoundaryR : 1;
        u8 touchedRing : 1;
    } output;
    s16 power;
    s16 health;
    exHitCheckTaskUnknown box;
} exHitCheck;


typedef struct exHitCheckTask_
{
    u8 unknown;
} exHitCheckTask;


// --------------------
// FUNCTIONS
// --------------------

void exHitCheckTask_SetPauseLevel(s32 pauseLevel);
BOOL exHitCheckTask_IsPaused(void);
void exHitCheckTask_DecPauseLevel(void);
void exHitCheckTask_InitHitChecker(exHitCheck *work);
BOOL exHitCheckTask_AddHitCheck(exHitCheck *work);
void exHitCheckTask_DoArenaBoundsCheck(void *work, u16 type);
void exHitCheckTask_Create(void);

#endif // RUSH_EXHITCHECK_H
