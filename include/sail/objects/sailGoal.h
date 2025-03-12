#ifndef RUSH_SAILGOAL_H
#define RUSH_SAILGOAL_H

#include <sail/sailCommonObjects.h>

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateSailGoalChaosEmerald(fx32 voyagePosZ);
StageTask *CreateSailGoal(fx32 radius);
StageTask *CreateSailGoalText(fx32 voyagePosZ);

#endif // !RUSH_SAILGOAL_H