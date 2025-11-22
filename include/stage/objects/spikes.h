#ifndef RUSH_SPIKES_H
#define RUSH_SPIKES_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum SpikesAnimID
{
    SPIKES_ANI_VERTICAL_VISIBLE,
    SPIKES_ANI_VERTICAL_EXTEND,
    SPIKES_ANI_VERTICAL_RETRACT,
    SPIKES_ANI_VERTICAL_HIDDEN,
    SPIKES_ANI_HORIZONTAL,
};

// --------------------
// STRUCTS
// --------------------

typedef struct Spikes_
{
    GameObjectTask gameWork;
} Spikes;

// --------------------
// FUNCTIONS
// --------------------

Spikes *CreateSpikes(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
Spikes *CreateSpikes2(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SPIKES_H
