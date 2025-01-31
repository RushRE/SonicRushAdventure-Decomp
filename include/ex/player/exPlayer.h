#ifndef RUSH_EXPLAYER_H
#define RUSH_EXPLAYER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// MACROS/CONSTANTS
// --------------------

#define EXPLAYER_BARRIER_REGULAR_POWER_EASY   7
#define EXPLAYER_BARRIER_REGULAR_POWER_NORMAL 6

#define EXPLAYER_BARRIER_CHARGED_POWER_EASY   21
#define EXPLAYER_BARRIER_CHARGED_POWER_NORMAL 18

#define EXPLAYER_FIREBALL_WEAK_POWER_EASY   4
#define EXPLAYER_FIREBALL_WEAK_POWER_NORMAL 3

#define EXPLAYER_FIREBALL_REGULAR_POWER_EASY   7
#define EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL 6

#define EXPLAYER_FIREBALL_CHARGED_POWER_EASY   16
#define EXPLAYER_FIREBALL_CHARGED_POWER_NORMAL 15

// --------------------
// ENUMS
// --------------------

enum ExPlayerCharacter_
{
    EXPLAYER_CHARACTER_SONIC,
    EXPLAYER_CHARACTER_BLAZE,

    EXPLAYER_CHARACTER_COUNT,
};
typedef u8 ExPlayerCharacter;

enum ExPlayerSuperSonicAnimIDs
{
    ex_son_fw,
    ex_son_l,
    ex_son_r,
    ex_son_f,
    ex_son_dmg,
    ex_son_biri,
    ex_son_br_01,
    ex_son_br_02,
    ex_son_br_03,
    ex_son_br_04,
};

enum ExPlayerBurningBlazeAnimIDs
{
    ex_blz_fw,
    ex_blz_l,
    ex_blz_r,
    ex_blz_f,
    ex_blz_dmg,
    ex_blz_biri,
    ex_blz_fb_01,
    ex_blz_fb_02,
    ex_blz_fb_03,
    ex_blz_fb_04,
};

enum ExPlayerSonicAnimIDs
{
    ex_nson_die_01,
    ex_nson_die_02,
};

enum ExPlayerBlazeAnimIDs
{
    ex_nblz_die_01,
    ex_nblz_die_02,
};

// --------------------
// STRUCTS
// --------------------

struct exPlayerGraphics3D
{
    u16 unused;
    u16 nextAnim;
    EX_ACTION_NN_WORK manager;
};

typedef struct exPlayerAdminTaskWorker_
{
    u32 unused1;
    VecFx32 *position;
    VecFx32 velocity;
    VecFx32 acceleration;
    s16 dashTimer;
    u32 unused2[4];
    fx32 hurtFallSpeed;
    fx32 hurtUnknown;
    s16 shockStunDuration;
    s16 hurtInvulnDuration;
    s16 swapCooldown;
    s16 deathTimer;
    s16 barrierChargeTimer;
    s16 fireballChargeTimer;
    VecFx32 bossChaseMove;
    VecFx32 bossChaseTargetPos;
    s16 bossChaseTimer;
    VecU16 bossChaseRotation;
    u16 bossChaseRotationUnknown;
    struct
    {
        ExPlayerCharacter characterID : 1;
        u8 btnRight : 1;
        u8 btnUp : 1;
        u8 btnLeft : 1;
        u8 btnDown : 1;
        u8 movingDiagonal : 1;
        u8 isInvisible : 1;
        u8 isHurt : 1;
    } playerFlags;
    struct
    {
        u8 disableDash : 1;
        u8 isChargeFlash : 1;
        u8 hasDied : 1;
    } moveFlags;
} exPlayerAdminTaskWorker;

typedef struct exPlayerAdminTask_
{
    s32 unused;
    exPlayerAdminTaskWorker *worker;
    struct exPlayerGraphics3D *aniSonic;
    struct exPlayerGraphics3D *aniBlaze;
    EX_ACTION_NN_WORK *activeModelMain;
    EX_ACTION_NN_WORK *activeModelSub;
    EX_ACTION_BAC3D_WORK spriteSonic;
    EX_ACTION_BAC3D_WORK spriteBlaze;
    EX_ACTION_BAC3D_WORK *activeSprite;
    EX_ACTION_TRAIL_WORK trailA;
    EX_ACTION_TRAIL_WORK trailB;
} exPlayerAdminTask;

typedef struct exPlayerScreenMoveTask_
{
    s32 unused;
    exDrawFadeUnknown *unknownA;
    exDrawFadeUnknown *unknownB;
} exPlayerScreenMoveTask;

// --------------------
// FUNCTIONS
// --------------------

// ExPlayer helpers
exPlayerAdminTaskWorker *GetExPlayerWorker(void);

// ExPlayer
void CreateExPlayer(void);
void DestroyExPlayer(void);
VecFx32 *GetExPlayerPosition(void);

#endif // RUSH_EXPLAYER_H
