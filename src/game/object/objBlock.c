#include <game/object/objBlock.h>
#include <game/math/mtMath.h>

// --------------------
// TYPES
// --------------------

typedef s32 (*ObjBlockColFunc)(OBS_COL_CHK_DATA *work);

// --------------------
// FUNCTIONS DECLS
// --------------------

static s32 objGetBlockColData(OBS_COL_CHK_DATA *work);
static s32 objBlockColLimit(OBS_COL_CHK_DATA *work);
static s32 objBlockCalcEmpty(OBS_COL_CHK_DATA *work);
static s32 objBlockCalcFill(OBS_COL_CHK_DATA *work);
static s32 objBlockColEmpty(OBS_COL_CHK_DATA *work);
static s32 objBlockColBlockFill(OBS_COL_CHK_DATA *work);
static s32 objBlockColBlockFillThrough(OBS_COL_CHK_DATA *work);

// --------------------
// VARIABLES
// --------------------

static const ObjBlockColFunc sObjBlockCollisionTable[] = { objBlockColEmpty, objBlockColBlockFill, objBlockColBlockFillThrough };

static const OBS_BLOCK_COLLISION *sObjCollisionData = NULL;

// --------------------
// FUNCTIONS
// --------------------

void ObjSetBlockCollision(OBS_BLOCK_COLLISION *collisionData)
{
    sObjCollisionData = collisionData;
}

s32 ObjBlockCollision(OBS_COL_CHK_DATA *work)
{
    s16 offsetX = 0;
    s16 offsetY = 0;

    if (sObjCollisionData->pData[0] == NULL)
    {
        s32 dist;

        switch (work->vec)
        {
            case OBD_COL_DOWN:
                dist = sObjCollisionData->bottom - work->y;
                break;

            case OBD_COL_UP:
                dist = work->y - sObjCollisionData->top;
                break;

            case OBD_COL_RIGHT:
                dist = sObjCollisionData->right - work->x;
                break;

            case OBD_COL_LEFT:
                dist = work->x - sObjCollisionData->left;
                break;
        }

        return MTM_MATH_CLIP(dist, -31, 31);
    }

    s32 block = objGetBlockColData(work);
    if ((work->vec & OBD_COL_Y) != 0)
    {
        s16 offset = (work->y & 15);
        s16 distance;

        if ((work->vec & OBD_COL_MINUS) != 0)
            distance = (offset - block);
        else
            distance = (offset + block);

        if (distance == 0)
        {
            offsetY = -OBJ_BLOCK_SIZE;
        }
        else if (distance == 15)
        {
            offsetY = OBJ_BLOCK_SIZE;
        }
    }
    else
    {
        s16 offset = (work->x & 15);
        s16 distance;

        if ((work->vec & OBD_COL_MINUS) != 0)
            distance = (offset - block);
        else
            distance = (offset + block);

        if (distance == 0)
        {
            offsetX = -OBJ_BLOCK_SIZE;
        }
        else if (distance == 15)
        {
            offsetX = OBJ_BLOCK_SIZE;
        }
    }

    if (offsetX != 0 || offsetY != 0)
    {
        u32 attr;
        u16 dir;

        if (work->dir != NULL)
            dir = *work->dir;

        if (work->attr != NULL)
            attr = *work->attr;

        work->x += offsetX;
        work->y += offsetY;
        s32 blockColData = objGetBlockColData(work);
        work->x -= offsetX;
        work->y -= offsetY;

        if (blockColData >= 0)
        {
            if (work->dir != NULL)
                *work->dir = dir;

            if (work->attr != NULL)
                *work->attr = attr;
        }

        if (offsetX < 0)
            offsetX++;

        if (offsetX > 0)
            offsetX--;

        if (offsetY < 0)
            offsetY++;

        if (offsetY > 0)
            offsetY--;

        block = (work->vec & OBD_COL_MINUS) != 0 ? blockColData - (offsetX + offsetY) : blockColData + (offsetX + offsetY);
    }

    return block;
}

s32 objGetBlockColData(OBS_COL_CHK_DATA *work)
{
    s32 x;
    s32 y;

    if ((work->flag & OBJ_COL_FLAG_LIMIT_MAP_BOUNDS) != 0)
    {
        s32 limit = objBlockColLimit(work);
        if (limit < 0)
            return limit;

        // falls through to id calculation without setting x or y???
    }
    else
    {
        x = sObjCollisionData->left;
        if (work->x >= x)
        {
            x = sObjCollisionData->right - 1;
            if (work->x <= x)
                x = work->x;
        }

        y = sObjCollisionData->top;
        if (work->y >= y)
        {
            y = sObjCollisionData->bottom - 1;
            if (work->y <= y)
                y = work->y;
        }
    }

    u32 id    = (y >> 4) * sObjCollisionData->width + (x >> 4);
    u8 funcID = sObjCollisionData->pData[work->flag & OBJ_COL_FLAG_USE_PLANE_B][id];

    return sObjBlockCollisionTable[funcID](work);
}

s32 objBlockColLimit(OBS_COL_CHK_DATA *work)
{
    switch (work->vec)
    {
        case OBD_COL_DOWN:
            if (sObjCollisionData->bottom - 1 < work->y)
                return sObjCollisionData->bottom - 1 - work->y;
            // fall through

        case OBD_COL_UP:
            if (sObjCollisionData->top > work->y)
                return work->y - sObjCollisionData->top;
            // fall through

        case OBD_COL_RIGHT:
            if (sObjCollisionData->right - 1 < work->x)
                return sObjCollisionData->right - 1 - work->x;
            // fall through

        case OBD_COL_LEFT:
            if (sObjCollisionData->left > work->x)
                return work->x - sObjCollisionData->left;
            break;
    }

    return 1;
}

s32 objBlockCalcEmpty(OBS_COL_CHK_DATA *work)
{
    switch (work->vec)
    {
        case OBD_COL_DOWN:
            return 15 - (work->y & 15);

        case OBD_COL_UP:
            return work->y & 15;

        case OBD_COL_RIGHT:
            return 15 - (work->x & 15);

        case OBD_COL_LEFT:
            return work->x & 15;

        default:
            return 15;
    }
}

s32 objBlockCalcFill(OBS_COL_CHK_DATA *work)
{
    switch (work->vec)
    {
        case OBD_COL_DOWN:
            return -(work->y & 15);

        case OBD_COL_UP:
            return -(15 - (work->y & 15));

        case OBD_COL_RIGHT:
            return -(work->x & 15);

        case OBD_COL_LEFT:
            return -(15 - (work->x & 15));

        default:
            return 15;
    }
}

s32 objBlockColEmpty(OBS_COL_CHK_DATA *work)
{
    if (work->dir != NULL)
        *work->dir = FLOAT_DEG_TO_IDX(0.0) >> 8;

    return objBlockCalcEmpty(work);
}

s32 objBlockColBlockFill(OBS_COL_CHK_DATA *work)
{
    if (work->dir != NULL)
        *work->dir = FLOAT_DEG_TO_IDX(0.0) >> 8;

    return objBlockCalcFill(work);
}

s32 objBlockColBlockFillThrough(OBS_COL_CHK_DATA *work)
{
    if (work->dir != NULL)
        *work->dir = FLOAT_DEG_TO_IDX(0.0) >> 8;

    if (work->attr != NULL)
        *work->attr |= OBJ_COL_ATTR_CLIFF_EDGE;

    if ((work->flag & OBJ_COL_FLAG_ALLOW_TOP_SOLID) != 0)
        return objBlockCalcEmpty(work);
    else
        return objBlockCalcFill(work);
}
