#ifndef RUSH_SPRINGCRYSTAL_H
#define RUSH_SPRINGCRYSTAL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SpringCrystal_
{
    GameObjectTask gameWork;
} SpringCrystal;

// --------------------
// FUNCTIONS
// --------------------

SpringCrystal *CreateSpringCrystal(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SPRINGCRYSTAL_H