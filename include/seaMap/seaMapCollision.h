#ifndef RUSH_SEAMAPCOLLISION_H
#define RUSH_SEAMAPCOLLISION_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// FUNCTIONS
// --------------------

s32 SeaMapCollision__GetCollisionAtPoint(u16 x, u16 y);
s32 SeaMapCollision__Collide(u16 x, u16 y, BOOL checkMapPixel);
BOOL SeaMapCollision__HandleCollisions(u16 outX, u16 outY, u16 inX, u16 inY, BOOL checkMapPixel, u16 *x, u16 *y);
void SeaMapCollision__UpdateMapCollision(void);

#endif // RUSH_SEAMAPCOLLISION_H