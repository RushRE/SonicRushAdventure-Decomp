#ifndef RUSH_SEAMAPCOLLISION_H
#define RUSH_SEAMAPCOLLISION_H

#include <global.h>
#include <game/system/task.h>
#include <seaMap/seaMapManager.h>

// --------------------
// FUNCTIONS
// --------------------

SeaMapCollisionType SeaMapCollision_GetCollisionAtPoint(u16 x, u16 y);
BOOL SeaMapCollision__Collide(u16 x, u16 y, BOOL checkMapPixel);
BOOL SeaMapCollision__HandleCollisions(u16 outX, u16 outY, u16 inX, u16 inY, BOOL checkMapPixel, u16 *x, u16 *y);
void SeaMapCollision__UpdateMapCollision(void);

#endif // RUSH_SEAMAPCOLLISION_H