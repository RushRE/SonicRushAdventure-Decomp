#ifndef RUSH_BUNGEE_H
#define RUSH_BUNGEE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Bungee_
{
    GameObjectTask gameWork;
} Bungee;

// --------------------
// FUNCTIONS
// --------------------

Bungee *CreateBungee(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_BUNGEE_H
