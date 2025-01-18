#ifndef RUSH_SPIKES_H
#define RUSH_SPIKES_H

#include <stage/gameObject.h>

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
