#ifndef RUSH_OBJ_BLOCK_H
#define RUSH_OBJ_BLOCK_H

#include <global.h>
#include <game/object/objCollision.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define OBJ_BLOCK_SIZE    (16)
#define OBJ_BLOCK_SIZE_M1 (OBJ_BLOCK_SIZE - 1)

// --------------------
// STRUCTS
// --------------------

typedef struct OBS_BLOCK_COLLISION_
{
    u8 *pData[2];
    s32 width;
    s32 height;
    s32 left;
    s32 top;
    s32 right;
    s32 bottom;
} OBS_BLOCK_COLLISION;

// --------------------
// FUNCTIONS
// --------------------

void ObjSetBlockCollision(OBS_BLOCK_COLLISION *collisionData);
s32 ObjBlockCollision(OBS_COL_CHK_DATA *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_OBJ_BLOCK_H
