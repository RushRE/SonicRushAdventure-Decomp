#ifndef RUSH_EXSAVE_H
#define RUSH_EXSAVE_H

#include <global.h>

// --------------------
// ENUMS
// --------------------

enum ExFinishMode_
{
    EXFINISHMODE_NONE,
    EXFINISHMODE_RUNNING,
    EXFINISHMODE_BOSS_DEFEATED,
    EXFINISHMODE_STAGE_CLEARED,
    EXFINISHMODE_PAUSED,
    EXFINISHMODE_USER_QUIT,
    EXFINISHMODE_PLAYER_DEATH,
    EXFINISHMODE_UNUSED,
    EXFINISHMODE_GAME_OVER,
};
typedef u8 ExFinishMode;

// --------------------
// FUNCTIONS
// --------------------

void EndExBossStage(ExFinishMode mode);

#endif // RUSH_EXSAVE_H
