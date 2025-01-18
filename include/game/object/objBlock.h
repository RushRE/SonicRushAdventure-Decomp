#ifndef RUSH_OBJ_BLOCK_H
#define RUSH_OBJ_BLOCK_H

#include <global.h>
#include <game/object/objCollision.h>

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

NOT_DECOMPILED void ObjSetBlockCollision(OBS_BLOCK_COLLISION *bCol);
NOT_DECOMPILED s32 ObjBlockCollision(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objGetBlockColData(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockColLimit(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockCalcEmpty(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockCalcFill(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockColEmpty(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockColBlockFill(OBS_COL_CHK_DATA *work);
NOT_DECOMPILED s32 objBlockColBlockFillThrough(OBS_COL_CHK_DATA *work);

#endif // RUSH_OBJ_BLOCK_H
