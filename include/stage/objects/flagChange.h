#ifndef RUSH_FLAGCHANGE_H
#define RUSH_FLAGCHANGE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FlagChange_
{
    GameObjectTask gameWork;
} FlagChange;

// --------------------
// FUNCTIONS
// --------------------

FlagChange *CreateFlagChange(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_FLAGCHANGE_H
