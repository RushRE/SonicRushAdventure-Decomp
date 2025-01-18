#ifndef RUSH_STAR_COMBO_H
#define RUSH_STAR_COMBO_H

#include <stage/player/player.h>

// --------------------
// CONSTANTS
// --------------------

#define STARCOMBO_MAX_VISIBLE_STARS 6
#define STARCOMBO_MAX_TOTAL_STARS   99

#define STARCOMBO_STAR_AWARD_TENSION 266

// --------------------
// ENUMS
// --------------------

enum StarComboFlags_
{
    STARCOMBO_FLAG_COMBO_FAIL         = 0x1,
    STARCOMBO_FLAG_COMBO_SUCCESS      = 0x2,
    STARCOMBO_FLAG_DESTROYED          = 0x4,
    STARCOMBO_FLAG_DISPLAY_STAR_COUNT = 0x8,
    STARCOMBO_FLAG_FORCE_COMBO_FAIL   = 0x10,
    STARCOMBO_FLAG_STAR_VISIBLE_1     = 0x4000000,
    STARCOMBO_FLAG_STAR_VISIBLE_2     = 0x8000000,
    STARCOMBO_FLAG_STAR_VISIBLE_3     = 0x10000000,
    STARCOMBO_FLAG_STAR_VISIBLE_4     = 0x20000000,
    STARCOMBO_FLAG_STAR_VISIBLE_5     = 0x40000000,
    STARCOMBO_FLAG_STAR_VISIBLE_6     = 0x80000000,
};
typedef u32 StarComboFlags;

enum StarComboMode_
{
    STARCOMBO_MODE_RISE1,
    STARCOMBO_MODE_RISE2,
    STARCOMBO_MODE_RISE3,
    STARCOMBO_MODE_ADVANCE_STATE,
};
typedef u16 StarComboMode;

enum StarComboAnimID
{
    STARCOMBO_ANIM_IDLE,
    STARCOMBO_ANIM_ACTIVE_SPIN,
    STARCOMBO_ANIM_SPIN_AVAILSTAR,
    STARCOMBO_ANIM_SPIN_ALLSTARS,
    STARCOMBO_ANIM_SUCCESS_SPIN,
    STARCOMBO_ANIM_EXITSTAR,
};

// --------------------
// STRUCTS
// --------------------

typedef struct StarComboStar_
{
    Vec2Fx32 position;
    Vec2Fx32 startPosition;
    Vec2Fx32 targetPosition;
    s16 timer;
    s16 percent;
    u16 angle;
    u16 spinSpeed;
    u32 angleDistance;
    s32 fallVelocity;
} StarComboStar;

struct StarCombo_
{
    StarComboFlags flags;
    Player *player;
    AnimatorSpriteDS starAnimators[STARCOMBO_MAX_VISIBLE_STARS];
    u16 starCount;
    u16 displayStarCount;
    void (*starStates[STARCOMBO_MAX_VISIBLE_STARS])(struct StarCombo_ *work, s32 id);
    StarComboStar stars[STARCOMBO_MAX_VISIBLE_STARS];
    void (*state)(struct StarCombo_ *work);
    Vec2Fx32 digit2Position;
    Vec2Fx32 digit1Position;
    fx32 digitLOffsetX;
    fx32 digitROffsetX;
    fx32 digitOffsetY;
    fx32 digitScale;
    fx32 digitVelocity;
    s16 timer;
    StarComboMode mode;
    u16 failedStarCount;
};

// --------------------
// FUNCTIONS
// --------------------

void StarCombo__SpawnConfetti(void);
void StarCombo__Destroy(void);
void StarCombo__PerformTrick(Player *player);
void StarCombo__FinishTrickCombo(Player *player, BOOL performTrick);
void StarCombo__FailCombo(Player *player);
void StarCombo__InitScoreBonus(Player *player, s32 score);
void StarCombo__DisplayConfetti(Player *player);
void StarCombo__SetStarAnimation(AnimatorSpriteDS *work, u16 anim);

StarCombo *StarCombo__Create(Player *player);
void StarCombo__Destructor(Task *task);
void StarCombo__Main(void);
void StarCombo__UpdateCombo(StarCombo *work);

void StarCombo__State_ComboUpdate(StarCombo *work);
void StarCombo__State_ComboSuccess(StarCombo *work);
void StarCombo__State_ComboFailWait(StarCombo *work);
void StarCombo__State_ComboFailed(StarCombo *work);

void StarCombo__InsertStar(StarCombo *work, s32 id);

void StarCombo__StateStar_EnterStar(StarCombo *work, s32 id);
void StarCombo__StateStar_ComboActiveSpin(StarCombo *work, s32 id);
void StarCombo__StateStar_ComboSuccessSpin(StarCombo *work, s32 id);
void StarCombo__StateStar_EnterTensionGauge(StarCombo *work, s32 id);
void StarCombo__StateStar_ExitStar(StarCombo *work, s32 id);
void StarCombo__StateStar_ComboFailDelay(StarCombo *work, s32 id);
void StarCombo__StateStar_ComboFailFall(StarCombo *work, s32 id);

// --------------------
// INLINE FUNCTIONS
// --------------------

#endif // RUSH_STAR_COMBO_H