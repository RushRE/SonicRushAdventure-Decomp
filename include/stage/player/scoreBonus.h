#ifndef RUSH2_SCORE_BONUS_H
#define RUSH2_SCORE_BONUS_H

#include <stage/player/starCombo.h>

// --------------------
// CONSTANTS
// --------------------

#define SCOREBONUS_DIGIT_COUNT 5

// --------------------
// STRUCTS
// --------------------

struct ScoreBonus_
{
    u32 flags;
    Player *player;
    StarCombo *starComboManager;
    u32 score;
    u32 displayScore;
    fx32 scale;
    s16 digitDelay[SCOREBONUS_DIGIT_COUNT];
    s16 comboCancelTimer;
    fx32 positionY;
};

// --------------------
// FUNCTIONS
// --------------------

ScoreBonus *ScoreBonus__Create(void);
void ScoreBonus__Main(void);
void ScoreBonus__Destructor(Task *task);

#endif // RUSH2_SCORE_BONUS_H