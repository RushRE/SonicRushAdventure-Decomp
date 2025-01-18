#ifndef RUSH_SEAMAPCOLLISION_H
#define RUSH_SEAMAPCOLLISION_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED s32 SeaMapCollision__GetCollisionAtPos32(s32 x, s32 y);
NOT_DECOMPILED s32 SeaMapCollision__Collide(s32 x, s32 y, BOOL checkMapPixel);
NOT_DECOMPILED void SeaMapCollision__HandleCollisions(u32 a1, u32 a2, u32 inY, u32 inX, BOOL checkMapPixel, s16 *outX, s16 *outY);
NOT_DECOMPILED void SeaMapCollision__UpdateMapCollision(void);
NOT_DECOMPILED s32 SeaMapCollision__GetCollision(void *mapCol, s32 x, s32 y);
NOT_DECOMPILED void *SeaMapManager__SetMapCollision(void *mapCol, s32 x, s32 y, u8 newValue);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_6(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_0(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_1(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_2(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_3(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_4(void);
NOT_DECOMPILED s32 SeaMapCollision__CollideFunc_5(void);

#endif // RUSH_SEAMAPCOLLISION_H