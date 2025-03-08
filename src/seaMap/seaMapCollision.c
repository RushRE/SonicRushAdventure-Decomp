#include <seaMap/seaMapCollision.h>
#include <seaMap/seaMapManager.h>

// --------------------
// TYPES
// --------------------

typedef BOOL (*SeaMapCollisionFunc)(u32 x, u32 y);

// --------------------
// FUNCTION DECLS
// --------------------

static s32 SeaMapCollision__GetCollisionType(void *mapCol, u16 x, u16 y);
static void SeaMapCollision__SetMapCollision(void *mapCol, u16 x, u16 y, u32 newValue);
static BOOL SeaMapCollide_6(u32 x, u32 y);
static BOOL SeaMapCollide_0(u32 x, u32 y);
static BOOL SeaMapCollide_1(u32 x, u32 y);
static BOOL SeaMapCollide_2(u32 x, u32 y);
static BOOL SeaMapCollide_3(u32 x, u32 y);
static BOOL SeaMapCollide_4(u32 x, u32 y);
static BOOL SeaMapCollide_5(u32 x, u32 y);

// --------------------
// VARIABLES
// --------------------

static const SeaMapCollisionFunc collisionTable[] = {
    SeaMapCollide_0, SeaMapCollide_1, SeaMapCollide_2, SeaMapCollide_3, SeaMapCollide_4, SeaMapCollide_5, SeaMapCollide_6, SeaMapCollide_6,
    SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6, SeaMapCollide_6,
};

// --------------------
// FUNCTIONS
// --------------------

s32 SeaMapCollision__GetCollisionAtPoint(u16 x, u16 y)
{
    void *mapCol = SeaMapManager__GetWork()->assets.mapCollision;

    return SeaMapCollision__GetCollisionType(mapCol, x, y);
}

s32 SeaMapCollision__Collide(u16 x, u16 y, BOOL checkMapPixel)
{
    void *mapCol = SeaMapManager__GetWork()->assets.mapCollision;

    if (checkMapPixel)
    {
        u16 mapX;
        u16 mapY;
        SeaMapManager__Func_2043BEC(x, y, &mapX, &mapY);

        if (SeaMapManager__GetMapPixel(mapX, mapY) != 0)
            return FALSE;
    }

    s32 type = SeaMapCollision__GetCollisionType(mapCol, x >> 3, y >> 3);
    u8 posX  = x & 7;
    u8 posY  = y & 7;
    return collisionTable[type](posX, posY);
}

NONMATCH_FUNC BOOL SeaMapCollision__HandleCollisions(u16 outX, u16 outY, u16 inX, u16 inY, BOOL checkMapPixel, u16 *x, u16 *y)
{
    // https://decomp.me/scratch/72mwF -> 93.51%
#ifdef NON_MATCHING
    void *mapCol = SeaMapManager__GetWork()->assets.mapCollision;
    UNUSED(mapCol);

    s16 distX = outX - inX;
    s16 distY = outY - inY;

    *x = inX;
    *y = inY;

    u16 distX2 = MATH_ABS(distX);
    u16 distY2 = MATH_ABS(distY);

    s32 stepOther;
    s32 start;
    s32 step;
    u16 unknown;
    u16 i;

    if (distX2 > distY2)
    {
        if (inX < outX)
            stepOther = 1;
        else
            stepOther = -1;

        if (inY < outY)
        {
            start = inY;
            step  = 1;
        }
        else
        {
            start = outY;
            outY  = inY;
            step  = -1;
        }

        unknown = 0;
        for (i = start + 1; i <= outY; i++)
        {
            inY += step;
            unknown += distX2;

            if (unknown <= distY2)
            {
                unknown -= distY2;
                inX += stepOther;
            }

            if (SeaMapCollision__Collide(inX, inY, checkMapPixel))
                return TRUE;

            *x = inX;
            *y = inY;
        }
    }
    else
    {
        if (inY < outY)
            stepOther = 1;
        else
            stepOther = -1;

        if (inX < outX)
        {
            start = inX;
            step  = 1;
        }
        else
        {
            start = outX;
            outX  = inX;
            step  = -1;
        }

        unknown = 0;
        for (i = start + 1; i <= outX; i++)
        {
            inY += step;
            unknown += distY2;

            if (distX2 >= unknown)
            {
                unknown -= distX2;
                inY += stepOther;
            }

            if (SeaMapCollision__Collide(inX, inY, checkMapPixel))
                return TRUE;

            *x = inX;
            *y = inY;
        }
    }

    return FALSE;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	str r0, [sp]
	str r1, [sp, #4]
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x4c]
	ldr r11, [sp, #0x48]
	ldr r4, [sp, #0x50]
	bl SeaMapManager__GetWork
	ldr r0, [sp]
	sub r2, r0, r7
	ldr r0, [sp, #4]
	sub r1, r0, r6
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	mov r1, r1, asr #0x10
	mov r0, r0, lsl #0x10
	cmp r1, #0
	rsblt r1, r1, #0
	strh r7, [r5]
	mov r9, r0, lsr #0x10
	mov r8, r1, lsl #0x10
	strh r6, [r4]
	cmp r9, r8, lsr #16
	bls _0204A770
	ldr r0, [sp, #4]
	cmp r6, r0
	movlo r0, #1
	strlo r0, [sp, #0x10]
	mvnhs r0, #0
	strhs r0, [sp, #0x10]
	ldr r0, [sp]
	cmp r7, r0
	bhs _0204A6B4
	mov r0, #1
	mov r1, r7
	str r0, [sp, #0x1c]
	b _0204A6C4
_0204A6B4:
	mov r1, r0
	str r7, [sp]
	mvn r0, #0
	str r0, [sp, #0x1c]
_0204A6C4:
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r10, #0
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x14]
	blo _0204A85C
_0204A6E4:
	ldr r0, [sp, #0x1c]
	add r1, r10, r8, lsr #16
	add r0, r7, r0
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	cmp r9, r0, lsr #16
	mov r10, r0, lsr #0x10
	bhi _0204A724
	ldr r0, [sp, #0x10]
	sub r2, r10, r9
	add r1, r6, r0
	mov r0, r2, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
_0204A724:
	mov r0, r7
	mov r1, r6
	mov r2, r11
	bl SeaMapCollision__Collide
	cmp r0, #0
	addne sp, sp, #0x20
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x14]
	strh r7, [r5]
	add r0, r0, #1
	strh r6, [r4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x14]
	bhs _0204A6E4
	b _0204A85C
_0204A770:
	ldr r0, [sp]
	cmp r7, r0
	movlo r0, #1
	strlo r0, [sp, #0xc]
	mvnhs r0, #0
	strhs r0, [sp, #0xc]
	ldr r0, [sp, #4]
	cmp r6, r0
	bhs _0204A7A4
	mov r0, #1
	mov r1, r6
	str r0, [sp, #0x18]
	b _0204A7B4
_0204A7A4:
	mov r1, r0
	str r6, [sp, #4]
	mvn r0, #0
	str r0, [sp, #0x18]
_0204A7B4:
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #4]
	mov r10, #0
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #8]
	blo _0204A85C
_0204A7D4:
	ldr r0, [sp, #0x18]
	add r1, r10, r9
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, r8, lsr #16
	blo _0204A814
	ldr r0, [sp, #0xc]
	sub r2, r10, r8, lsr #16
	add r1, r7, r0
	mov r0, r2, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r7, r0, lsr #0x10
_0204A814:
	mov r0, r7
	mov r1, r6
	mov r2, r11
	bl SeaMapCollision__Collide
	cmp r0, #0
	addne sp, sp, #0x20
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #8]
	strh r7, [r5]
	add r0, r0, #1
	strh r6, [r4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #4]
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #8]
	bhs _0204A7D4
_0204A85C:
	mov r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SeaMapCollision__UpdateMapCollision(void)
{
    void *mapCol = SeaMapManager__GetWork()->assets.mapCollision;
    u16 x;
    u16 y;

    const u32 values[4][7] = {
        { 0, 2, 1, 1, 1, 3, 0 }, // This comment is to keep row formatting
        { 2, 1, 1, 1, 1, 1, 3 }, // This comment is to keep row formatting
        { 1, 1, 1, 1, 1, 1, 1 }, // This comment is to keep row formatting
        { 5, 1, 1, 1, 1, 1, 4 }, // This comment is to keep row formatting
    };

    for (y = 0; y < 4; y++)
    {
        for (x = 0; x < 7; x++)
        {
            SeaMapCollision__SetMapCollision(mapCol, x + 11, y + 46, values[y][x]);
        }
    }
}

s32 SeaMapCollision__GetCollisionType(void *mapCol, u16 x, u16 y)
{
    struct CHCollision *chcl = (struct CHCollision *)mapCol;

    struct CHCollisionValue *value = &chcl->data[y * (chcl->header.width >> 1) + (x >> 1)];
    if ((x & 1) != 0)
        return value->value2;
    else
        return value->value1;
}

void SeaMapCollision__SetMapCollision(void *mapCol, u16 x, u16 y, u32 newValue)
{
    struct CHCollision *chcl = (struct CHCollision *)mapCol;

    struct CHCollisionValue *value = &chcl->data[y * (chcl->header.width >> 1) + (x >> 1)];

    if ((x & 1) != 0)
        value->value2 = newValue;
    else
        value->value1 = newValue;
}

BOOL SeaMapCollide_6(u32 x, u32 y)
{
    return FALSE;
}

BOOL SeaMapCollide_0(u32 x, u32 y)
{
    return FALSE;
}

BOOL SeaMapCollide_1(u32 x, u32 y)
{
    return TRUE;
}

BOOL SeaMapCollide_2(u32 x, u32 y)
{
    x = (u8)(7 - x);

    return y >= x;
}

BOOL SeaMapCollide_3(u32 x, u32 y)
{
    return y >= x;
}

BOOL SeaMapCollide_4(u32 x, u32 y)
{
    x = (u8)(7 - x);

    return y <= x;
}

BOOL SeaMapCollide_5(u32 x, u32 y)
{
    return y <= x;
}