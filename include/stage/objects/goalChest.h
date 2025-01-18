#ifndef RUSH_GOALCHEST_H
#define RUSH_GOALCHEST_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct GoalChest_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniChest;
    AnimatorMDL aniChestEffect;
} GoalChest;

// --------------------
// FUNCTIONS
// --------------------

GoalChest *CreateGoalChest(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_GOALCHEST_H
