#ifndef RUSH_CHECKPOINT_H
#define RUSH_CHECKPOINT_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define CHECKPOINT_LAP_COUNT 5

// --------------------
// ENUMS
// --------------------

enum CheckpointAnimIDs
{
    CHECKPOINT_ANI_IDLE,
    CHECKPOINT_ANI_ACTIVATING,
    CHECKPOINT_ANI_ACTIVATED,
};

// --------------------
// STRUCTS
// --------------------

typedef struct Checkpoint_
{
    GameObjectTask gameWork;
} Checkpoint;

// --------------------
// FUNCTIONS
// --------------------

Checkpoint *CreateCheckpoint(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_CHECKPOINT_H
