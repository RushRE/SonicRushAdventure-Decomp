#include <game/object/objCollision.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

struct ObjCollisionCount
{
    u8 nextCount;
    u8 curCount;
};

// --------------------
// VARIABLES
// --------------------

#include <nitro/dtcm_begin.h>

static const OBS_DIFF_COLLISION *objCollisionData = NULL;

struct ObjCollisionCount objCollisionCount;

StageTaskCollisionObj *objCollisionTable[OBJ_COLLISION_REGISTRATION_MAX];
StageTaskCollisionObj *objNextCollisionTable[OBJ_COLLISION_REGISTRATION_MAX];

#include <nitro/dtcm_end.h>

// --------------------
// FUNCTIONS DECLS
// --------------------

static void objDiffAttrSet(StageTask *work, u32 attr);
static s32 objCollision(OBS_COL_CHK_DATA *colWork);
static s32 objCollisionFast(OBS_COL_CHK_DATA *colWork);
static s32 ObjCollisionUnion(StageTask *work, OBS_COL_CHK_DATA *colWork);
static void objDiffCollisionDirCheck(StageTask *work);
static ObjCollisionFlags objDiffSufSet(StageTask *work);
static void objDiffCollisionDirWidthCheck(StageTask *work, u8 wallOnly, fx32 moveSpeed);
static BOOL objDiffCollisionSimpleOverCheck(StageTask *work);
static void objDiffCollisionDirHeightCheck(StageTask *work);
static u32 objGetMapBlockData(s32 x, s32 y, u8 plane);
static s32 objGetMapColDataX(fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
static s32 objGetMapColDataY(fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
static void objCollsionOffsetSet(StageTaskCollisionObj *work, s16 *offsetX, s16 *offsetY);
static s32 ObjCollisionObjectFastCheck(OBS_COL_CHK_DATA *colWork);
static s32 ObjCollisionObjectCheck(StageTask *work, OBS_COL_CHK_DATA *colWork);
static s32 objFastCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork);
static s32 objCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork);
static s32 objGetColDataX(StageTaskCollisionObj *work, fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
static s32 objGetColDataY(StageTaskCollisionObj *work, fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s32 objMapGetDiff(s32 lCol, s8 sPix, s8 delta)
{
    if (lCol > 0)
    {
        if (delta > 0)
            return lCol - (sPix + 1);
        else
            return lCol = 8 - sPix;
    }
    else
    {
        if (delta > 0)
            return -(sPix + 1);
        else
            return lCol + sPix;
    }
}

RUSH_INLINE s32 objMapGetForward(s8 sPix, s8 delta)
{
    if (delta > 0)
        return (8 - sPix);
    else
        return (1 + sPix);
}

RUSH_INLINE s32 objMapGetBack(s8 sPix, s8 delta)
{
    if (delta > 0)
        return -(sPix + 1);
    else
        return (sPix - 8);
}

RUSH_INLINE s32 objMapGetForwardRev(s8 sPix, s8 delta)
{
    if (delta > 0)
        return (8 - (sPix + 1));
    else
        return (sPix);
}

RUSH_INLINE s32 objMapGetBackFront(s8 sPix, s8 delta)
{
    if (delta > 0)
        return -(sPix);
    else
        return (sPix - 8);
}

RUSH_INLINE u8 objGetAttrData(u16 tileID)
{
    return objCollisionData->attrCollision[tileID];
}

RUSH_INLINE void objDiffColDirMove(s32 *x, s32 *y, s8 step, u16 vec)
{
    switch (vec)
    {
        default:
        case OBD_COL_DOWN:
            *y += step;
            break;

        case OBD_COL_LEFT:
            *x -= step;
            break;

        case OBD_COL_UP:
            *y -= step;
            break;

        case OBD_COL_RIGHT:
            *x += step;
            break;
    }
}

RUSH_INLINE s8 objDiffColVibCheck(s32 posX, s32 posY, s16 rectX1, s16 rectX2, s16 rectY1, s16 rectY2, u16 usVec, u16 usFlag, s8 penetration1, s8 penetration2)
{
    OBS_COL_CHK_DATA colWork = { 0 };
    s8 delta;

    colWork.vec  = usVec;
    colWork.flag = usFlag;

    if (penetration1 < penetration2)
        delta = penetration1;
    else
        delta = penetration2;

    switch (colWork.vec)
    {
        case OBD_COL_DOWN:
            rectY1 += delta;
            rectY2 += delta;
            break;

        case OBD_COL_LEFT:
            rectX1 -= delta;
            rectX2 -= delta;
            break;

        case OBD_COL_UP:
            rectY1 -= delta;
            rectY2 -= delta;
            break;

        case OBD_COL_RIGHT:
            rectX1 += delta;
            rectX2 += delta;
            break;
    }

    colWork.x    = posX + rectX1;
    colWork.y    = posY + rectY1;
    penetration1 = objCollisionFast(&colWork);

    colWork.x    = posX + rectX2;
    colWork.y    = posY + rectY2;
    penetration2 = objCollisionFast(&colWork);

    if (penetration1 < penetration2)
        return penetration1;

    return penetration2;
}

// --------------------
// FUNCTIONS
// --------------------

void ObjObjectCollisionDifSet(StageTask *work, const char *filePath, OBS_DATA_WORK *diffDataWork, NNSiFndArchiveHeader *archive)
{
    if (work->collisionObj == NULL)
        return;

    work->collisionObj->diff_data_work = diffDataWork;
    work->collisionObj->work.diff_data = ObjDataLoad(diffDataWork, filePath, archive);
}

void ObjObjectCollisionDirSet(StageTask *work, const char *filePath, OBS_DATA_WORK *dirDataWork, NNSiFndArchiveHeader *archive)
{
    if (work->collisionObj == NULL)
        return;

    work->collisionObj->dir_data_work = dirDataWork;
    work->collisionObj->work.dir_data = ObjDataLoad(dirDataWork, filePath, archive);
}

void ObjObjectCollisionAttrSet(StageTask *work, const char *filePath, OBS_DATA_WORK *attrDataWork, NNSiFndArchiveHeader *archive)
{
    if (work->collisionObj == NULL)
        return;

    work->collisionObj->attr_data_work = attrDataWork;
    work->collisionObj->work.attr_data = ObjDataLoad(attrDataWork, filePath, archive);
}

#include <nitro/itcm_begin.h>

void objDiffAttrSet(StageTask *work, u32 attr)
{
    if ((attr & OBJ_COL_ATTR_CLIFF_EDGE) != 0)
        work->collisionFlag |= STAGE_TASK_COLLISION_FLAG_CLIFF_EDGE;

    if ((attr & OBJ_COL_ATTR_GRIND_RAIL) != 0)
        work->collisionFlag |= STAGE_TASK_COLLISION_FLAG_GRIND_RAIL;
}

s32 objCollision(OBS_COL_CHK_DATA *colWork)
{
    if ((g_obj.flag & OBJECTMANAGER_FLAG_USE_BLOCK_COLLISIONS) != 0)
        return ObjBlockCollision(colWork);
    else
        return ObjDiffCollision(colWork);
}

s32 objCollisionFast(OBS_COL_CHK_DATA *colWork)
{
    if ((g_obj.flag & OBJECTMANAGER_FLAG_USE_BLOCK_COLLISIONS) != 0)
        return ObjBlockCollision(colWork);
    else
        return ObjDiffCollisionFast(colWork);
}

s32 ObjCollisionUnion(StageTask *work, OBS_COL_CHK_DATA *colWork)
{
    s32 colResult = 32;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) == 0)
        colResult = objCollision(colWork);

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
    {
        s32 objResult = ObjCollisionObjectCheck(work, colWork);

        if (colResult > objResult)
            colResult = objResult;
    }

    return colResult;
}

s32 ObjCollisionFastUnion(OBS_COL_CHK_DATA *colWork)
{
    s32 colResult = objCollisionFast(colWork);
    s32 objResult = ObjCollisionObjectFastCheck(colWork);

    if (colResult > objResult)
        colResult = objResult;

    return colResult;
}

void ObjDiffCollisionEarthCheck(StageTask *work)
{
    objDiffCollisionDirCheck(work);
}

void objDiffCollisionDirCheck(StageTask *work)
{
    work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_400000;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        work->moveFlag |= STAGE_TASK_MOVE_FLAG_400000;

    work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;
    work->collisionFlag = STAGE_TASK_COLLISION_FLAG_NONE;

    fx32 moveSpeed = work->move.x;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK) == 0)
        objDiffCollisionDirWidthCheck(work, FALSE, moveSpeed);

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK) == 0)
        objDiffCollisionDirHeightCheck(work);

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        work->position.y &= 0xFFFFF000;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK) == 0)
        objDiffCollisionDirWidthCheck(work, TRUE, moveSpeed);
}

ObjCollisionFlags objDiffSufSet(StageTask *work)
{
    ObjCollisionFlags flags = OBJ_COL_FLAG_NONE;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_ALLOW_TOP_SOLID) != 0)
        flags |= OBJ_COL_FLAG_ALLOW_TOP_SOLID;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_100000) == 0)
        flags |= OBJ_COL_FLAG_ALLOW_TOP_SOLID;

    if ((work->flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0)
        flags |= OBJ_COL_FLAG_USE_PLANE_B;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_80000) != 0)
        flags |= OBJ_COL_FLAG_LIMIT_MAP_BOUNDS;

    return flags;
}

void objDiffCollisionDirWidthCheck(StageTask *work, u8 wallOnly, s32 moveSpeed)
{
    OBS_COL_CHK_DATA colWork = { 0 };

    u16 dir;
    s8 penetration1;
    s8 penetration2;
    s8 penetration     = 0;
    s16 rectX1         = 0;
    s16 rectY1         = 0;
    s16 rectX2         = 0;
    s16 rectY2         = 0;
    u8 flip            = 0;
    s8 hitboxTopOffset = 0;
    s32 posX;
    s32 posY;
    fx32 moveSpeedX;

    colWork.flag = objDiffSufSet(work);
    colWork.flag |= OBJ_COL_FLAG_ALLOW_TOP_SOLID;

    posX = FX32_TO_WHOLE(work->position.x);
    posY = FX32_TO_WHOLE(work->position.y);

    dir = FLOAT_DEG_TO_IDX(90.0);

    if ((((work->dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14) == 2)
    {
        dir += FLOAT_DEG_TO_IDX(180.0);
    }

    moveSpeedX = moveSpeed;
    if (moveSpeedX > FLOAT_TO_FX32(0.0))
    {
        dir  = (u16)-dir;
        flip = 1;
    }
    else
    {
        if ((work->displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        {
            dir  = (u16)-dir;
            flip = 1;
        }
    }

    if (work->fallDir)
    {
        dir += work->fallDir;
        if (moveSpeedX > FLOAT_TO_FX32(0.0))
        {
            dir  = (u16)-dir;
            flip = 0;
        }
    }

    if ((((work->dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14) == 2)
    {
        flip ^= 1;
    }

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        dir += work->dir.z;

    if (objDiffCollisionSimpleOverCheck(work))
        hitboxTopOffset = 6;

    switch (((dir + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14)
    {
        case 0:
            rectY1 = (work->hitboxRect.right + 2);
            rectY2 = rectY1;
            rectX1 = (work->hitboxRect.bottom - 4);
            rectX2 = (work->hitboxRect.top + 4);

            colWork.vec = OBD_COL_DOWN;
            break;

        case 1:
            rectX1 = (work->hitboxRect.left - 2);
            rectX2 = rectX1;
            rectY1 = (work->hitboxRect.bottom - 4);
            rectY2 = (work->hitboxRect.top + hitboxTopOffset);

            if (flip)
            {
                rectY1 = -rectY1;
                rectY2 = -rectY2;
            }

            colWork.vec = OBD_COL_LEFT;
            break;

        case 2:
            rectY1 = (work->hitboxRect.left - 2);
            rectY2 = rectY1;
            rectX1 = (work->hitboxRect.bottom - 4);
            rectX2 = (work->hitboxRect.top + 4);

            colWork.vec = OBD_COL_UP;
            break;

        case 3:
            rectX1 = (work->hitboxRect.right + 2);
            rectX2 = rectX1;
            rectY1 = -(work->hitboxRect.bottom - 4);
            rectY2 = -(work->hitboxRect.top + hitboxTopOffset);

            colWork.vec = OBD_COL_RIGHT;

            if (flip)
            {
                rectY1 = -rectY1;
                rectY2 = -rectY2;
            }
            break;
    }

    colWork.x    = posX + rectX1;
    colWork.y    = posY + rectY1;
    penetration1 = ObjCollisionUnion(work, &colWork);

    colWork.x    = posX + rectX2;
    colWork.y    = posY + rectY2;
    penetration2 = ObjCollisionUnion(work, &colWork);

    if (penetration1 < penetration2)
        penetration1 = penetration1;
    else
        penetration1 = penetration2;

    penetration = penetration1;
    if (penetration1 <= 0)
    {
        if (wallOnly == FALSE)
        {
            objDiffColDirMove(&posX, &posY, penetration1, colWork.vec);
        }
        else
        {
            work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;

            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0)
            {
                if (colWork.vec == OBD_COL_LEFT && work->move.x < 0)
                {
                    work->groundVel  = FLOAT_TO_FX32(0.0);
                    work->velocity.x = FLOAT_TO_FX32(0.0);
                }

                if (colWork.vec == OBD_COL_RIGHT && work->move.x > 0)
                {
                    work->groundVel  = FLOAT_TO_FX32(0.0);
                    work->velocity.x = FLOAT_TO_FX32(0.0);
                }
            }

            if (colWork.vec & OBD_COL_Y)
            {
                if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0)
                {
                    work->velocity.y = FLOAT_TO_FX32(0.0);
                    work->groundVel  = FLOAT_TO_FX32(0.0);
                }
            }
        }
    }

    dir += FLOAT_DEG_TO_IDX(180.0);

    switch (((dir + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14)
    {
        case 0:
            rectY1 = (work->hitboxRect.right + 2);
            rectY2 = rectY1;
            rectX1 = (work->hitboxRect.bottom - 4);
            rectX2 = (work->hitboxRect.top + 4);

            colWork.vec = OBD_COL_DOWN;
            break;

        case 1:
            rectX1 = (work->hitboxRect.left - 2);
            rectX2 = rectX1;
            rectY1 = -(work->hitboxRect.bottom - 4);
            rectY2 = -(work->hitboxRect.top + hitboxTopOffset);

            colWork.vec = OBD_COL_LEFT;

            if (flip)
            {
                rectY1 = -rectY1;
                rectY2 = -rectY2;
            }
            break;

        case 2:
            rectY1 = (work->hitboxRect.left - 2);
            rectY2 = rectY1;
            rectX1 = (work->hitboxRect.bottom - 4);
            rectX2 = (work->hitboxRect.top + 4);

            colWork.vec = OBD_COL_UP;
            break;

        case 3:
            rectX1 = (work->hitboxRect.right + 2);
            rectX2 = rectX1;
            rectY1 = (work->hitboxRect.bottom - 4);
            rectY2 = (work->hitboxRect.top + hitboxTopOffset);

            colWork.vec = OBD_COL_RIGHT;

            if (flip)
            {
                rectY1 = -rectY1;
                rectY2 = -rectY2;
            }
            break;
    }

    colWork.x    = posX + rectX1;
    colWork.y    = posY + rectY1;
    penetration1 = ObjCollisionUnion(work, &colWork);

    colWork.x    = posX + rectX2;
    colWork.y    = posY + rectY2;
    penetration2 = ObjCollisionUnion(work, &colWork);

    if (penetration1 < penetration2)
        penetration1 = penetration1;
    else
        penetration1 = penetration2;

    if (penetration1 <= 0)
    {
        if (wallOnly == FALSE)
        {
            objDiffColDirMove(&posX, &posY, penetration1, colWork.vec);
        }
        else
        {
            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) == 0 || penetration1 < 0)
                work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL;

            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0)
            {
                if (colWork.vec == OBD_COL_LEFT && moveSpeed < FLOAT_TO_FX32(0.0))
                    work->groundVel = FLOAT_TO_FX32(0.0);

                if (colWork.vec == OBD_COL_RIGHT && moveSpeed > FLOAT_TO_FX32(0.0))
                    work->groundVel = FLOAT_TO_FX32(0.0);

                if (colWork.vec == OBD_COL_LEFT && work->velocity.x < FLOAT_TO_FX32(0.0))
                    work->velocity.x = FLOAT_TO_FX32(0.0);

                if (colWork.vec == OBD_COL_RIGHT && work->velocity.x > FLOAT_TO_FX32(0.0))
                    work->velocity.x = FLOAT_TO_FX32(0.0);
            }
        }
    }

    if (wallOnly == FALSE)
    {
        work->position.x -= FX32_FROM_WHOLE(FX32_TO_WHOLE(work->position.x) - posX);
        work->position.y -= FX32_FROM_WHOLE(FX32_TO_WHOLE(work->position.y) - posY);
    }
}

BOOL objDiffCollisionSimpleOverCheck(StageTask *work)
{
    OBS_COL_CHK_DATA colWork = { 0 };
    colWork.flag             = objDiffSufSet(work);

    u16 dir;
    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
        dir = 0;
    else
        dir = (work->dir.z + FLOAT_DEG_TO_IDX(45.0) & 0xC000) >> 14;

    if (work->fallDir != 0)
        dir = (u16)(dir + (u16)((work->fallDir + FLOAT_DEG_TO_IDX(45.0) & 0xC000) >> 14)) & 3;

    s16 rectX1;
    s16 rectX2;
    s16 rectY1;
    s16 rectY2;
    switch (dir)
    {
        case 0:
        default:
            rectY1 = work->hitboxRect.top;
            rectY2 = work->hitboxRect.top;
            rectX1 = (work->hitboxRect.right - 2);
            rectX2 = (work->hitboxRect.left + 2);

            colWork.vec = OBD_COL_UP;
            break;

        case 1:
            rectX1 = work->hitboxRect.right;
            rectX2 = work->hitboxRect.right;
            rectY1 = (work->hitboxRect.left + 2);
            rectY2 = (work->hitboxRect.right - 2);

            colWork.vec = OBD_COL_RIGHT;
            break;

        case 2:
            rectY1 = work->hitboxRect.bottom;
            rectY2 = work->hitboxRect.bottom;
            rectX1 = (work->hitboxRect.right - 2);
            rectX2 = (work->hitboxRect.left + 2);

            colWork.vec = OBD_COL_DOWN;
            break;

        case 3:
            rectX1 = work->hitboxRect.left;
            rectX2 = work->hitboxRect.left;
            rectY1 = (work->hitboxRect.left + 2);
            rectY2 = (work->hitboxRect.right - 2);

            colWork.vec = OBD_COL_LEFT;
            break;
    }

    colWork.x = FX32_TO_WHOLE(work->position.x) + rectX1;
    colWork.y = FX32_TO_WHOLE(work->position.y) + rectY1;
    s8 c1     = ObjCollisionUnion(work, &colWork);

    colWork.x = FX32_TO_WHOLE(work->position.x) + rectX2;
    colWork.y = FX32_TO_WHOLE(work->position.y) + rectY2;
    s8 c2     = ObjCollisionUnion(work, &colWork);

    s8 result;
    if (c1 < c2)
        result = c1;
    else
        result = c2;

    return result <= 0;
}

void objDiffCollisionDirHeightCheck(StageTask *work)
{
    OBS_COL_CHK_DATA colWork = { 0 };
    StageTask *rideObj       = work->rideObj;

    s32 posX;
    s32 posY;
    s32 stepX;
    s32 stepY;

    u32 attr = OBJ_COL_ATTR_NONE;

    u16 dir;
    u16 dir1, dir2, dir3;

    s8 delta;
    s8 hitboxTopOffset;
    s8 penetration1, penetration2;

    s8 stepSpeed;
    s16 rectX1 = 0, rectX2 = 0;
    s16 rectY1 = 0, rectY2 = 0;
    s16 rectX3 = 0;
    s16 rectY3 = 0;

    colWork.flag = objDiffSufSet(work);

    posX = FX32_TO_WHOLE(work->position.x);
    posY = FX32_TO_WHOLE(work->position.y);

    dir1 = dir2 = (u16)work->dir.z;

    if (work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR)
        dir = 0;
    else
        dir = (u16)(((work->dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14);

    if (work->fallDir)
    {
        dir += (u16)(((work->fallDir + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14);
        dir &= 0x3;
    }

    switch (dir)
    {
        default:
        case 0:
            rectX1 = (work->hitboxRect.right + 1);
            rectY1 = (work->hitboxRect.bottom);
            rectX2 = (work->hitboxRect.left - 1);
            rectY2 = (work->hitboxRect.bottom);
            rectX3 = 0;
            rectY3 = -g_obj.col_through_dot;

            colWork.vec = OBD_COL_DOWN;

            stepX = work->move.x;
            stepY = work->move.y;
            break;

        case 1:
            rectX1 = -(work->hitboxRect.bottom);
            rectY1 = (work->hitboxRect.left - 1);
            rectX2 = -(work->hitboxRect.bottom);
            rectY2 = (work->hitboxRect.right + 1);
            rectX3 = (work->hitboxRect.bottom - MATH_ABS(work->hitboxRect.right));
            rectY3 = 0;

            colWork.vec = OBD_COL_LEFT;

            stepY = -work->move.x;
            stepX = -work->move.y;
            break;

        case 2:
            rectX1 = (work->hitboxRect.right + 1);
            rectY1 = -(work->hitboxRect.bottom);
            rectX2 = (work->hitboxRect.left - 1);
            rectY2 = -(work->hitboxRect.bottom);
            rectX3 = 0;
            rectY3 = g_obj.col_through_dot;

            colWork.vec = OBD_COL_UP;

            stepX = -work->move.x;
            stepY = -work->move.y;
            break;

        case 3:
            rectX1 = (work->hitboxRect.bottom);
            rectY1 = (work->hitboxRect.left - 1);
            rectX2 = (work->hitboxRect.bottom);
            rectY2 = (work->hitboxRect.right + 1);
            rectX3 = -(work->hitboxRect.bottom - MATH_ABS(work->hitboxRect.left));
            rectY3 = 0;

            colWork.vec = OBD_COL_RIGHT;

            stepY = work->move.x;
            stepX = work->move.y;
            break;
    }

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_ALLOW_TOP_SOLID) == 0)
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_400000) == 0)
        {
            u16 storedFlag = colWork.flag;

            colWork.flag &= ~OBJ_COL_FLAG_ALLOW_TOP_SOLID;
            colWork.x    = posX + (rectX1 + rectX3);
            colWork.y    = posY + (rectY1 + rectY3);
            penetration1 = ObjCollisionUnion(work, &colWork);

            colWork.x    = posX + (rectX2 + rectX3);
            colWork.y    = posY + (rectY2 + rectY3);
            penetration2 = ObjCollisionUnion(work, &colWork);

            colWork.flag = storedFlag;

            work->rideObj = rideObj;

            if (penetration1 < penetration2)
                delta = penetration1;
            else
                delta = penetration2;

            if (delta >= 0)
                work->moveFlag |= STAGE_TASK_MOVE_FLAG_100000;
            else
                work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_100000;
        }
        else
        {
            if ((colWork.vec & OBD_COL_Y) != 0 || (work->prevCollisionFlag & STAGE_TASK_COLLISION_FLAG_GRIND_RAIL) != 0)
                work->moveFlag |= STAGE_TASK_MOVE_FLAG_100000;
            else
                work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_100000;
        }
    }

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_100000) == 0)
        colWork.flag |= OBJ_COL_FLAG_ALLOW_TOP_SOLID;

    colWork.attr = &attr;
    colWork.dir  = &dir1;
    colWork.x    = posX + rectX1;
    colWork.y    = posY + rectY1;
    penetration1 = ObjCollisionUnion(work, &colWork);
    objDiffAttrSet(work, attr);

    colWork.dir  = &dir2;
    colWork.x    = posX + rectX2;
    colWork.y    = posY + rectY2;
    penetration2 = ObjCollisionUnion(work, &colWork);
    objDiffAttrSet(work, attr);

    colWork.dir  = &dir3;
    colWork.attr = NULL;
    colWork.y    = posY + rectY1;
    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_200000) != 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
    {
        u8 i;
        s32 tempPos;
        s16 rectMax;

        if (rectX1 > rectX2)
        {
            rectMax = (rectX1 - rectX2) - 1;
            tempPos = posX + rectX2;
        }
        else
        {
            rectMax = (rectX2 - rectX1) - 1;
            tempPos = posX + rectX1;
        }

        for (i = 1; i < rectMax; i++)
        {
            colWork.x = tempPos + i;
            delta     = ObjCollisionObjectCheck(work, &colWork);

            if (delta < penetration1)
            {
                penetration1 = delta;
                dir1         = dir3;
            }
        }
    }

    {
        colWork.dir  = NULL;
        colWork.attr = &attr;
        colWork.y    = posY + rectY2;

        if (rectX1 < rectX2)
            colWork.x = (posX + rectX1) + ((MATH_ABS(rectX1) + MATH_ABS(rectX2)) >> 1);
        else
            colWork.x = (posX + rectX2) + ((MATH_ABS(rectX1) + MATH_ABS(rectX2)) >> 1);

        ObjCollisionUnion(work, &colWork);
        objDiffAttrSet(work, attr);
    }

    if (work->collisionFlag & STAGE_TASK_COLLISION_FLAG_GRIND_RAIL)
    {
        if (work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR && stepY > FLOAT_TO_FX32(0.0))
        {
            if ((work->collisionFlag & STAGE_TASK_COLLISION_FLAG_CLIFF_EDGE) == 0)
            {
                if ((u16)(dir1 + work->fallDir) >= FLOAT_DEG_TO_IDX(90.0) && (u16)(dir1 + work->fallDir) <= FLOAT_DEG_TO_IDX(270.0)
                    || (u16)(dir2 + work->fallDir) >= FLOAT_DEG_TO_IDX(90.0) && (u16)(dir2 + work->fallDir) <= FLOAT_DEG_TO_IDX(270.0))
                {
                    penetration1 = 24;
                    penetration2 = 24;
                }
            }
        }
    }

    if (penetration1 < penetration2)
        delta = penetration1;
    else
        delta = penetration2;

    if (delta != 0)
    {
        if (delta < 0)
        {
            if (!(work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR && stepY < FLOAT_TO_FX32(0.0)))
                work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

            if (delta >= -14 && work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR)
            {
                if (delta == -1 && work->moveFlag & STAGE_TASK_MOVE_FLAG_10000)
                {
                    penetration1 = objDiffColVibCheck(posX, posY, rectX1, rectX2, rectY1, rectY2, colWork.vec, colWork.flag, penetration1, penetration2);

                    if (penetration1 != 1)
                    {
                        objDiffColDirMove(&posX, &posY, delta, colWork.vec);
                        work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_10000;
                    }
                }
                else
                {
                    objDiffColDirMove(&posX, &posY, delta, colWork.vec);
                    work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_10000;
                }
            }
        }
        else
        {
            if (delta == 1)
                work->moveFlag |= STAGE_TASK_MOVE_FLAG_10000;

            if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
            {
                if (dir & 1)
                    stepSpeed = (s8)(FX32_TO_WHOLE(MATH_ABS(stepY)) + 3);
                else
                    stepSpeed = (s8)(FX32_TO_WHOLE(MATH_ABS(stepX)) + 3);

                if (stepSpeed > 11)
                    stepSpeed = 11;

                if (delta <= stepSpeed)
                {
                    work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

                    objDiffColDirMove(&posX, &posY, delta, colWork.vec);

                    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES) == 0
                        && work->touchObj == NULL)
                    {
                        colWork.attr = NULL;
                        colWork.dir  = NULL;
                        colWork.x    = posX + rectX1;
                        colWork.y    = posY + rectY1;
                        ObjCollisionObjectCheck(work, &colWork);

                        colWork.x = posX + rectX2;
                        colWork.y = posY + rectY2;
                        ObjCollisionObjectCheck(work, &colWork);
                    }
                }
                else
                {
                    work->moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
                }
            }
        }
    }
    else
    {
        if (!(work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR && work->velocity.y < 0))
        {
            work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        }
    }

    if (work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR)
    {
        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_20000000) == 0)
        {
            if ((work->collisionFlag & STAGE_TASK_COLLISION_FLAG_CLIFF_EDGE) == 0 && (work->moveFlag & STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES) != 0)
            {
                if (penetration1 < penetration2)
                {
                    dir1 = dir1;
                }
                else if (penetration1 > penetration2)
                {
                    dir1 = dir2;
                }
                else
                {
                    if (MATH_ABS((u16)(work->dir.z + work->fallDir) - dir1) > MATH_ABS((u16)(work->dir.z + work->fallDir) - dir2))
                    {
                        dir1 = dir2;
                    }
                }

                if (work->fallDir)
                {
                    dir1 += work->fallDir;
                }

                if (work->moveFlag & STAGE_TASK_MOVE_FLAG_800000)
                    work->dir.z = ObjRoopMove16(work->dir.z, dir1, FLOAT_DEG_TO_IDX(1.40625));
                else
                    work->dir.z = dir1;
            }
        }

        if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0)
        {
            if (work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR)
                dir = 0;
            else
                dir = (u16)(((work->dir.z + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14);

            switch (dir)
            {
                default:
                case 0:
                    if (work->velocity.y > 0)
                    {
                        if (work->moveFlag & STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION)
                            work->velocity.x += FX32_TO_WHOLE(work->velocity.y * SinFX(work->dir.z));

                        work->velocity.y = FLOAT_TO_FX32(0.0);
                    }
                    break;

                case 1:
                    if (work->velocity.x < FLOAT_TO_FX32(0.0))
                        work->velocity.x = FLOAT_TO_FX32(0.0);
                    break;

                case 2:
                    if (work->velocity.y < FLOAT_TO_FX32(0.0))
                        work->velocity.y = FLOAT_TO_FX32(0.0);
                    break;

                case 3:
                    if (work->velocity.x > FLOAT_TO_FX32(0.0))
                        work->velocity.x = FLOAT_TO_FX32(0.0);
                    break;
            }
        }
    }
    else
    {
        work->rideObj = rideObj;
    }

    if (stepY < FLOAT_TO_FX32(0.0625))
    {
        colWork.flag |= OBJ_COL_FLAG_ALLOW_TOP_SOLID;

        switch (colWork.vec)
        {
            default:
            case OBD_COL_DOWN:
                rectY1      = (s16)(work->hitboxRect.top + 2);
                rectY2      = (s16)(work->hitboxRect.top + 2);
                colWork.vec = OBD_COL_UP;
                break;

            case OBD_COL_LEFT:
                rectX1      = (s16)(work->hitboxRect.right - 2);
                rectX2      = (s16)(work->hitboxRect.right - 2);
                colWork.vec = OBD_COL_RIGHT;
                break;

            case OBD_COL_UP:
                rectY1      = (s16)(work->hitboxRect.bottom - 2);
                rectY2      = (s16)(work->hitboxRect.bottom - 2);
                colWork.vec = OBD_COL_DOWN;
                break;

            case OBD_COL_RIGHT:
                rectX1      = (s16)(work->hitboxRect.left + 2);
                rectX2      = (s16)(work->hitboxRect.left + 2);
                colWork.vec = OBD_COL_LEFT;
                break;
        }

        colWork.attr = NULL;
        colWork.dir  = NULL;
        colWork.x    = posX + rectX1;
        colWork.y    = posY + rectY1;
        penetration1 = (s8)ObjCollisionUnion(work, &colWork);

        colWork.x    = posX + rectX2;
        colWork.y    = posY + rectY2;
        penetration2 = (s8)ObjCollisionUnion(work, &colWork);

        if (penetration1 < penetration2)
            hitboxTopOffset = penetration1;
        else
            hitboxTopOffset = penetration2;

        if (hitboxTopOffset <= 0)
        {
            work->moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING;

            if (hitboxTopOffset >= -14)
            {
                objDiffColDirMove(&posX, &posY, hitboxTopOffset, colWork.vec);

                if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_4000) == 0 && stepY < FLOAT_TO_FX32(0.0))
                {
                    if (colWork.vec & OBD_COL_Y)
                        work->velocity.y = FLOAT_TO_FX32(0.0);
                    else
                        work->velocity.x = FLOAT_TO_FX32(0.0);
                }
            }
        }
    }

    work->position.x -= FX32_FROM_WHOLE(FX32_TO_WHOLE(work->position.x) - posX);
    work->position.y -= FX32_FROM_WHOLE(FX32_TO_WHOLE(work->position.y) - posY);
}

void ObjSetDiffCollision(OBS_DIFF_COLLISION *collisionData)
{
    objCollisionData = collisionData;
}

s32 ObjDiffCollisionFast(OBS_COL_CHK_DATA *colWork)
{
    u16 dir;
    u32 attr;
    s32 lCol;
    s8 sPix;
    s8 delta = 8;

    if (objCollisionData->diffCollision == NULL)
    {
        s32 dist;

        switch (colWork->vec)
        {
            case OBD_COL_DOWN:
                dist = objCollisionData->bottom - colWork->y;
                break;

            case OBD_COL_UP:
                dist = colWork->y - objCollisionData->top;
                break;

            case OBD_COL_LEFT:
                dist = colWork->x - objCollisionData->left;
                break;

            case OBD_COL_RIGHT:
                dist = objCollisionData->right - colWork->x;
                break;
        }

        return MTM_MATH_CLIP(dist, -31, 31);
    }

    if (colWork->dir != NULL)
        dir = *colWork->dir;

    if (colWork->attr != NULL)
        attr = *colWork->attr;

    if ((colWork->vec & OBD_COL_MINUS) != 0)
        delta = -8;

    if ((colWork->vec & OBD_COL_Y) != 0)
    {
        lCol = objGetMapColDataY(colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);
        sPix = colWork->y & 7;
    }
    else
    {
        lCol = objGetMapColDataX(colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);
        sPix = colWork->x & 7;
    }

    if (lCol == 0)
    {
        if (colWork->dir != NULL)
            *colWork->dir = dir;

        if (colWork->attr != NULL)
            *colWork->attr = attr;

        return objMapGetForward(sPix, delta);
    }
    else
    {
        if (lCol == 8)
        {
            return objMapGetBack(sPix, delta);
        }
        else
        {
            return objMapGetDiff(lCol, sPix, delta);
        }
    }
}

s32 ObjDiffCollision(OBS_COL_CHK_DATA *colWork)
{
    s32 lCol;
    s32 stepX = 0;
    s32 stepY = 0;
    s8 sPix;
    u16 dir;
    u32 attr;
    s8 deltaX = 0;
    s8 deltaY = 0;
    s32 (*objGetMapColData)(fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);

    if (objCollisionData->diffCollision == NULL)
    {
        switch (colWork->vec)
        {
            case OBD_COL_DOWN:
                lCol = objCollisionData->bottom - colWork->y;
                break;

            case OBD_COL_UP:
                lCol = colWork->y - objCollisionData->top;
                break;

            case OBD_COL_LEFT:
                lCol = colWork->x - objCollisionData->left;
                break;

            case OBD_COL_RIGHT:
                lCol = objCollisionData->right - colWork->x;
                break;
        }
        return MTM_MATH_CLIP(lCol, -31, 31);
    }

    if (colWork->dir)
        dir = *colWork->dir;

    if (colWork->attr)
        attr = *colWork->attr;

    if (colWork->vec & OBD_COL_Y)
    {
        deltaY = 8;
        if (colWork->vec & OBD_COL_MINUS)
            deltaY = -8;
    }
    else
    {
        deltaX = 8;
        if (colWork->vec & OBD_COL_MINUS)
            deltaX = -8;
    }

    if (colWork->vec & OBD_COL_Y)
    {
        sPix             = (s8)(colWork->y & 7);
        objGetMapColData = objGetMapColDataY;
    }
    else
    {
        sPix             = (s8)(colWork->x & 7);
        objGetMapColData = objGetMapColDataX;
    }

    lCol = objGetMapColData(colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);

    if (lCol == 0)
    {
        stepX += deltaX;
        stepY += deltaY;

        lCol = objGetMapColData(colWork->x + stepX, colWork->y + stepY, colWork->flag, colWork->dir, colWork->attr);

        if (lCol == 0)
        {
            stepX += deltaX;
            stepY += deltaY;

            lCol = objGetMapColData(colWork->x + stepX, colWork->y + stepY, colWork->flag, colWork->dir, colWork->attr);

            if (lCol == 0)
            {
                if (colWork->dir)
                    *colWork->dir = dir;
                if (colWork->attr)
                    *colWork->attr = attr;
                return objMapGetForward(sPix, (s8)(deltaX + deltaY)) + 16;
            }
            else if (lCol == 8)
            {
                return objMapGetBack(sPix, (s8)(deltaX + deltaY)) + 16;
            }
            else
            {
                return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) + 16;
            }
        }
        else if (lCol == 8)
        {
            return objMapGetBack(sPix, (s8)(deltaX + deltaY)) + 8;
        }
        else
        {
            return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) + 8;
        }
    }
    else if (lCol == 8)
    {
        if (colWork->dir != NULL)
            dir = *colWork->dir;

        if (colWork->attr != NULL)
            attr = *colWork->attr;

        stepX -= deltaX;
        stepY -= deltaY;

        lCol = objGetMapColData(colWork->x + stepX, colWork->y + stepY, colWork->flag, colWork->dir, colWork->attr);

        if (lCol == 8)
        {
            if (colWork->dir != NULL)
                dir = *colWork->dir;

            if (colWork->attr != NULL)
                attr = *colWork->attr;

            stepX -= deltaX;
            stepY -= deltaY;

            lCol = objGetMapColData(colWork->x + stepX, colWork->y + stepY, colWork->flag, colWork->dir, colWork->attr);

            if (lCol == 0)
            {
                if (colWork->dir != NULL)
                    *colWork->dir = dir;

                if (colWork->attr != NULL)
                    *colWork->attr = attr;

                return objMapGetForwardRev(sPix, (s8)(deltaX + deltaY)) - 16;
            }
            else if (lCol == 8)
            {
                return objMapGetBack(sPix, (s8)(deltaX + deltaY)) - 16;
            }
            else
            {
                return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) - 16;
            }
        }
        else if (lCol == 0)
        {
            if (colWork->dir != NULL)
                *colWork->dir = dir;

            if (colWork->attr != NULL)
                *colWork->attr = attr;

            return objMapGetForwardRev(sPix, (s8)(deltaX + deltaY)) - 8;
        }
        else
        {
            return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) - 8;
        }
    }
    else
    {
        return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY));
    }
}

u32 objGetMapBlockData(s32 x, s32 y, u8 plane)
{
    s32 tileX = x >> 3;
    s32 tileY = y >> 3;

    s32 blockTileX, blockTileY;
    s32 blockX, blockY;

    u32 blockIndex;
    u32 tileID;

    blockX = tileX / TILE_BLOCK_TILE_COUNT_X;
    blockY = tileY / TILE_BLOCK_TILE_COUNT_Y;

    blockTileX = tileX - (TILE_BLOCK_TILE_COUNT_X * blockX);
    blockTileY = tileY - (TILE_BLOCK_TILE_COUNT_Y * blockY);

    blockIndex = *(objCollisionData->mapLayout[plane] + (objCollisionData->blockWidth * blockY + blockX));

    tileID = (u32)((blockTileY * TILE_BLOCK_TILE_COUNT_X) + blockTileX);

    return *(u16 *)((u32)objCollisionData->mapBlockset + ((blockIndex * TILE_SIZE_X * TILE_SIZE_Y * sizeof(u16)) + (tileID << 1)));
}

s32 objGetMapColDataX(fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    s32 tilePenetration;
    s8 cCol;
    u16 tileID;
    u16 blockTile;

    if (flags & OBJ_COL_FLAG_LIMIT_MAP_BOUNDS)
    {
        if ((posX & ~7) > (objCollisionData->right - 1) || posX < (objCollisionData->left - 7))
        {
            cCol = 8;
            return cCol;
        }

        if (((posX & ~7) + 0x8) > (objCollisionData->right - 1))
        {
            cCol = (s8)((objCollisionData->right - 1) & 0x7);
            if (cCol == 0)
                cCol = 8;

            return cCol;
        }

        if ((posX & ~7) < objCollisionData->left)
        {
            if (objCollisionData->left & 0x7)
                cCol = (s8)(0x8 + (0x8 - (objCollisionData->left & 0x7)));
            else
                cCol = 8;

            cCol |= ~0x0F;

            if (cCol == -8)
                cCol = 8;

            return cCol;
        }

        if (posY > (objCollisionData->bottom - 1) || posY < objCollisionData->top)
        {
            cCol = 8;
            return cCol;
        }
    }
    else
    {
        posX = MTM_MATH_CLIP_3(posX, objCollisionData->left, objCollisionData->right - 1);
        posY = MTM_MATH_CLIP_3(posY, objCollisionData->top, objCollisionData->bottom - 1);
    }

    blockTile = (u16)objGetMapBlockData(posX, posY, (u8)(flags & OBJ_COL_FLAG_USE_PLANE_B));
    tileID    = (u16)(blockTile & TILE_CHAR_NO_MASK);

    tilePenetration = posY & 7;

    if (blockTile & TILE_FLIP_Y_MASK)
        tilePenetration = 7 - tilePenetration;

    cCol = objCollisionData->diffCollision[(tileID << 3) + tilePenetration];
    cCol &= 0x0F;

    if (cCol & 0x08)
        cCol |= ~0x0F;

    if (cCol == -8)
        cCol = 8;

    if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && (objGetAttrData(tileID) & OBJ_COL_ATTR_TOP_SOLID) != 0)
        cCol = 0;

    if ((blockTile & TILE_FLIP_X_MASK))
    {
        if (!(cCol == 8 || cCol == 0))
        {
            if (cCol > 0)
            {
                cCol -= 8;
            }
            else
            {
                cCol += 8;
            }
        }
    }

    if (pDir != NULL && cCol != 0)
    {
        u16 dir;

        dir = (u16)(*(objCollisionData->dirCollision + tileID) << 8);
        if (blockTile & TILE_FLIP_Y_MASK)
        {
            dir = (u16)(-((s16)dir + 0x4000) - 0x4000);
        }

        if ((blockTile & TILE_FLIP_X_MASK))
        {
            if (cCol != 0)
                dir = (u16)(-(s16)dir);
        }

        *pDir = dir;
    }

    if (pAttr != NULL && cCol != 0)
        *pAttr = objGetAttrData(tileID);

    return cCol;
}

s32 objGetMapColDataY(fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    s32 tilePenetration;
    s8 cCol;
    u16 tileID;
    u16 blockTile;

    if (flags & OBJ_COL_FLAG_LIMIT_MAP_BOUNDS)
    {
        if ((posY & ~7) > (objCollisionData->bottom - 1) || posY < (objCollisionData->top - 7))
        {
            cCol = 8;
            return cCol;
        }

        if (((posY & ~7) + 0x8) > (objCollisionData->bottom - 1))
        {
            cCol = (s8)((objCollisionData->bottom - 1) & 0x7);
            if (cCol == 0)
                cCol = 8;

            return cCol;
        }

        if ((posY & ~7) < objCollisionData->top)
        {
            if (objCollisionData->top & 0x7)
                cCol = (s8)(0x8 + (0x8 - (objCollisionData->top & 0x7)));
            else
                cCol = 8;

            cCol |= ~0x0F;

            if (cCol == -8)
                cCol = 8;

            return cCol;
        }

        if (posX > (objCollisionData->right - 1) || posX < objCollisionData->left)
        {
            cCol = 8;
            return cCol;
        }
    }
    else
    {
        posX = MTM_MATH_CLIP_3(posX, objCollisionData->left, objCollisionData->right - 1);
        posY = MTM_MATH_CLIP_3(posY, objCollisionData->top, objCollisionData->bottom - 1);
    }

    blockTile = (u16)objGetMapBlockData(posX, posY, (u8)(flags & OBJ_COL_FLAG_USE_PLANE_B));
    tileID    = (u16)(blockTile & TILE_CHAR_NO_MASK);

    tilePenetration = posX & 7;

    if (blockTile & TILE_FLIP_X_MASK)
        tilePenetration = 7 - tilePenetration;

    cCol = objCollisionData->diffCollision[(tileID << 3) + tilePenetration];
    cCol >>= 4;

    if (cCol & 0x08)
        cCol |= ~0x0F;

    if (cCol == -8)
        cCol = 8;

    if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && (objGetAttrData(tileID) & OBJ_COL_ATTR_TOP_SOLID) != 0)
        cCol = 0;

    if ((blockTile & TILE_FLIP_Y_MASK))
    {
        if (!(cCol == 8 || cCol == 0))
        {
            if (cCol > 0)
            {
                cCol -= 8;
            }
            else
            {
                cCol += 8;
            }
        }
    }

    if (pDir != NULL && cCol != 0)
    {
        u16 dir;

        dir = (u16)(*(objCollisionData->dirCollision + tileID) << 8);
        if (blockTile & TILE_FLIP_X_MASK)
        {
            dir = (u16)(-(s16)dir);
        }

        if ((blockTile & TILE_FLIP_Y_MASK))
        {
            if (cCol != 0)
                dir = (u16)(-((s16)dir + 0x4000) - 0x4000);
        }

        *pDir = dir;
    }

    if (pAttr != NULL && cCol != 0)
        *pAttr = objGetAttrData(tileID);

    return cCol;
}

void ObjCollisionObjectRegist(StageTaskCollisionObj *work)
{
    if (objCollisionCount.nextCount < OBJ_COLLISION_REGISTRATION_MAX)
    {
        StageTask *parent = work->parent;
        if (parent == NULL || !IsStageTaskDestroyedAny(parent))
        {
            if ((work->riderObj != NULL && work->riderObj->rideObj != work->parent))
                work->riderObj = NULL;

            if (work->toucherObj != NULL && work->toucherObj->touchObj != work->parent)
                work->toucherObj = NULL;

            objNextCollisionTable[objCollisionCount.nextCount] = work;
            objCollisionCount.nextCount++;

            VecFx32 position = { 0, 0, 0 };
            position         = work->pos;
            if (work->parent != NULL && (work->flag & STAGE_TASK_OBJCOLLISION_FLAG_IGNORE_PARENT_POS) == 0)
            {
                position.x += work->parent->position.x;
                position.y += work->parent->position.y;
                position.z += work->parent->position.z;
            }
            work->check_pos = position;

            work->flag &= ~(STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X | STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y);
            if (work->parent != NULL)
            {
                if ((work->parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X;

                if ((work->parent->displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y;
            }
            else
            {
                if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_FLIP_X) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X;

                if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_FLIP_Y) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y;
            }

            objCollsionOffsetSet(work, &work->check_ofst.x, &work->check_ofst.y);

            work->left   = FX32_TO_WHOLE(work->check_pos.x) + work->check_ofst.x;
            work->top    = FX32_TO_WHOLE(work->check_pos.y) + work->check_ofst.y;
            work->right  = FX32_TO_WHOLE(work->check_pos.x) + work->width + work->check_ofst.x;
            work->bottom = FX32_TO_WHOLE(work->check_pos.y) + work->height + work->check_ofst.y;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_DISABLE_ANGLES) == 0)
                work->check_dir = work->dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_IGNORE_PARENT_ANGLE) == 0)
            {
                if (work->parent != NULL)
                    work->check_dir += work->parent->dir.z + work->parent->fallDir;
            }
        }
    }
}

void ObjCollisionObjectClear(void)
{
    u16 i;

    for (i = 0; i < objCollisionCount.nextCount; i++)
    {
        objCollisionTable[i] = objNextCollisionTable[i];
    }

    for (; i < OBJ_COLLISION_REGISTRATION_MAX; i++)
    {
        objNextCollisionTable[i] = NULL;
    }

    objCollisionCount.curCount     = objCollisionCount.nextCount;
    objCollisionCount.nextCount = 0;
}

void objCollsionOffsetSet(StageTaskCollisionObj *work, s16 *offsetX, s16 *offsetY)
{
    *offsetX = work->ofst_x;
    *offsetY = work->ofst_y;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
        *offsetX = (s16)(-work->ofst_x - work->width);

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
        *offsetY = (s16)(-work->ofst_y - work->height);
}

s32 ObjCollisionObjectFastCheckDet(fx32 x, fx32 y, u16 flag, ObjCollisionVec vec, u16 *dir, u32 *attr)
{
    OBS_COL_CHK_DATA colWork;

    colWork.x    = x;
    colWork.y    = y;
    colWork.dir  = dir;
    colWork.attr = attr;
    colWork.flag = flag;
    colWork.vec  = vec;
    return ObjCollisionObjectFastCheck(&colWork);
}

s32 ObjCollisionObjectFastCheck(OBS_COL_CHK_DATA *colWork)
{
    u16 index;
    fx32 x          = colWork->x;
    fx32 y          = colWork->y;
    s32 penetration = 24;

    OBS_COL_CHK_DATA colWorkCopy;
    MI_CpuCopy8(colWork, &colWorkCopy, sizeof(colWorkCopy));

    if (objCollisionCount.curCount == 0)
        return penetration;

    for (index = 0; index < objCollisionCount.curCount; ++index)
    {
        StageTaskCollisionObj *collisionWork = objCollisionTable[index];

        if (collisionWork->parent != NULL && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_DISABLED) == 0)
        {
            colWorkCopy.x = colWork->x;
            colWorkCopy.y = colWork->y;
            if ((collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_ROTATE_USING_TILE_ANGLE) != 0 && collisionWork->check_dir != FLOAT_DEG_TO_IDX(0.0))
            {
                MtxFx33 matRot;
                VecFx32 rotPos;
                VEC_Set(&rotPos, FX32_FROM_WHOLE(colWorkCopy.x) - collisionWork->check_pos.x, FX32_FROM_WHOLE(colWorkCopy.y) - collisionWork->check_pos.y, 0);

                MTX_RotZ33(&matRot, SinFX((s32)(u16)-collisionWork->check_dir), CosFX((s32)(u16)-collisionWork->check_dir));
                MTX_MultVec33(&rotPos, &matRot, &rotPos);
                colWorkCopy.x = FX32_TO_WHOLE(rotPos.x + collisionWork->check_pos.x);
                colWorkCopy.y = FX32_TO_WHOLE(rotPos.y + collisionWork->check_pos.y);
            }

            s32 objPenetration;
            if (collisionWork->diff_data != NULL)
            {
                objPenetration = objFastCollisionDiffObject(collisionWork, &colWorkCopy);
                if (objPenetration == 0)
                {
                    switch (colWork->vec)
                    {
                        case OBD_COL_LEFT:
                            if (collisionWork->parent->move.x > 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;

                        case OBD_COL_RIGHT:
                            if (collisionWork->parent->move.x < 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;
                    }
                }
            }
            else
            {
                switch (colWork->vec)
                {
                    case OBD_COL_DOWN:
                        objPenetration = collisionWork->top - y;
                        break;

                    case OBD_COL_UP:
                        objPenetration = y - collisionWork->bottom;
                        break;

                    case OBD_COL_LEFT:
                        objPenetration = x - collisionWork->right;
                        if (objPenetration == 0 && collisionWork->parent->move.x > 0)
                        {
                            objPenetration--;
                            break;
                        }
                        break;

                    case OBD_COL_RIGHT:
                        objPenetration = collisionWork->left - x;
                        if (objPenetration == 0 && collisionWork->parent->move.x < 0)
                        {
                            objPenetration--;
                            break;
                        }
                        break;
                }

                objPenetration = MTM_MATH_CLIP(objPenetration, -31, 31);
            }

            if (penetration > objPenetration)
                penetration = objPenetration;
        }
    }

    return penetration;
}

s32 ObjCollisionObjectCheck(StageTask *work, OBS_COL_CHK_DATA *colWork)
{
    s32 penetration = 24;
    s16 touchDist   = 0;
    u16 isRiding    = FALSE;

    OBS_COL_CHK_DATA colWorkCopy;
    MI_CpuCopy8(colWork, &colWorkCopy, sizeof(colWorkCopy));

    if (objCollisionCount.curCount == 0)
        return penetration;

    u16 angle;
    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
    {
        angle = work->fallDir;
    }
    else
    {
        touchDist = 1;
        angle     = work->fallDir + work->dir.z;
    }

    switch (((angle + FLOAT_DEG_TO_IDX(45.0)) & 0xC000) >> 14)
    {
        default:
            // case 0:
            if (colWork->vec == OBD_COL_DOWN && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.y >= 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 1:
            if (colWork->vec == OBD_COL_LEFT && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.x < 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 2:
            if (colWork->vec == OBD_COL_UP && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.y < 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 3:
            if (colWork->vec == OBD_COL_RIGHT && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.x > 0))
            {
                isRiding = TRUE;
                break;
            }
            break;
    }

    for (u16 index = 0; index < objCollisionCount.curCount; ++index)
    {
        StageTaskCollisionObj *collisionWork = objCollisionTable[index];

        if (collisionWork->parent != work && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_DISABLED) == 0)
        {
            colWorkCopy.x = colWork->x;
            colWorkCopy.y = colWork->y;
            if ((collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_ROTATE_USING_TILE_ANGLE) != 0 && collisionWork->check_dir != FLOAT_DEG_TO_IDX(0.0))
            {
                MtxFx33 matRot;
                VecFx32 rotPos;
                VEC_Set(&rotPos, FX32_FROM_WHOLE(colWorkCopy.x) - collisionWork->check_pos.x, FX32_FROM_WHOLE(colWorkCopy.y) - collisionWork->check_pos.y, 0);

                MTX_RotZ33(&matRot, SinFX((s32)(u16)-collisionWork->check_dir), CosFX((s32)(u16)-collisionWork->check_dir));
                MTX_MultVec33(&rotPos, &matRot, &rotPos);
                colWorkCopy.x = FX32_TO_WHOLE(rotPos.x + collisionWork->check_pos.x);
                colWorkCopy.y = FX32_TO_WHOLE(rotPos.y + collisionWork->check_pos.y);
            }

            s32 objPenetration;
            if (collisionWork->diff_data != NULL)
            {
                objPenetration = objCollisionDiffObject(collisionWork, &colWorkCopy);
                if (objPenetration == 0)
                {
                    switch (colWork->vec)
                    {
                        case OBD_COL_LEFT:
                            if (collisionWork->parent != NULL && collisionWork->parent->move.x > 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;

                        case OBD_COL_RIGHT:
                            if (collisionWork->parent != NULL && collisionWork->parent->move.x < 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;
                    }
                }
            }
            else
            {
                s32 distance = 24;
                switch (colWork->vec)
                {
                    case OBD_COL_DOWN:
                        if (colWorkCopy.y < collisionWork->bottom && colWorkCopy.x > collisionWork->left && colWorkCopy.x < collisionWork->right)
                        {
                            distance = collisionWork->top - colWorkCopy.y;
                            break;
                        }
                        break;

                    case OBD_COL_UP:
                        if (collisionWork->top < colWorkCopy.y && colWorkCopy.x > collisionWork->left && colWorkCopy.x < collisionWork->right)
                        {
                            distance = colWorkCopy.y - collisionWork->bottom;
                            break;
                        }
                        break;

                    case OBD_COL_LEFT:
                        if (collisionWork->left < colWorkCopy.x && colWorkCopy.y > collisionWork->top && colWorkCopy.y < collisionWork->bottom)
                        {
                            distance = colWorkCopy.x - collisionWork->right;
                            if (distance == 0 && collisionWork->parent != NULL && collisionWork->parent->move.x > 0)
                            {
                                distance--;
                                break;
                            }
                            break;
                        }
                        break;

                    case OBD_COL_RIGHT:
                        if (colWorkCopy.x < collisionWork->right && colWorkCopy.y > collisionWork->top && colWorkCopy.y < collisionWork->bottom)
                        {
                            distance = collisionWork->left - colWorkCopy.x;
                            if (distance == 0 && collisionWork->parent != NULL && collisionWork->parent->move.x < 0)
                            {
                                distance--;
                                break;
                            }
                            break;
                        }
                        break;
                }

                objPenetration = MTM_MATH_CLIP(distance, -31, 31);
            }

            if (penetration > objPenetration)
            {
                penetration = objPenetration;
                if (penetration <= touchDist)
                {
                    work->touchObj            = collisionWork->parent;
                    collisionWork->toucherObj = work;
                }

                if (penetration <= touchDist && isRiding != FALSE)
                {
                    work->rideObj           = collisionWork->parent;
                    collisionWork->riderObj = work;

                    if (colWork->dir != NULL)
                        *colWork->dir += collisionWork->check_dir;

                    if (colWork->attr != NULL && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_DISABLE_ATTRIBUTES) == 0)
                        *colWork->attr |= (u8)collisionWork->attr;
                }
            }
        }
    }

    return penetration;
}

s32 objFastCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork)
{
    u16 dir;
    u32 attr;
    s8 sPix;
    s32 lCol;
    s8 delta = 8;

    if (colWork->dir != NULL)
        dir = *colWork->dir;

    if (colWork->attr != NULL)
        attr = *colWork->attr;

    if ((colWork->vec & OBD_COL_MINUS) != 0)
        delta = -8;

    if ((colWork->vec & OBD_COL_Y) != 0)
    {
        lCol = objGetColDataY(work, colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);
        sPix = (colWork->y - work->top) & 7;
    }
    else
    {
        lCol = objGetColDataX(work, colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);
        sPix = (colWork->x - work->left) & 7;
    }

    if (lCol == 0)
    {
        if (colWork->dir != NULL)
            *colWork->dir = dir;

        if (colWork->attr != NULL)
            *colWork->attr = attr;

        return objMapGetForward(sPix, delta);
    }
    else
    {
        if (lCol == 8)
        {
            return objMapGetBack(sPix, delta);
        }
        else
        {
            return objMapGetDiff(lCol, sPix, delta);
        }
    }
}

s32 objCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork)
{
    s32 lCol;
    s32 moveX = 0;
    s32 moveY = 0;
    u32 attr;
    s32 (*objGetColData)(StageTaskCollisionObj *work, fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
    u16 dir;
    s8 deltaX = 0;
    s8 deltaY = 0;
    s8 sPix;

    if (colWork->dir)
        dir = *colWork->dir;

    if (colWork->attr)
        attr = *colWork->attr;

    if (colWork->vec & OBD_COL_Y)
    {
        deltaY = 8;
        if (colWork->vec & OBD_COL_MINUS)
            deltaY = -8;
    }
    else
    {
        deltaX = 8;
        if (colWork->vec & OBD_COL_MINUS)
            deltaX = -8;
    }

    if (colWork->vec & OBD_COL_Y)
    {
        sPix          = (s8)((colWork->y - work->top) & 7);
        objGetColData = objGetColDataY;
    }
    else
    {
        sPix          = (s8)((colWork->x - work->left) & 7);
        objGetColData = objGetColDataX;
    }

    lCol = objGetColData(work, colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);

    if (lCol == 0)
    {
        moveX += deltaX;
        moveY += deltaY;

        lCol = objGetColData(work, colWork->x + moveX, colWork->y + moveY, colWork->flag, colWork->dir, colWork->attr);

        if (lCol == 0)
        {
            moveX += deltaX;
            moveY += deltaY;

            lCol = objGetColData(work, colWork->x + moveX, colWork->y + moveY, colWork->flag, colWork->dir, colWork->attr);

            if (lCol == 0)
            {
                if (colWork->dir != NULL)
                    *colWork->dir = dir;

                if (colWork->attr != NULL)
                    *colWork->attr = attr;

                return objMapGetForward(sPix, (s8)(deltaX + deltaY)) + 16;
            }
            else if (lCol == 8)
            {
                return objMapGetBack(sPix, (s8)(deltaX + deltaY)) + 16;
            }
            else
            {
                return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) + 16;
            }
        }
        else if (lCol == 8)
        {
            return objMapGetBack(sPix, (s8)(deltaX + deltaY)) + 8;
        }
        else
        {
            return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) + 8;
        }
    }
    else if (lCol == 8)
    {
        if (colWork->dir != NULL)
            dir = *colWork->dir;

        if (colWork->attr != NULL)
            attr = *colWork->attr;

        moveX -= deltaX;
        moveY -= deltaY;

        lCol = objGetColData(work, colWork->x + moveX, colWork->y + moveY, colWork->flag, colWork->dir, colWork->attr);

        if (lCol == 8)
        {
            if (colWork->dir != NULL)
                dir = *colWork->dir;

            if (colWork->attr != NULL)
                attr = *colWork->attr;

            moveX -= deltaX;
            moveY -= deltaY;

            lCol = objGetColData(work, colWork->x + moveX, colWork->y + moveY, colWork->flag, colWork->dir, colWork->attr);

            if (lCol == 0)
            {
                if (colWork->dir != NULL)
                    *colWork->dir = dir;

                if (colWork->attr != NULL)
                    *colWork->attr = attr;

                return objMapGetForwardRev(sPix, (s8)(deltaX + deltaY)) - 16;
            }
            else if (lCol == 8)
            {
                return objMapGetBack(sPix, (s8)(deltaX + deltaY)) - 16;
            }
            else
            {
                return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) - 16;
            }
        }
        else if (lCol == 0)
        {
            if (colWork->dir != NULL)
                *colWork->dir = dir;
            if (colWork->attr != NULL)
                *colWork->attr = attr;

            return objMapGetForwardRev(sPix, (s8)(deltaX + deltaY)) - 8;
        }
        else
        {
            return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY)) - 8;
        }
    }
    else
    {
        return objMapGetDiff(lCol, sPix, (s8)(deltaX + deltaY));
    }
}

s32 objGetColDataX(StageTaskCollisionObj *work, fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    u16 tile;
    s32 depth;
    s8 penetration;
    u16 x;
    u16 y;

    if (posX < work->left || posX >= work->right)
        return 0;

    if (posY < work->top || posY >= work->bottom)
        return 0;

    x = (posX - work->left) >> 3;
    y = (posY - work->top) >> 3;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
        x = (work->width >> 3) - 1 - x;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
        y = (work->height >> 3) - 1 - y;

    tile = x + y * (work->width >> 3);

    depth = (posY - work->top) & 7;
    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
        depth = 7 - depth;

    penetration = ((s8)work->diff_data[(tile << 3) + depth] & 15);
    if ((penetration & 8) != 0)
        penetration |= -16;

    if (penetration == -8)
        penetration = 8;

    if (work->attr_data != NULL)
    {
        if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && ((work->attr_data[tile >> 3] & OBJ_COL_ATTR_TOP_SOLID) != 0 || (work->attr & OBJ_COL_ATTR_TOP_SOLID) != 0))
            penetration = 0;
    }
    else
    {
        if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && (work->attr & OBJ_COL_ATTR_TOP_SOLID) != 0)
            penetration = 0;
    }

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0 && penetration != 8 && penetration != 0)
    {
        if (penetration > 0)
            penetration -= 8;
        else
            penetration += 8;
    }

    if (pDir != NULL && penetration != 0)
    {
        u16 dir;
        if (work->dir_data != NULL)
            dir = work->dir_data[tile] << 8;
        else
            dir = FLOAT_DEG_TO_IDX(0.0);

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_ROTATE_USING_TILE_ANGLE) != 0)
            dir += work->check_dir;

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_FLIP_TILE_ANGLE) != 0)
        {
            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
                dir = -(s16)dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
                dir = (-((s16)dir + (s16)FLOAT_DEG_TO_IDX(90.0)) - (s16)FLOAT_DEG_TO_IDX(90.0));
        }

        *pDir = dir;
    }

    if (pAttr != NULL && penetration != 0)
    {
        if (work->attr_data != NULL)
            *pAttr = work->attr_data[tile >> 3] | work->attr;
        else
            *pAttr = work->attr;
    }

    return penetration;
}

s32 objGetColDataY(StageTaskCollisionObj *work, fx32 posX, fx32 posY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    u16 tile;
    s32 depth;
    s8 penetration;
    u16 x;
    u16 y;

    if (posX < work->left || posX >= work->right)
        return 0;

    if (posY < work->top || posY >= work->bottom)
        return 0;

    x = (posX - work->left) >> 3;
    y = (posY - work->top) >> 3;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
        x = (work->width >> 3) - 1 - x;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
        y = (work->height >> 3) - 1 - y;

    tile = x + y * (work->width >> 3);

    depth = (posX - work->left) & 7;
    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
        depth = 7 - depth;

    penetration = ((s32)(s8)((s8)work->diff_data[(tile << 3) + depth] >> 4));
    if ((penetration & 8) != 0)
        penetration |= -16;

    if (penetration == -8)
        penetration = 8;

    if (work->attr_data != NULL)
    {
        if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && ((work->attr_data[tile >> 3] & OBJ_COL_ATTR_TOP_SOLID) != 0 || (work->attr & OBJ_COL_ATTR_TOP_SOLID) != 0))
            penetration = 0;
    }
    else
    {
        if ((flags & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0 && (work->attr & OBJ_COL_ATTR_TOP_SOLID) != 0)
            penetration = 0;
    }

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0 && penetration != 8 && penetration != 0)
    {
        if (penetration > 0)
            penetration -= 8;
        else
            penetration += 8;
    }

    if (pDir != NULL && penetration != 0)
    {
        u16 dir;
        if (work->dir_data != NULL)
            dir = work->dir_data[tile] << 8;
        else
            dir = FLOAT_DEG_TO_IDX(0.0);

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_ROTATE_USING_TILE_ANGLE) != 0)
            dir += work->check_dir;

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_FLIP_TILE_ANGLE) != 0)
        {
            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X) != 0)
                dir = -(s16)dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y) != 0)
                dir = (-((s16)dir + (s16)FLOAT_DEG_TO_IDX(90.0)) - (s16)FLOAT_DEG_TO_IDX(90.0));
        }

        *pDir = dir;
    }

    if (pAttr != NULL && penetration != 0)
    {
        if (work->attr_data != NULL)
            *pAttr = work->attr_data[tile >> 3] | work->attr;
        else
            *pAttr = work->attr;
    }

    return penetration;
}

#include <nitro/itcm_end.h>
