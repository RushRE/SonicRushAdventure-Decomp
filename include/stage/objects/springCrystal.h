#ifndef RUSH2_SPRINGCRYSTAL_H
#define RUSH2_SPRINGCRYSTAL_H

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

#endif // RUSH2_SPRINGCRYSTAL_H