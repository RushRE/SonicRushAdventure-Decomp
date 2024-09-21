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
    u8 count;
};

// --------------------
// VARIABLES
// --------------------

#include <nitro/dtcm_begin.h>

const OBS_DIFF_COLLISION *_obj_fCol = NULL;

struct ObjCollisionCount _obj_collision_num;

StageTaskCollisionObj *_obj_collision_tbl[OBJ_COLLISION_REGISTRATION_MAX];
StageTaskCollisionObj *_obj_collision_tbl_nx[OBJ_COLLISION_REGISTRATION_MAX];

#include <nitro/dtcm_end.h>

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE s32 objMapGetDiff(s32 lCol, s8 sPix, s8 sDelta)
{
    if (lCol > 0)
    {
        if (sDelta > 0)
            return lCol - (sPix + 1);
        else
            return lCol = 8 - sPix;
    }
    else
    {
        if (sDelta > 0)
            return -(sPix + 1);
        else
            return lCol + sPix;
    }
}

RUSH_INLINE s32 objMapGetForward(s8 sPix, s8 sDelta)
{
    if (sDelta > 0)
        return (8 - sPix);
    else
        return (1 + sPix);
}

RUSH_INLINE s32 objMapGetBack(s8 sPix, s8 sDelta)
{
    if (sDelta > 0)
        return -(sPix + 1);
    else
        return (sPix - 8);
}

RUSH_INLINE s32 objMapGetForwardRev(s8 sPix, s8 sDelta)
{
    if (sDelta > 0)
        return (8 - (sPix + 1));
    else
        return (sPix);
}

RUSH_INLINE s32 objMapGetBackFront(s8 sPix, s8 sDelta)
{
    if (sDelta > 0)
        return -(sPix);
    else
        return (sPix - 8);
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

void objDiffAttrSet(StageTask *work, u8 attr)
{
    if ((attr & 2) != 0)
        work->collisionFlag |= STAGE_TASK_COLLISION_FLAG_1;

    if ((attr & 4) != 0)
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
    work->collisionFlag = 0;
    fx32 sSpd           = work->move.x;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK) == 0)
        objDiffCollisionDirWidthCheck(work, 0, sSpd);

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK) == 0)
        objDiffCollisionDirHeightCheck(work);

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        work->position.y &= 0xFFFFF000;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK) == 0)
        objDiffCollisionDirWidthCheck(work, 1, sSpd);
}

ObjCollisionFlags objDiffSufSet(StageTask *work)
{
    ObjCollisionFlags flags = OBJ_COL_FLAG_NONE;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_20) != 0)
        flags |= OBJ_COL_FLAG_80;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_100000) == 0)
        flags |= OBJ_COL_FLAG_80;

    if ((work->flag & STAGE_TASK_FLAG_ON_PLANE_B) != 0)
        flags |= OBJ_COL_FLAG_USE_PLANE_B;

    if ((work->moveFlag & STAGE_TASK_MOVE_FLAG_80000) != 0)
        flags |= OBJ_COL_FLAG_40;

    return flags;
}

NONMATCH_FUNC void objDiffCollisionDirWidthCheck(StageTask *work, u8 ucWall, s32 sSpd)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	mov r5, #0
	add r3, sp, #0x14
	str r5, [r3, #0x10]
	str r1, [sp]
	str r5, [sp, #0xc]
	str r5, [sp, #8]
	mov r9, r0
	str r2, [sp, #4]
	mov r6, r5
	mov r10, r5
	mov r11, r5
	str r5, [r3]
	str r5, [r3, #4]
	str r5, [r3, #8]
	str r5, [r3, #0xc]
	bl objDiffSufSet
	strh r0, [sp, #0x24]
	ldrh r0, [sp, #0x24]
	mov r4, #0x4000
	orr r0, r0, #0x80
	strh r0, [sp, #0x24]
	ldrh r0, [r9, #0x34]
	ldr r2, [r9, #0x48]
	ldr r3, [r9, #0x44]
	add r1, r0, #0x2000
	and r1, r1, #0xc000
	mov r1, r1, asr #0xe
	mov r8, r2, asr #0xc
	cmp r1, #2
	addeq r2, r4, #0x8000
	moveq r2, r2, lsl #0x10
	moveq r4, r2, lsr #0x10
	ldr r2, [sp, #4]
	mov r7, r3, asr #0xc
	cmp r2, #0
	ble _01FF82A0
	rsb r2, r4, #0
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	mov r11, #1
	b _01FF82BC
_01FF82A0:
	ldr r2, [r9, #0x20]
	tst r2, #1
	bne _01FF82BC
	rsb r2, r4, #0
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	mov r11, #1
_01FF82BC:
	ldrh r2, [r9, #0xce]
	cmp r2, #0
	beq _01FF82F0
	add r2, r4, r2
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	ldr r2, [sp, #4]
	cmp r2, #0
	ble _01FF82F0
	rsb r2, r4, #0
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	mov r11, #0
_01FF82F0:
	cmp r1, #2
	eoreq r1, r11, #1
	andeq r11, r1, #0xff
	ldr r1, [r9, #0x1c]
	tst r1, #0x10
	addeq r0, r4, r0
	moveq r0, r0, lsl #0x10
	moveq r4, r0, lsr #0x10
	mov r0, r9
	bl objDiffCollisionSimpleOverCheck
	cmp r0, #0
	movne r0, #6
	strne r0, [sp, #8]
	add r0, r4, #0x2000
	and r0, r0, #0xc000
	mov r0, r0, asr #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF84A0
_01FF833C: // jump table
	b _01FF834C // case 0
	b _01FF8390 // case 1
	b _01FF83F4 // case 2
	b _01FF8438 // case 3
_01FF834C:
	ldrsh r0, [r9, #0xf0]
	ldrsh r2, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	add r1, r1, #4
	mov r6, r0, asr #0x10
	sub r2, r2, #4
	mov r0, r2, lsl #0x10
	mov r2, #2
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	strh r2, [sp, #0x26]
	mov r0, r1, asr #0x10
	mov r10, r6
	str r0, [sp, #0xc]
	b _01FF84A0
_01FF8390:
	ldrsh r0, [r9, #0xf2]
	ldrsh r1, [r9, #0xec]
	ldrsh r2, [r9, #0xee]
	sub r3, r0, #4
	ldr r0, [sp, #8]
	sub r1, r1, #2
	mov r1, r1, lsl #0x10
	add r2, r2, r0
	mov r5, r1, asr #0x10
	mov r0, r3, lsl #0x10
	mov r1, r2, lsl #0x10
	str r5, [sp, #0xc]
	cmp r11, #0
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
	beq _01FF83E8
	rsb r0, r6, #0
	rsb r1, r10, #0
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	mov r0, r1, lsl #0x10
	mov r10, r0, asr #0x10
_01FF83E8:
	mov r0, #1
	strh r0, [sp, #0x26]
	b _01FF84A0
_01FF83F4:
	ldrsh r0, [r9, #0xec]
	ldrsh r2, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	sub r0, r0, #2
	mov r0, r0, lsl #0x10
	add r1, r1, #4
	mov r6, r0, asr #0x10
	sub r2, r2, #4
	mov r0, r2, lsl #0x10
	mov r2, #3
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	strh r2, [sp, #0x26]
	mov r0, r1, asr #0x10
	mov r10, r6
	str r0, [sp, #0xc]
	b _01FF84A0
_01FF8438:
	ldrsh r2, [r9, #0xf0]
	ldrsh r0, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	add r3, r2, #2
	sub r2, r0, #4
	ldr r0, [sp, #8]
	rsb r2, r2, #0
	add r1, r1, r0
	mov r0, r3, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r2, lsl #0x10
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r2, #0
	str r5, [sp, #0xc]
	strh r2, [sp, #0x26]
	cmp r11, #0
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
	beq _01FF84A0
	rsb r0, r6, #0
	rsb r1, r10, #0
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	mov r0, r1, lsl #0x10
	mov r10, r0, asr #0x10
_01FF84A0:
	add r0, r7, r5
	str r0, [sp, #0x14]
	add r0, r8, r6
	str r0, [sp, #0x18]
	add r1, sp, #0x14
	mov r0, r9
	bl ObjCollisionUnion
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	add r1, sp, #0x14
	add r0, r7, r0
	str r0, [sp, #0x14]
	add r0, r8, r10
	str r0, [sp, #0x18]
	mov r0, r9
	bl ObjCollisionUnion
	mov r1, r0, lsl #0x18
	ldr r0, [sp, #0x10]
	cmp r0, r1, asr #24
	mov r0, r1, asr #0x18
	strge r0, [sp, #0x10]
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bgt _01FF85D8
	ldr r0, [sp]
	cmp r0, #0
	bne _01FF8564
	ldrh r0, [sp, #0x26]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF8534
_01FF8524: // jump table
	b _01FF8558 // case 0
	b _01FF8540 // case 1
	b _01FF8534 // case 2
	b _01FF854C // case 3
_01FF8534:
	ldr r0, [sp, #0x10]
	add r8, r8, r0
	b _01FF85D8
_01FF8540:
	ldr r0, [sp, #0x10]
	sub r7, r7, r0
	b _01FF85D8
_01FF854C:
	ldr r0, [sp, #0x10]
	sub r8, r8, r0
	b _01FF85D8
_01FF8558:
	ldr r0, [sp, #0x10]
	add r7, r7, r0
	b _01FF85D8
_01FF8564:
	ldr r0, [r9, #0x1c]
	orr r0, r0, #4
	str r0, [r9, #0x1c]
	tst r0, #0x4000
	bne _01FF85B8
	ldrh r0, [sp, #0x26]
	cmp r0, #1
	bne _01FF8598
	ldr r0, [r9, #0xbc]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r9, #0xc8]
	strlt r0, [r9, #0x98]
_01FF8598:
	ldrh r0, [sp, #0x26]
	cmp r0, #0
	bne _01FF85B8
	ldr r0, [r9, #0xbc]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r9, #0xc8]
	strgt r0, [r9, #0x98]
_01FF85B8:
	ldrh r0, [sp, #0x26]
	tst r0, #2
	beq _01FF85D8
	ldr r0, [r9, #0x1c]
	tst r0, #0x4000
	moveq r0, #0
	streq r0, [r9, #0x9c]
	streq r0, [r9, #0xc8]
_01FF85D8:
	add r0, r4, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x2000
	and r0, r0, #0xc000
	mov r0, r0, asr #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF8760
_01FF85FC: // jump table
	b _01FF860C // case 0
	b _01FF8650 // case 1
	b _01FF86BC // case 2
	b _01FF8700 // case 3
_01FF860C:
	ldrsh r0, [r9, #0xf0]
	ldrsh r2, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	add r1, r1, #4
	mov r6, r0, asr #0x10
	sub r2, r2, #4
	mov r0, r2, lsl #0x10
	mov r2, #2
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	strh r2, [sp, #0x26]
	mov r0, r1, asr #0x10
	mov r10, r6
	str r0, [sp, #0xc]
	b _01FF8760
_01FF8650:
	ldrsh r2, [r9, #0xec]
	ldrsh r0, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	sub r3, r2, #2
	sub r2, r0, #4
	ldr r0, [sp, #8]
	rsb r2, r2, #0
	add r1, r1, r0
	mov r0, r3, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r2, lsl #0x10
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r2, #1
	str r5, [sp, #0xc]
	strh r2, [sp, #0x26]
	cmp r11, #0
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
	beq _01FF8760
	rsb r0, r6, #0
	rsb r1, r10, #0
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
	b _01FF8760
_01FF86BC:
	ldrsh r0, [r9, #0xec]
	ldrsh r2, [r9, #0xf2]
	ldrsh r1, [r9, #0xee]
	sub r0, r0, #2
	mov r0, r0, lsl #0x10
	add r1, r1, #4
	mov r6, r0, asr #0x10
	sub r2, r2, #4
	mov r0, r2, lsl #0x10
	mov r2, #3
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	strh r2, [sp, #0x26]
	mov r0, r1, asr #0x10
	mov r10, r6
	str r0, [sp, #0xc]
	b _01FF8760
_01FF8700:
	ldrsh r1, [r9, #0xf0]
	ldrsh r0, [r9, #0xf2]
	ldrsh r2, [r9, #0xee]
	add r1, r1, #2
	sub r3, r0, #4
	ldr r0, [sp, #8]
	mov r1, r1, lsl #0x10
	add r2, r2, r0
	mov r5, r1, asr #0x10
	mov r1, r2, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r2, #0
	str r5, [sp, #0xc]
	strh r2, [sp, #0x26]
	cmp r11, #0
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
	beq _01FF8760
	rsb r0, r6, #0
	rsb r1, r10, #0
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r6, r0, asr #0x10
	mov r10, r1, asr #0x10
_01FF8760:
	add r3, r7, r5
	add r2, r8, r6
	add r1, sp, #0x14
	mov r0, r9
	str r3, [sp, #0x14]
	str r2, [sp, #0x18]
	bl ObjCollisionUnion
	mov r2, r0, lsl #0x18
	ldr r0, [sp, #0xc]
	add r3, r8, r10
	add r4, r7, r0
	str r4, [sp, #0x14]
	add r1, sp, #0x14
	mov r0, r9
	str r3, [sp, #0x18]
	mov r4, r2, asr #0x18
	bl ObjCollisionUnion
	mov r0, r0, lsl #0x18
	cmp r4, r0, asr #24
	mov r0, r0, asr #0x18
	movge r4, r0
	cmp r4, #0
	bgt _01FF88A4
	ldr r0, [sp]
	cmp r0, #0
	bne _01FF8808
	ldrh r0, [sp, #0x26]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF87E8
_01FF87D8: // jump table
	b _01FF8800 // case 0
	b _01FF87F0 // case 1
	b _01FF87E8 // case 2
	b _01FF87F8 // case 3
_01FF87E8:
	add r8, r8, r4
	b _01FF88A4
_01FF87F0:
	sub r7, r7, r4
	b _01FF88A4
_01FF87F8:
	sub r8, r8, r4
	b _01FF88A4
_01FF8800:
	add r7, r7, r4
	b _01FF88A4
_01FF8808:
	ldr r0, [r9, #0x1c]
	tst r0, #4
	beq _01FF881C
	cmp r4, #0
	bge _01FF8828
_01FF881C:
	ldr r0, [r9, #0x1c]
	orr r0, r0, #8
	str r0, [r9, #0x1c]
_01FF8828:
	ldr r0, [r9, #0x1c]
	tst r0, #0x4000
	bne _01FF88A4
	ldrh r0, [sp, #0x26]
	cmp r0, #1
	bne _01FF8850
	ldr r0, [sp, #4]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r9, #0xc8]
_01FF8850:
	ldrh r0, [sp, #0x26]
	cmp r0, #0
	bne _01FF886C
	ldr r0, [sp, #4]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r9, #0xc8]
_01FF886C:
	ldrh r0, [sp, #0x26]
	cmp r0, #1
	bne _01FF8888
	ldr r0, [r9, #0x98]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r9, #0x98]
_01FF8888:
	ldrh r0, [sp, #0x26]
	cmp r0, #0
	bne _01FF88A4
	ldr r0, [r9, #0x98]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r9, #0x98]
_01FF88A4:
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r9, #0x44]
	rsb r0, r7, r1, asr #12
	sub r0, r1, r0, lsl #12
	str r0, [r9, #0x44]
	ldr r1, [r9, #0x48]
	rsb r0, r8, r1, asr #12
	sub r0, r1, r0, lsl #12
	str r0, [r9, #0x48]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
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

    s16 x1;
    s16 x2;
    s16 y1;
    s16 y2;
    switch (dir)
    {
        case 0:
        default:
            y1 = work->hitboxRect.top;
            y2 = work->hitboxRect.top;
            x1 = (work->hitboxRect.right - 2);
            x2 = (work->hitboxRect.left + 2);

            colWork.vec = OBJ_COL_VEC_DOWN;
            break;

        case 1:
            x1 = work->hitboxRect.right;
            x2 = work->hitboxRect.right;
            y1 = (work->hitboxRect.left + 2);
            y2 = (work->hitboxRect.right - 2);

            colWork.vec = OBJ_COL_VEC_LEFT;
            break;

        case 2:
            y1 = work->hitboxRect.bottom;
            y2 = work->hitboxRect.bottom;
            x1 = (work->hitboxRect.right - 2);
            x2 = (work->hitboxRect.left + 2);

            colWork.vec = OBJ_COL_VEC_UP;
            break;

        case 3:
            x1 = work->hitboxRect.left;
            x2 = work->hitboxRect.left;
            y1 = (work->hitboxRect.left + 2);
            y2 = (work->hitboxRect.right - 2);

            colWork.vec = OBJ_COL_VEC_RIGHT;
            break;
    }

    colWork.x = FX32_TO_WHOLE(work->position.x) + x1;
    colWork.y = FX32_TO_WHOLE(work->position.y) + y1;
    s8 c1     = ObjCollisionUnion(work, &colWork);

    colWork.x = FX32_TO_WHOLE(work->position.x) + x2;
    colWork.y = FX32_TO_WHOLE(work->position.y) + y2;
    s8 c2     = ObjCollisionUnion(work, &colWork);

    s8 result;
    if (c1 < c2)
        result = c1;
    else
        result = c2;

    return result <= 0;
}

NONMATCH_FUNC void objDiffCollisionDirHeightCheck(StageTask *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x64
	add r1, sp, #0x50
	mov r2, #0
	mov r5, r0
	str r2, [r1]
	str r2, [r1, #4]
	str r2, [r1, #8]
	str r2, [r1, #0xc]
	str r2, [r1, #0x10]
	ldr r1, [r5, #0x114]
	str r2, [sp, #0x38]
	str r1, [sp, #0x2c]
	bl objDiffSufSet
	strh r0, [sp, #0x60]
	ldr r2, [r5, #0x44]
	ldr r1, [r5, #0x48]
	ldrh r0, [r5, #0x34]
	mov r6, r2, asr #0xc
	mov r7, r1, asr #0xc
	strh r0, [sp, #0x32]
	strh r0, [sp, #0x34]
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	movne r0, #0
	strne r0, [sp, #8]
	bne _01FF8B30
	ldrh r0, [r5, #0x34]
	add r0, r0, #0x2000
	and r0, r0, #0xc000
	mov r0, r0, lsl #2
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
_01FF8B30:
	ldrh r0, [r5, #0xce]
	cmp r0, #0
	beq _01FF8B60
	add r0, r0, #0x2000
	and r0, r0, #0xc000
	mov r1, r0, lsl #2
	ldr r0, [sp, #8]
	add r0, r0, r1, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	str r0, [sp, #8]
_01FF8B60:
	ldr r0, [sp, #8]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF8B80
_01FF8B70: // jump table
	b _01FF8B80 // case 0
	b _01FF8BE4 // case 1
	b _01FF8C5C // case 2
	b _01FF8CC4 // case 3
_01FF8B80:
	ldr r0, =g_obj
	ldrsh r3, [r5, #0xf0]
	ldrsb r1, [r0, #0x60]
	ldrsh r0, [r5, #0xf2]
	ldrsh r2, [r5, #0xec]
	add r4, r3, #1
	str r0, [sp, #0x1c]
	mov r0, #2
	strh r0, [sp, #0x62]
	ldr r0, [sp, #0x1c]
	rsb r3, r1, #0
	str r0, [sp, #0x10]
	ldr r0, [r5, #0xbc]
	sub r2, r2, #1
	str r0, [sp]
	ldr r0, [r5, #0xc0]
	mov r1, r4, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r9, r1, asr #0x10
	mov r10, r2, asr #0x10
	mov r4, r3, asr #0x10
	str r0, [sp, #0x28]
	mov r8, #0
	b _01FF8D24
_01FF8BE4:
	ldrsh r0, [r5, #0xf2]
	ldrsh r3, [r5, #0xec]
	ldrsh r1, [r5, #0xf0]
	rsb r2, r0, #0
	mov r2, r2, lsl #0x10
	sub r4, r3, #1
	mov r9, r2, asr #0x10
	mov r2, r4, lsl #0x10
	add r3, r1, #1
	mov r2, r2, asr #0x10
	cmp r1, #0
	rsblt r1, r1, #0
	sub r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r3, r3, lsl #0x10
	str r2, [sp, #0x1c]
	mov r2, r3, asr #0x10
	str r2, [sp, #0x10]
	mov r2, #1
	strh r2, [sp, #0x62]
	ldr r2, [r5, #0xbc]
	mov r8, r0, asr #0x10
	rsb r0, r2, #0
	ldr r1, [r5, #0xc0]
	str r0, [sp, #0x28]
	rsb r0, r1, #0
	mov r10, r9
	str r0, [sp]
	mov r4, #0
	b _01FF8D24
_01FF8C5C:
	ldr r0, =g_obj
	ldrsh r3, [r5, #0xf0]
	ldrsh r2, [r5, #0xf2]
	ldrsh r1, [r5, #0xec]
	ldrsb r4, [r0, #0x60]
	mov r0, #3
	rsb r2, r2, #0
	strh r0, [sp, #0x62]
	sub r8, r1, #1
	ldr r1, [r5, #0xbc]
	ldr r0, [r5, #0xc0]
	add r3, r3, #1
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, lsl #0x10
	mov r8, r8, lsl #0x10
	rsb r1, r1, #0
	rsb r0, r0, #0
	mov r10, r8, asr #0x10
	str r2, [sp, #0x1c]
	str r2, [sp, #0x10]
	mov r9, r3, asr #0x10
	str r1, [sp]
	str r0, [sp, #0x28]
	mov r8, #0
	b _01FF8D24
_01FF8CC4:
	ldrsh r0, [r5, #0xec]
	ldrsh r1, [r5, #0xf0]
	ldrsh r9, [r5, #0xf2]
	sub r3, r0, #1
	add r2, r1, #1
	mov r1, r3, lsl #0x10
	cmp r0, #0
	rsblt r0, r0, #0
	mov r1, r1, asr #0x10
	sub r0, r9, r0
	mov r4, #0
	mov r2, r2, lsl #0x10
	str r1, [sp, #0x1c]
	mov r1, r2, asr #0x10
	strh r4, [sp, #0x62]
	rsb r0, r0, #0
	str r1, [sp, #0x10]
	mov r1, r0, lsl #0x10
	ldr r0, [r5, #0xbc]
	mov r10, r9
	str r0, [sp, #0x28]
	ldr r0, [r5, #0xc0]
	mov r8, r1, asr #0x10
	str r0, [sp]
_01FF8D24:
	ldr r1, [r5, #0x1c]
	tst r1, #0x20
	bne _01FF8E04
	tst r1, #0x400000
	bne _01FF8DD4
	ldrh r11, [sp, #0x60]
	add r0, r9, r8
	add r0, r6, r0
	str r0, [sp, #0x50]
	bic r0, r11, #0x80
	strh r0, [sp, #0x60]
	ldr r0, [sp, #0x1c]
	add r1, sp, #0x50
	add r0, r0, r4
	add r0, r7, r0
	str r0, [sp, #0x54]
	mov r0, r5
	bl ObjCollisionUnion
	add r1, r10, r8
	add r1, r6, r1
	str r1, [sp, #0x50]
	ldr r1, [sp, #0x10]
	mov r0, r0, lsl #0x18
	add r1, r1, r4
	add r1, r7, r1
	str r1, [sp, #0x54]
	mov r4, r0, asr #0x18
	mov r0, r5
	add r1, sp, #0x50
	bl ObjCollisionUnion
	mov r1, r0, lsl #0x18
	ldr r0, [sp, #0x2c]
	strh r11, [sp, #0x60]
	str r0, [r5, #0x114]
	mov r0, r1, asr #0x18
	cmp r4, r1, asr #24
	movge r4, r0
	ldr r0, [r5, #0x1c]
	cmp r4, #0
	orrge r0, r0, #0x100000
	strge r0, [r5, #0x1c]
	biclt r0, r0, #0x100000
	strlt r0, [r5, #0x1c]
	b _01FF8E04
_01FF8DD4:
	ldrh r0, [sp, #0x62]
	tst r0, #2
	bne _01FF8DEC
	ldr r0, [r5, #0xe8]
	tst r0, #4
	beq _01FF8DFC
_01FF8DEC:
	ldr r0, [r5, #0x1c]
	orr r0, r0, #0x100000
	str r0, [r5, #0x1c]
	b _01FF8E04
_01FF8DFC:
	bic r0, r1, #0x100000
	str r0, [r5, #0x1c]
_01FF8E04:
	ldr r0, [r5, #0x1c]
	add r1, sp, #0x34
	tst r0, #0x100000
	ldreqh r0, [sp, #0x60]
	add r2, sp, #0x38
	str r1, [sp, #0x58]
	orreq r0, r0, #0x80
	streqh r0, [sp, #0x60]
	add r0, r6, r9
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x1c]
	add r1, sp, #0x50
	add r8, r7, r0
	ldr r0, [sp, #0x14]
	str r2, [sp, #0x5c]
	str r0, [sp, #0x50]
	mov r0, r5
	str r8, [sp, #0x54]
	bl ObjCollisionUnion
	mov r0, r0, lsl #0x18
	mov r4, r0, asr #0x18
	ldr r1, [sp, #0x38]
	mov r0, r5
	bl objDiffAttrSet
	add r0, r6, r10
	add r1, sp, #0x32
	str r1, [sp, #0x58]
	str r0, [sp, #0x18]
	str r0, [sp, #0x50]
	ldr r0, [sp, #0x10]
	add r1, sp, #0x50
	add r0, r7, r0
	str r0, [sp, #0xc]
	str r0, [sp, #0x54]
	mov r0, r5
	bl ObjCollisionUnion
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	str r0, [sp, #4]
	ldr r1, [sp, #0x38]
	mov r0, r5
	bl objDiffAttrSet
	add r1, sp, #0x30
	mov r0, #0
	str r8, [sp, #0x54]
	str r1, [sp, #0x58]
	str r0, [sp, #0x5c]
	ldr r0, [r5, #0x1c]
	tst r0, #0x200000
	beq _01FF8F5C
	tst r0, #0x200
	bne _01FF8F5C
	cmp r9, r10
	ble _01FF8EF8
	sub r0, r9, r10
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r11, r0, asr #0x10
	ldr r0, [sp, #0x18]
	str r0, [sp, #0x24]
	b _01FF8F10
_01FF8EF8:
	sub r0, r10, r9
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r11, r0, asr #0x10
	ldr r0, [sp, #0x14]
	str r0, [sp, #0x24]
_01FF8F10:
	cmp r11, #1
	mov r8, #1
	ble _01FF8F5C
_01FF8F1C:
	ldr r0, [sp, #0x24]
	add r1, sp, #0x50
	add r0, r0, r8
	str r0, [sp, #0x50]
	mov r0, r5
	bl ObjCollisionObjectCheck
	mov r0, r0, lsl #0x18
	cmp r4, r0, asr #24
	mov r0, r0, asr #0x18
	movgt r4, r0
	ldrgth r0, [sp, #0x30]
	strgth r0, [sp, #0x34]
	add r0, r8, #1
	and r8, r0, #0xff
	cmp r8, r11
	blt _01FF8F1C
_01FF8F5C:
	ldr r0, [sp, #0xc]
	cmp r9, r10
	str r0, [sp, #0x54]
	mov r0, #0
	str r0, [sp, #0x58]
	add r0, sp, #0x38
	str r0, [sp, #0x5c]
	bge _01FF8FA8
	cmp r10, #0
	rsblt r0, r10, #0
	movge r0, r10
	cmp r9, #0
	rsblt r1, r9, #0
	movge r1, r9
	add r1, r1, r0
	ldr r0, [sp, #0x14]
	add r0, r0, r1, asr #1
	str r0, [sp, #0x50]
	b _01FF8FD0
_01FF8FA8:
	cmp r10, #0
	rsblt r0, r10, #0
	movge r0, r10
	cmp r9, #0
	rsblt r1, r9, #0
	movge r1, r9
	add r1, r1, r0
	ldr r0, [sp, #0x18]
	add r0, r0, r1, asr #1
	str r0, [sp, #0x50]
_01FF8FD0:
	add r1, sp, #0x50
	mov r0, r5
	bl ObjCollisionUnion
	ldr r1, [sp, #0x38]
	mov r0, r5
	bl objDiffAttrSet
	ldr r1, [r5, #0xe4]
	tst r1, #4
	beq _01FF9060
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	beq _01FF9060
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ble _01FF9060
	tst r1, #1
	bne _01FF9060
	ldrh r1, [r5, #0xce]
	ldrh r0, [sp, #0x34]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x4000
	blo _01FF9038
	cmp r0, #0xc000
	bls _01FF9058
_01FF9038:
	ldrh r0, [sp, #0x32]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x4000
	blo _01FF9060
	cmp r0, #0xc000
	bhi _01FF9060
_01FF9058:
	mov r4, #0x18
	str r4, [sp, #4]
_01FF9060:
	ldr r0, [sp, #4]
	cmp r4, r0
	movlt r8, r4
	movge r8, r0
	cmp r8, #0
	beq _01FF93C8
	bge _01FF929C
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	beq _01FF9094
	ldr r0, [sp, #0x28]
	cmp r0, #0
	blt _01FF90A0
_01FF9094:
	ldr r0, [r5, #0x1c]
	orr r0, r0, #1
	str r0, [r5, #0x1c]
_01FF90A0:
	mvn r0, #0xd
	cmp r8, r0
	blt _01FF93EC
	ldr r1, [r5, #0x1c]
	tst r1, #1
	beq _01FF93EC
	add r0, r0, #0xd
	cmp r8, r0
	bne _01FF9250
	tst r1, #0x10000
	beq _01FF9250
	ldrh ip, [sp, #0x60]
	ldr r0, [sp, #4]
	ldrh lr, [sp, #0x62]
	cmp r4, r0
	add r1, sp, #0x3c
	str r10, [sp, #0x20]
	mov r0, #0
	str r0, [r1, #0x10]
	strh lr, [sp, #0x4e]
	str r0, [r1]
	str r0, [r1, #4]
	str r0, [r1, #8]
	str r0, [r1, #0xc]
	strh ip, [sp, #0x4c]
	ldrh r0, [sp, #0x4e]
	ldrge r4, [sp, #4]
	ldr r11, [sp, #0x10]
	ldr r3, [sp, #0x1c]
	mov r2, r9
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF91B0
_01FF9124: // jump table
	b _01FF9190 // case 0
	b _01FF9150 // case 1
	b _01FF9134 // case 2
	b _01FF9174 // case 3
_01FF9134:
	add r0, r3, r4
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	add r0, r11, r4
	mov r0, r0, lsl #0x10
	mov r11, r0, asr #0x10
	b _01FF91B0
_01FF9150:
	sub r0, r2, r4
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	ldr r0, [sp, #0x20]
	sub r0, r0, r4
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x20]
	b _01FF91B0
_01FF9174:
	sub r0, r3, r4
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	sub r0, r11, r4
	mov r0, r0, lsl #0x10
	mov r11, r0, asr #0x10
	b _01FF91B0
_01FF9190:
	add r0, r2, r4
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	ldr r0, [sp, #0x20]
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x20]
_01FF91B0:
	add r0, r6, r2
	str r0, [sp, #0x3c]
	add r0, r7, r3
	str r0, [sp, #0x40]
	add r0, sp, #0x3c
	bl objCollisionFast
	ldr r1, [sp, #0x20]
	mov r0, r0, lsl #0x18
	mov r4, r0, asr #0x18
	add r0, r7, r11
	add r1, r6, r1
	str r0, [sp, #0x40]
	add r0, sp, #0x3c
	str r1, [sp, #0x3c]
	bl objCollisionFast
	mov r0, r0, lsl #0x18
	cmp r4, r0, asr #24
	mov r0, r0, asr #0x18
	movge r4, r0
	cmp r4, #1
	beq _01FF93EC
	ldrh r0, [sp, #0x62]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF9224
_01FF9214: // jump table
	b _01FF923C // case 0
	b _01FF922C // case 1
	b _01FF9224 // case 2
	b _01FF9234 // case 3
_01FF9224:
	add r7, r7, r8
	b _01FF9240
_01FF922C:
	sub r6, r6, r8
	b _01FF9240
_01FF9234:
	sub r7, r7, r8
	b _01FF9240
_01FF923C:
	add r6, r6, r8
_01FF9240:
	ldr r0, [r5, #0x1c]
	bic r0, r0, #0x10000
	str r0, [r5, #0x1c]
	b _01FF93EC
_01FF9250:
	ldrh r0, [sp, #0x62]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF9270
_01FF9260: // jump table
	b _01FF9288 // case 0
	b _01FF9278 // case 1
	b _01FF9270 // case 2
	b _01FF9280 // case 3
_01FF9270:
	add r7, r7, r8
	b _01FF928C
_01FF9278:
	sub r6, r6, r8
	b _01FF928C
_01FF9280:
	sub r7, r7, r8
	b _01FF928C
_01FF9288:
	add r6, r6, r8
_01FF928C:
	ldr r0, [r5, #0x1c]
	bic r0, r0, #0x10000
	str r0, [r5, #0x1c]
	b _01FF93EC
_01FF929C:
	cmp r8, #1
	ldreq r0, [r5, #0x1c]
	orreq r0, r0, #0x10000
	streq r0, [r5, #0x1c]
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	bne _01FF93EC
	ldr r0, [sp, #8]
	tst r0, #1
	beq _01FF92D4
	ldr r0, [sp, #0x28]
	cmp r0, #0
	rsblt r0, r0, #0
	b _01FF92E8
_01FF92D4:
	ldr r0, [sp]
	cmp r0, #0
	rsblt r0, r0, #0
	strlt r0, [sp]
	ldr r0, [sp]
_01FF92E8:
	mov r0, r0, asr #0xc
	add r0, r0, #3
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0xb
	movgt r0, #0xb
	cmp r8, r0
	ldr r0, [r5, #0x1c]
	bgt _01FF93BC
	orr r0, r0, #1
	str r0, [r5, #0x1c]
	ldrh r0, [sp, #0x62]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF9334
_01FF9324: // jump table
	b _01FF934C // case 0
	b _01FF933C // case 1
	b _01FF9334 // case 2
	b _01FF9344 // case 3
_01FF9334:
	add r7, r7, r8
	b _01FF9350
_01FF933C:
	sub r6, r6, r8
	b _01FF9350
_01FF9344:
	sub r7, r7, r8
	b _01FF9350
_01FF934C:
	add r6, r6, r8
_01FF9350:
	ldr r0, [r5, #0x1c]
	tst r0, #0x200
	bne _01FF93EC
	tst r0, #0x40
	ldreq r0, [r5, #0x118]
	cmpeq r0, #0
	bne _01FF93EC
	add r0, r6, r9
	str r0, [sp, #0x50]
	ldr r0, [sp, #0x1c]
	mov r2, #0
	add r0, r7, r0
	str r0, [sp, #0x54]
	add r1, sp, #0x50
	mov r0, r5
	str r2, [sp, #0x5c]
	str r2, [sp, #0x58]
	bl ObjCollisionObjectCheck
	add r0, r6, r10
	str r0, [sp, #0x50]
	ldr r0, [sp, #0x10]
	add r1, sp, #0x50
	add r0, r7, r0
	str r0, [sp, #0x54]
	mov r0, r5
	bl ObjCollisionObjectCheck
	b _01FF93EC
_01FF93BC:
	bic r0, r0, #1
	str r0, [r5, #0x1c]
	b _01FF93EC
_01FF93C8:
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	beq _01FF93E0
	ldr r0, [r5, #0x9c]
	cmp r0, #0
	blt _01FF93EC
_01FF93E0:
	ldr r0, [r5, #0x1c]
	orr r0, r0, #1
	str r0, [r5, #0x1c]
_01FF93EC:
	ldr r1, [r5, #0x1c]
	tst r1, #1
	beq _01FF9560
	tst r1, #0x20000000
	bne _01FF9498
	ldr r0, [r5, #0xe4]
	tst r0, #1
	bne _01FF9498
	tst r1, #0x40
	beq _01FF9498
	ldr r0, [sp, #4]
	cmp r4, r0
	blt _01FF945C
	ldrgth r0, [sp, #0x32]
	strgth r0, [sp, #0x34]
	bgt _01FF945C
	ldrh r1, [r5, #0x34]
	ldrh r0, [r5, #0xce]
	ldrh r2, [sp, #0x32]
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	rsbs r3, r2, r0, lsr #16
	ldrh r1, [sp, #0x34]
	rsbmi r3, r3, #0
	rsbs r0, r1, r0, lsr #16
	rsbmi r0, r0, #0
	cmp r0, r3
	strgth r2, [sp, #0x34]
_01FF945C:
	ldrh r1, [r5, #0xce]
	cmp r1, #0
	ldrneh r0, [sp, #0x34]
	addne r0, r0, r1
	strneh r0, [sp, #0x34]
	ldr r0, [r5, #0x1c]
	tst r0, #0x800000
	ldreqh r0, [sp, #0x34]
	streqh r0, [r5, #0x34]
	beq _01FF9498
	ldrh r0, [r5, #0x34]
	ldrh r1, [sp, #0x34]
	mov r2, #0x100
	bl ObjRoopMove16
	strh r0, [r5, #0x34]
_01FF9498:
	ldr r2, [r5, #0x1c]
	tst r2, #0x4000
	bne _01FF9568
	tst r2, #0x10
	movne r0, #0
	bne _01FF94C4
	ldrh r0, [r5, #0x34]
	add r0, r0, #0x2000
	and r0, r0, #0xc000
	mov r0, r0, lsl #2
	mov r0, r0, lsr #0x10
_01FF94C4:
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF94E0
_01FF94D0: // jump table
	b _01FF94E0 // case 0
	b _01FF9524 // case 1
	b _01FF9538 // case 2
	b _01FF954C // case 3
_01FF94E0:
	ldr r1, [r5, #0x9c]
	cmp r1, #0
	ble _01FF9568
	tst r2, #0x20000
	beq _01FF9518
	ldrh r3, [r5, #0x34]
	ldr r2, =FX_SinCosTable_
	ldr r0, [r5, #0x98]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r2, [r2, r3]
	mul r2, r1, r2
	add r0, r0, r2, asr #12
	str r0, [r5, #0x98]
_01FF9518:
	mov r0, #0
	str r0, [r5, #0x9c]
	b _01FF9568
_01FF9524:
	ldr r0, [r5, #0x98]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r5, #0x98]
	b _01FF9568
_01FF9538:
	ldr r0, [r5, #0x9c]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r5, #0x9c]
	b _01FF9568
_01FF954C:
	ldr r0, [r5, #0x98]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r5, #0x98]
	b _01FF9568
_01FF9560:
	ldr r0, [sp, #0x2c]
	str r0, [r5, #0x114]
_01FF9568:
	ldr r0, [sp, #0x28]
	cmp r0, #0x100
	bge _01FF970C
	ldrh r1, [sp, #0x60]
	ldrh r0, [sp, #0x62]
	orr r1, r1, #0x80
	strh r1, [sp, #0x60]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _01FF95A0
_01FF9590: // jump table
	b _01FF9608 // case 0
	b _01FF95C4 // case 1
	b _01FF95A0 // case 2
	b _01FF95E4 // case 3
_01FF95A0:
	ldrsh r0, [r5, #0xee]
	mov r1, #3
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x1c]
	str r0, [sp, #0x10]
	strh r1, [sp, #0x62]
	b _01FF9624
_01FF95C4:
	ldrsh r0, [r5, #0xf0]
	mov r1, #0
	sub r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	mov r10, r9
	strh r1, [sp, #0x62]
	b _01FF9624
_01FF95E4:
	ldrsh r0, [r5, #0xf2]
	mov r1, #2
	sub r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x1c]
	str r0, [sp, #0x10]
	strh r1, [sp, #0x62]
	b _01FF9624
_01FF9608:
	ldrsh r0, [r5, #0xec]
	mov r1, #1
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r9, r0, asr #0x10
	mov r10, r9
	strh r1, [sp, #0x62]
_01FF9624:
	ldr r0, [sp, #0x1c]
	mov r4, #0
	add r2, r7, r0
	add r3, r6, r9
	add r1, sp, #0x50
	mov r0, r5
	str r4, [sp, #0x5c]
	str r4, [sp, #0x58]
	str r3, [sp, #0x50]
	str r2, [sp, #0x54]
	bl ObjCollisionUnion
	mov r2, r0, lsl #0x18
	ldr r0, [sp, #0x10]
	add r4, r6, r10
	add r3, r7, r0
	str r4, [sp, #0x50]
	add r1, sp, #0x50
	mov r0, r5
	str r3, [sp, #0x54]
	mov r4, r2, asr #0x18
	bl ObjCollisionUnion
	mov r0, r0, lsl #0x18
	cmp r4, r0, asr #24
	mov r0, r0, asr #0x18
	movge r4, r0
	cmp r4, #0
	bgt _01FF970C
	ldr r1, [r5, #0x1c]
	mvn r0, #0xd
	orr r1, r1, #2
	str r1, [r5, #0x1c]
	cmp r4, r0
	blt _01FF970C
	ldrh r1, [sp, #0x62]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _01FF96C8
_01FF96B8: // jump table
	b _01FF96E0 // case 0
	b _01FF96D0 // case 1
	b _01FF96C8 // case 2
	b _01FF96D8 // case 3
_01FF96C8:
	add r7, r7, r4
	b _01FF96E4
_01FF96D0:
	sub r6, r6, r4
	b _01FF96E4
_01FF96D8:
	sub r7, r7, r4
	b _01FF96E4
_01FF96E0:
	add r6, r6, r4
_01FF96E4:
	ldr r0, [r5, #0x1c]
	tst r0, #0x4000
	bne _01FF970C
	ldr r0, [sp, #0x28]
	cmp r0, #0
	bge _01FF970C
	mov r0, #0
	tst r1, #2
	strne r0, [r5, #0x9c]
	streq r0, [r5, #0x98]
_01FF970C:
	ldr r1, [r5, #0x44]
	rsb r0, r6, r1, asr #12
	sub r0, r1, r0, lsl #12
	str r0, [r5, #0x44]
	ldr r1, [r5, #0x48]
	rsb r0, r7, r1, asr #12
	sub r0, r1, r0, lsl #12
	str r0, [r5, #0x48]
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

void ObjSetDiffCollision(OBS_DIFF_COLLISION *fCol)
{
    _obj_fCol = fCol;
}

s32 ObjDiffCollisionFast(OBS_COL_CHK_DATA *colWork)
{
    u16 dir;
    u32 attr;
    s32 lCol;
    s8 sPix;
    s8 sDelta = 8;

    if (_obj_fCol->diffCollision == NULL)
    {
        s32 dist;

        switch (colWork->vec)
        {
            case OBJ_COL_VEC_UP:
                dist = _obj_fCol->bottom - colWork->y;
                break;

            case OBJ_COL_VEC_DOWN:
                dist = colWork->y - _obj_fCol->top;
                break;

            case OBJ_COL_VEC_RIGHT:
                dist = colWork->x - _obj_fCol->left;
                break;

            case OBJ_COL_VEC_LEFT:
                dist = _obj_fCol->right - colWork->x;
                break;
        }

        return MTM_MATH_CLIP(dist, -31, 31);
    }

    if (colWork->dir != NULL)
        dir = *colWork->dir;

    if (colWork->attr != NULL)
        attr = *colWork->attr;

    if ((colWork->vec & OBJ_COL_VEC_FLIP) != 0)
        sDelta = -8;

    if ((colWork->vec & OBJ_COL_VEC_VERTICAL) != 0)
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

        return objMapGetForward(sPix, sDelta);
    }
    else
    {
        if (lCol == 8)
        {
            return objMapGetBack(sPix, sDelta);
        }
        else
        {
            return objMapGetDiff(lCol, sPix, sDelta);
        }
    }
}

NONMATCH_FUNC s32 ObjDiffCollision(OBS_COL_CHK_DATA *colWork)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	ldr r1, =_obj_fCol
	mov r5, #0
	ldr r2, [r1]
	mov r4, r0
	ldr r1, [r2]
	mov r6, r5
	mov r8, r5
	mov r9, r5
	cmp r1, #0
	bne _01FF9970
	ldrh r1, [r4, #0x12]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _01FF994C
_01FF9900: // jump table
	b _01FF9940 // case 0
	b _01FF9930 // case 1
	b _01FF9910 // case 2
	b _01FF9920 // case 3
_01FF9910:
	ldr r1, [r2, #0x28]
	ldr r0, [r4, #4]
	sub r0, r1, r0
	b _01FF994C
_01FF9920:
	ldr r1, [r4, #4]
	ldr r0, [r2, #0x20]
	sub r0, r1, r0
	b _01FF994C
_01FF9930:
	ldr r1, [r4]
	ldr r0, [r2, #0x1c]
	sub r0, r1, r0
	b _01FF994C
_01FF9940:
	ldr r1, [r2, #0x24]
	ldr r0, [r4]
	sub r0, r1, r0
_01FF994C:
	mvn r1, #0x1e
	cmp r0, r1
	addlt sp, sp, #8
	movlt r0, r1
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add sp, sp, #8
	cmp r0, #0x1f
	movgt r0, #0x1f
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9970:
	ldr r3, [r4, #8]
	cmp r3, #0
	ldrneh r0, [r3]
	strne r0, [sp, #4]
	ldr r0, [r4, #0xc]
	ldrh r1, [r4, #0x12]
	cmp r0, #0
	ldrne r11, [r0]
	ands r2, r1, #2
	beq _01FF99A8
	mov r9, #8
	tst r1, #1
	subne r9, r9, #0x10
	b _01FF99B4
_01FF99A8:
	mov r8, #8
	tst r1, #1
	subne r8, r8, #0x10
_01FF99B4:
	cmp r2, #0
	ldrne r1, [r4, #4]
	ldrne r7, =objGetMapColDataY
	ldreq r1, [r4]
	ldreq r7, =objGetMapColDataX
	str r0, [sp]
	and r1, r1, #7
	mov r1, r1, lsl #0x18
	mov r10, r1, asr #0x18
	ldrh r2, [r4, #0x10]
	ldmia r4, {r0, r1}
	blx r7
	cmp r0, #0
	bne _01FF9B78
	ldr r0, [r4, #0xc]
	add r5, r5, r8
	str r0, [sp]
	ldrh r2, [r4, #0x10]
	add r6, r6, r9
	ldmia r4, {r0, r1, r3}
	add r0, r0, r5
	add r1, r1, r6
	blx r7
	cmp r0, #0
	bne _01FF9B00
	ldr r1, [r4, #0xc]
	add r0, r5, r8
	str r1, [sp]
	ldr r5, [r4]
	ldrh r2, [r4, #0x10]
	add r6, r6, r9
	ldmib r4, {r1, r3}
	add r0, r5, r0
	add r1, r1, r6
	blx r7
	cmp r0, #0
	bne _01FF9A88
	ldr r1, [r4, #8]
	cmp r1, #0
	ldrne r0, [sp, #4]
	add sp, sp, #8
	strneh r0, [r1]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	strne r11, [r0]
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	rsbgt r0, r10, #8
	addle r0, r10, #1
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9A88:
	cmp r0, #8
	bne _01FF9AB8
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	suble r0, r10, #8
	add sp, sp, #8
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9AB8:
	add r1, r8, r9
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FF9AE0
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r10, #1
	subgt r0, r0, r1
	rsble r0, r10, #8
	b _01FF9AF4
_01FF9AE0:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	addle r0, r0, r10
_01FF9AF4:
	add sp, sp, #8
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9B00:
	cmp r0, #8
	bne _01FF9B30
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	suble r0, r10, #8
	add sp, sp, #8
	add r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9B30:
	add r1, r8, r9
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FF9B58
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r10, #1
	subgt r0, r0, r1
	rsble r0, r10, #8
	b _01FF9B6C
_01FF9B58:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	addle r0, r0, r10
_01FF9B6C:
	add sp, sp, #8
	add r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9B78:
	cmp r0, #8
	bne _01FF9D50
	ldr r3, [r4, #8]
	sub r5, r5, r8
	cmp r3, #0
	ldrneh r0, [r3]
	sub r6, r6, r9
	strne r0, [sp, #4]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldrne r11, [r0]
	str r0, [sp]
	ldmia r4, {r0, r1}
	ldrh r2, [r4, #0x10]
	add r0, r0, r5
	add r1, r1, r6
	blx r7
	cmp r0, #8
	bne _01FF9CC0
	ldr r3, [r4, #8]
	sub ip, r5, r8
	cmp r3, #0
	ldrneh r0, [r3]
	sub r5, r6, r9
	strne r0, [sp, #4]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldrne r11, [r0]
	str r0, [sp]
	ldmia r4, {r0, r1}
	ldrh r2, [r4, #0x10]
	add r0, r0, ip
	add r1, r1, r5
	blx r7
	cmp r0, #0
	bne _01FF9C48
	ldr r1, [r4, #8]
	cmp r1, #0
	ldrne r0, [sp, #4]
	add sp, sp, #8
	strneh r0, [r1]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	strne r11, [r0]
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r10, #1
	rsbgt r10, r0, #8
	sub r0, r10, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9C48:
	cmp r0, #8
	bne _01FF9C78
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	suble r0, r10, #8
	add sp, sp, #8
	sub r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9C78:
	add r1, r8, r9
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FF9CA0
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r10, #1
	subgt r0, r0, r1
	rsble r0, r10, #8
	b _01FF9CB4
_01FF9CA0:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	addle r0, r0, r10
_01FF9CB4:
	add sp, sp, #8
	sub r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9CC0:
	cmp r0, #0
	bne _01FF9D08
	ldr r1, [r4, #8]
	cmp r1, #0
	ldrne r0, [sp, #4]
	add sp, sp, #8
	strneh r0, [r1]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	strne r11, [r0]
	add r0, r8, r9
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r10, #1
	rsbgt r10, r0, #8
	sub r0, r10, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9D08:
	add r1, r8, r9
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FF9D30
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r10, #1
	subgt r0, r0, r1
	rsble r0, r10, #8
	b _01FF9D44
_01FF9D30:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	addle r0, r0, r10
_01FF9D44:
	add sp, sp, #8
	sub r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9D50:
	add r1, r8, r9
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FF9D7C
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r10, #1
	subgt r0, r0, r1
	add sp, sp, #8
	rsble r0, r10, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FF9D7C:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r10, #1
	rsbgt r0, r0, #0
	addle r0, r0, r10
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

NONMATCH_FUNC u16 objGetMapBlockData(s32 pos_x, s32 pos_y, s32 suf)
{
    // https://decomp.me/scratch/pAhBt -> 85.19%
#ifdef NON_MATCHING
    fx32 x2 = (pos_x >> 3);
    fx32 y2 = (pos_y >> 3);
    fx32 x3 = (x2 / 8);
    fx32 y3 = (y2 / 8);

    u16 block = _obj_fCol->mapLayout[suf][_obj_fCol->blockWidth * y3 + x3];
    s32 bx    = x2 - (x3 << 3);
    s32 by    = y2 - (y3 << 3);

    int offset = (bx + (by * 8));
    return _obj_fCol->mapBlockset[offset + (block << 7)];
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, =_obj_fCol
	mov ip, r1, asr #3
	ldr r1, [r3]
	mov r3, ip, asr #2
	ldrh lr, [r1, #0x18]
	add r3, ip, r3, lsr #29
	mov r3, r3, asr #3
	mul r4, lr, r3
	mov r6, r0, asr #3
	mov r0, r6, asr #2
	add r0, r6, r0, lsr #29
	add lr, r1, r2, lsl #2
	add r2, r4, r0, asr #3
	mov r5, r0, asr #3
	ldr r4, [lr, #0xc]
	mov r0, r2, lsl #1
	ldrh r0, [r4, r0]
	sub r4, r6, r5, lsl #3
	sub r2, ip, r3, lsl #3
	add r2, r4, r2, lsl #3
	mov r0, r0, lsl #7
	ldr r1, [r1, #8]
	add r0, r0, r2, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r4, r5, r6, pc}
// clang-format on
#endif
}

NONMATCH_FUNC s32 objGetMapColDataX(fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    // https://decomp.me/scratch/dHgfS -> 72.96%
#ifdef NON_MATCHING
    s8 xDiff;

    if ((flags & 64) != 0)
    {
        if ((lPosX & ~7) > _obj_fCol->right - 1 || lPosX < _obj_fCol->left - 7)
            return 8;

        if (((lPosX & ~7) + 8) > _obj_fCol->right - 1)
        {
            xDiff = (_obj_fCol->right - 1 & 7);
            if (xDiff == 0)
                xDiff = 8;

            return xDiff;
        }

        if ((lPosX & ~7) < _obj_fCol->left)
        {
            if ((_obj_fCol->left & 7) != 0)
                xDiff = 16 - (_obj_fCol->left & 7);
            else
                xDiff = 8;

            xDiff |= -16;

            if (xDiff == -8)
                xDiff = 8;

            return xDiff;
        }

        if (lPosY > _obj_fCol->bottom - 1 || lPosY < _obj_fCol->top)
            return 8;
    }
    else
    {
        // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
        fx32 newPos = _obj_fCol->left;
        if (newPos >= _obj_fCol->left)
        {
            newPos = _obj_fCol->right - 1;
            if (lPosX <= _obj_fCol->right - 1)
            {
                newPos = lPosX;
            }
        }
        lPosX = newPos;

        // clamp func, neither MTM_MATH_CLIP or MTM_MATH_CLIP_2 got it to match though
        newPos = _obj_fCol->top;
        if (newPos >= _obj_fCol->top)
        {
            newPos = _obj_fCol->bottom - 1;
            if (lPosX <= _obj_fCol->bottom - 1)
            {
                newPos = lPosY;
            }
        }
        lPosY = newPos;
    }

    u16 mapTile   = objGetMapBlockData(lPosX, lPosY, flags & 1);
    u16 tileID    = mapTile & 0x3FF;
    u32 tileFlipY = mapTile & 0x800;

    int conv_pos_y = lPosY & 7;
    if ((mapTile & 0x800) != 0)
        conv_pos_y = 7 - conv_pos_y;

    xDiff = _obj_fCol->diffCollision[(8 * tileID) + conv_pos_y] & 0xF;

    if ((xDiff & 8) != 0)
        xDiff |= -16;

    if (xDiff == -8)
        xDiff = 8;

    if ((flags & 128) != 0 && (_obj_fCol->attrCollision[tileID] & 1) != 0)
        xDiff = 0;

    if ((mapTile & 0x400) == 0 && xDiff == 0)
    {
        xDiff += 8;
    }
    else if (((mapTile & 0x400) != 0 && xDiff == 8))
    {
        xDiff -= 8;
    }

    if (pDir != NULL && xDiff != 0)
    {
        u16 dir = _obj_fCol->dirCollision[tileID] << 8;

        if (tileFlipY != 0)
        {
            dir = -(s16)dir - 0x8000;
        }

        if ((mapTile & 0x400) != 0 && xDiff != 0)
        {
            dir = -(s16)dir;
        }

        *pDir = dir;
    }

    if (pAttr != NULL && xDiff != 0)
        *pAttr = _obj_fCol->attrCollision[tileID];

    return xDiff;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r6, r1
	mov r4, r3
	tst r5, #0x40
	beq _01FF9EE0
	ldr r1, =_obj_fCol
	bic r3, r0, #7
	ldr lr, [r1]
	ldr r1, [lr, #0x24]
	sub ip, r1, #1
	cmp r3, ip
	bgt _01FF9E54
	ldr r2, [lr, #0x1c]
	sub r1, r2, #7
	cmp r0, r1
	bge _01FF9E5C
_01FF9E54:
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FF9E5C:
	add r1, r3, #8
	cmp r1, ip
	ble _01FF9E7C
	and r0, ip, #7
	mov r0, r0, lsl #0x18
	movs r0, r0, asr #0x18
	moveq r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FF9E7C:
	cmp r3, r2
	bge _01FF9EBC
	ands r0, r2, #7
	moveq r0, #8
	beq _01FF9E9C
	rsb r0, r0, #0x10
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FF9E9C:
	mvn r1, #0xf
	orr r0, r0, r1
	mov r0, r0, lsl #0x18
	add r1, r1, #8
	cmp r1, r0, asr #24
	mov r0, r0, asr #0x18
	moveq r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FF9EBC:
	ldr r1, [lr, #0x28]
	sub r1, r1, #1
	cmp r6, r1
	bgt _01FF9ED8
	ldr r1, [lr, #0x20]
	cmp r6, r1
	bge _01FF9F28
_01FF9ED8:
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FF9EE0:
	ldr r1, =_obj_fCol
	ldr r2, [r1]
	ldr r1, [r2, #0x1c]
	cmp r0, r1
	blt _01FF9F04
	ldr r1, [r2, #0x24]
	sub r1, r1, #1
	cmp r0, r1
	movle r1, r0
_01FF9F04:
	ldr r3, [r2, #0x20]
	mov r0, r1
	cmp r6, r3
	blt _01FF9F24
	ldr r1, [r2, #0x28]
	sub r3, r1, #1
	cmp r6, r3
	movle r3, r6
_01FF9F24:
	mov r6, r3
_01FF9F28:
	and r2, r5, #1
	mov r1, r6
	bl objGetMapBlockData
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldr r1, =0x000003FF
	and r6, r6, #7
	and r0, r1, r0, lsr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, =_obj_fCol
	ands ip, r2, #0x800
	ldr r3, [r0]
	rsbne r6, r6, #7
	ldr r0, [r3]
	add r0, r0, r1, lsl #3
	ldrsb r0, [r6, r0]
	and r0, r0, #0xf
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	tst r0, #8
	beq _01FF9F90
	mvn r6, #0xf
	orr r0, r0, r6
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FF9F90:
	mvn r6, #7
	cmp r0, r6
	moveq r0, #8
	tst r5, #0x80
	beq _01FF9FB4
	ldr r5, [r3, #0x14]
	ldrb r5, [r5, r1]
	tst r5, #1
	movne r0, #0
_01FF9FB4:
	ands r2, r2, #0x400
	cmpne r0, #8
	cmpne r0, #0
	beq _01FF9FE0
	addle r0, r0, #8
	movle r0, r0, lsl #0x18
	movle r0, r0, asr #0x18
	ble _01FF9FE0
	sub r0, r0, #8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FF9FE0:
	cmp r4, #0
	cmpne r0, #0
	beq _01FFA040
	ldr r3, [r3, #4]
	cmp ip, #0
	ldrb r3, [r3, r1]
	mov r3, r3, lsl #0x18
	mov r3, r3, lsr #0x10
	beq _01FFA01C
	mov r5, #0x8000
	mov r3, r3, lsl #0x10
	rsb r5, r5, #0
	sub r3, r5, r3, asr #16
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
_01FFA01C:
	cmp r2, #0
	cmpne r0, #0
	beq _01FFA03C
	mov r2, r3, lsl #0x10
	mov r2, r2, asr #0x10
	rsb r2, r2, #0
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_01FFA03C:
	strh r3, [r4]
_01FFA040:
	ldr r3, [sp, #0x10]
	cmp r3, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, =_obj_fCol
	ldr r2, [r2]
	ldr r2, [r2, #0x14]
	ldrb r1, [r2, r1]
	str r1, [r3]
	ldmia sp!, {r4, r5, r6, pc}
// clang-format on
#endif
}

NONMATCH_FUNC s32 objGetMapColDataY(fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r6, r0
	mov r4, r3
	tst r5, #0x40
	beq _01FFA140
	ldr r0, =_obj_fCol
	bic r3, r1, #7
	ldr lr, [r0]
	ldr r0, [lr, #0x28]
	sub ip, r0, #1
	cmp r3, ip
	bgt _01FFA0B4
	ldr r2, [lr, #0x20]
	sub r0, r2, #7
	cmp r1, r0
	bge _01FFA0BC
_01FFA0B4:
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FFA0BC:
	add r0, r3, #8
	cmp r0, ip
	ble _01FFA0DC
	and r0, ip, #7
	mov r0, r0, lsl #0x18
	movs r0, r0, asr #0x18
	moveq r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FFA0DC:
	cmp r3, r2
	bge _01FFA11C
	ands r0, r2, #7
	moveq r0, #8
	beq _01FFA0FC
	rsb r0, r0, #0x10
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FFA0FC:
	mvn r1, #0xf
	orr r0, r0, r1
	mov r0, r0, lsl #0x18
	add r1, r1, #8
	cmp r1, r0, asr #24
	mov r0, r0, asr #0x18
	moveq r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FFA11C:
	ldr r0, [lr, #0x24]
	sub r0, r0, #1
	cmp r6, r0
	bgt _01FFA138
	ldr r0, [lr, #0x1c]
	cmp r6, r0
	bge _01FFA188
_01FFA138:
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_01FFA140:
	ldr r0, =_obj_fCol
	ldr r2, [r0]
	ldr r0, [r2, #0x1c]
	cmp r6, r0
	blt _01FFA164
	ldr r0, [r2, #0x24]
	sub r0, r0, #1
	cmp r6, r0
	movle r0, r6
_01FFA164:
	ldr r3, [r2, #0x20]
	mov r6, r0
	cmp r1, r3
	blt _01FFA184
	ldr r0, [r2, #0x28]
	sub r3, r0, #1
	cmp r1, r3
	movle r3, r1
_01FFA184:
	mov r1, r3
_01FFA188:
	and r2, r5, #1
	mov r0, r6
	bl objGetMapBlockData
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldr r1, =0x000003FF
	and r6, r6, #7
	and r0, r1, r0, lsr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, =_obj_fCol
	ands ip, r2, #0x400
	ldr r3, [r0]
	rsbne r6, r6, #7
	ldr r0, [r3]
	add r0, r0, r1, lsl #3
	ldrsb r0, [r6, r0]
	mov r0, r0, lsl #0x14
	mov r0, r0, asr #0x18
	tst r0, #8
	beq _01FFA1EC
	mvn r6, #0xf
	orr r0, r0, r6
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FFA1EC:
	mvn r6, #7
	cmp r0, r6
	moveq r0, #8
	tst r5, #0x80
	beq _01FFA210
	ldr r5, [r3, #0x14]
	ldrb r5, [r5, r1]
	tst r5, #1
	movne r0, #0
_01FFA210:
	ands r2, r2, #0x800
	cmpne r0, #8
	cmpne r0, #0
	beq _01FFA23C
	addle r0, r0, #8
	movle r0, r0, lsl #0x18
	movle r0, r0, asr #0x18
	ble _01FFA23C
	sub r0, r0, #8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
_01FFA23C:
	cmp r4, #0
	cmpne r0, #0
	beq _01FFA29C
	ldr r3, [r3, #4]
	cmp ip, #0
	ldrb r3, [r3, r1]
	mov r3, r3, lsl #0x18
	mov r5, r3, lsr #0x10
	beq _01FFA274
	mov r3, r5, lsl #0x10
	mov r3, r3, asr #0x10
	rsb r3, r3, #0
	mov r3, r3, lsl #0x10
	mov r5, r3, lsr #0x10
_01FFA274:
	cmp r2, #0
	cmpne r0, #0
	beq _01FFA298
	mov r3, #0x8000
	mov r2, r5, lsl #0x10
	rsb r3, r3, #0
	sub r2, r3, r2, asr #16
	mov r2, r2, lsl #0x10
	mov r5, r2, lsr #0x10
_01FFA298:
	strh r5, [r4]
_01FFA29C:
	ldr r3, [sp, #0x10]
	cmp r3, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, =_obj_fCol
	ldr r2, [r2]
	ldr r2, [r2, #0x14]
	ldrb r1, [r2, r1]
	str r1, [r3]
	ldmia sp!, {r4, r5, r6, pc}
// clang-format on
#endif
}

void ObjCollisionObjectRegist(StageTaskCollisionObj *work)
{
    if (_obj_collision_num.nextCount < OBJ_COLLISION_REGISTRATION_MAX)
    {
        StageTask *parent = work->parent;
        if (parent == NULL || (parent->flag & ((STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED))) == 0)
        {
            if ((work->riderObj != NULL && work->riderObj->rideObj != work->parent))
                work->riderObj = NULL;

            if (work->toucherObj != NULL && work->toucherObj->touchObj != work->parent)
                work->toucherObj = NULL;

            _obj_collision_tbl_nx[_obj_collision_num.nextCount] = work;
            _obj_collision_num.nextCount++;

            VecFx32 position = { 0, 0, 0 };
            position         = work->pos;
            if (work->parent != NULL && (work->flag & STAGE_TASK_OBJCOLLISION_FLAG_10) == 0)
            {
                position.x += work->parent->position.x;
                position.y += work->parent->position.y;
                position.z += work->parent->position.z;
            }
            work->check_pos = position;

            work->flag &= ~(STAGE_TASK_OBJCOLLISION_FLAG_40000000 | STAGE_TASK_OBJCOLLISION_FLAG_80000000);
            if (work->parent != NULL)
            {
                if ((work->parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_40000000;

                if ((work->parent->displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_80000000;
            }
            else
            {
                if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_1) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_40000000;

                if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_2) != 0)
                    work->flag |= STAGE_TASK_OBJCOLLISION_FLAG_80000000;
            }

            objCollsionOffsetSet(work, &work->check_ofst.x, &work->check_ofst.y);

            work->left   = FX32_TO_WHOLE(work->check_pos.x) + work->check_ofst.x;
            work->top    = FX32_TO_WHOLE(work->check_pos.y) + work->check_ofst.y;
            work->right  = FX32_TO_WHOLE(work->check_pos.x) + work->width + work->check_ofst.x;
            work->bottom = FX32_TO_WHOLE(work->check_pos.y) + work->height + work->check_ofst.y;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40) == 0)
                work->check_dir = work->dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_20) == 0)
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

    for (i = 0; i < _obj_collision_num.nextCount; i++)
    {
        _obj_collision_tbl[i] = _obj_collision_tbl_nx[i];
    }

    for (; i < OBJ_COLLISION_REGISTRATION_MAX; i++)
    {
        _obj_collision_tbl_nx[i] = NULL;
    }

    _obj_collision_num.count     = _obj_collision_num.nextCount;
    _obj_collision_num.nextCount = 0;
}

void objCollsionOffsetSet(StageTaskCollisionObj *work, s16 *offsetX, s16 *offsetY)
{
    *offsetX = work->ofst_x;
    *offsetY = work->ofst_y;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
        *offsetX = (s16)(-work->ofst_x - work->width);

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
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

    if (_obj_collision_num.count == 0)
        return penetration;

    for (index = 0; index < _obj_collision_num.count; ++index)
    {
        StageTaskCollisionObj *collisionWork = _obj_collision_tbl[index];

        if (collisionWork->parent != NULL && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_100) == 0)
        {
            colWorkCopy.x = colWork->x;
            colWorkCopy.y = colWork->y;
            if ((collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_4) != 0 && collisionWork->check_dir != FLOAT_DEG_TO_IDX(0.0))
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
                        case OBJ_COL_VEC_RIGHT:
                            if (collisionWork->parent->move.x > 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;

                        case OBJ_COL_VEC_LEFT:
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
                    case OBJ_COL_VEC_UP:
                        objPenetration = collisionWork->top - y;
                        break;

                    case OBJ_COL_VEC_DOWN:
                        objPenetration = y - collisionWork->bottom;
                        break;

                    case OBJ_COL_VEC_RIGHT:
                        objPenetration = x - collisionWork->right;
                        if (objPenetration == 0 && collisionWork->parent->move.x > 0)
                        {
                            objPenetration--;
                            break;
                        }
                        break;

                    case OBJ_COL_VEC_LEFT:
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

    if (_obj_collision_num.count == 0)
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
            if (colWork->vec == OBJ_COL_VEC_UP && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.y >= 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 1:
            if (colWork->vec == OBJ_COL_VEC_RIGHT && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.x < 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 2:
            if (colWork->vec == OBJ_COL_VEC_DOWN && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.y < 0))
            {
                isRiding = TRUE;
                break;
            }
            break;

        case 3:
            if (colWork->vec == OBJ_COL_VEC_LEFT && ((work->moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 || work->move.x > 0))
            {
                isRiding = TRUE;
                break;
            }
            break;
    }

    for (u16 index = 0; index < _obj_collision_num.count; ++index)
    {
        StageTaskCollisionObj *collisionWork = _obj_collision_tbl[index];

        if (collisionWork->parent != work && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_100) == 0)
        {
            colWorkCopy.x = colWork->x;
            colWorkCopy.y = colWork->y;
            if ((collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_4) != 0 && collisionWork->check_dir != FLOAT_DEG_TO_IDX(0.0))
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
                        case OBJ_COL_VEC_RIGHT:
                            if (collisionWork->parent != NULL && collisionWork->parent->move.x > 0)
                            {
                                objPenetration--;
                                break;
                            }
                            break;

                        case OBJ_COL_VEC_LEFT:
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
                    case OBJ_COL_VEC_UP:
                        if (colWorkCopy.y < collisionWork->bottom && colWorkCopy.x > collisionWork->left && colWorkCopy.x < collisionWork->right)
                        {
                            distance = collisionWork->top - colWorkCopy.y;
                            break;
                        }
                        break;

                    case OBJ_COL_VEC_DOWN:
                        if (collisionWork->top < colWorkCopy.y && colWorkCopy.x > collisionWork->left && colWorkCopy.x < collisionWork->right)
                        {
                            distance = colWorkCopy.y - collisionWork->bottom;
                            break;
                        }
                        break;

                    case OBJ_COL_VEC_RIGHT:
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

                    case OBJ_COL_VEC_LEFT:
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

                    if (colWork->attr != NULL && (collisionWork->flag & STAGE_TASK_OBJCOLLISION_FLAG_80) == 0)
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
    s8 sDelta = 8;

    if (colWork->dir != NULL)
        dir = *colWork->dir;

    if (colWork->attr != NULL)
        attr = *colWork->attr;

    if ((colWork->vec & OBJ_COL_VEC_FLIP) != 0)
        sDelta = -8;

    if ((colWork->vec & OBJ_COL_VEC_VERTICAL) != 0)
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

        return objMapGetForward(sPix, sDelta);
    }
    else
    {
        if (lCol == 8)
        {
            return objMapGetBack(sPix, sDelta);
        }
        else
        {
            return objMapGetDiff(lCol, sPix, sDelta);
        }
    }
}

NONMATCH_FUNC s32 objCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork)
{
    // https://decomp.me/scratch/QhDIC -> 74.48%
#ifdef NON_MATCHING
    s32 offsetX = 0;
    s32 offsetY = 0;
    u32 attr    = 0;
    u16 dir     = 0;
    s8 stepX    = 0;
    s8 stepY    = 0;

    if (colWork->dir != NULL)
        dir = *colWork->dir;

    if (colWork->attr != NULL)
        attr = *colWork->attr;

    if ((colWork->vec & 2) != 0)
    {
        stepY = 8;
        if ((colWork->vec & 1) != 0)
            stepY = -8;
    }
    else
    {
        stepX = 8;
        if ((colWork->vec & 1) != 0)
            stepX = -8;
    }

    s8 sPix;
    s32 (*objGetColData)(StageTaskCollisionObj *work, fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
    if ((colWork->vec & 2) != 0)
    {
        sPix          = (colWork->y - work->top & 7);
        objGetColData = objGetColDataY;
    }
    else
    {
        sPix          = (colWork->x - work->left & 7);
        objGetColData = objGetColDataX;
    }

    s32 lCol1 = objGetColData(work, colWork->x, colWork->y, colWork->flag, colWork->dir, colWork->attr);
    if (lCol1 == 0)
    {
        offsetX   = stepX;
        offsetY   = stepY;
        s32 lCol2 = objGetColData(work, colWork->x + offsetX, colWork->y + offsetY, colWork->flag, colWork->dir, colWork->attr);
        if (lCol2 == 0)
        {
            offsetX += stepX;
            offsetY += stepY;
            s32 lCol3 = objGetColData(work, colWork->x + offsetX, colWork->y + offsetY, colWork->flag, colWork->dir, colWork->attr);
            if (lCol3 == 0)
            {
                if (colWork->dir != NULL)
                    *colWork->dir = dir;

                if (colWork->attr != NULL)
                    *colWork->attr = attr;

                return objMapGetForward(sPix, stepX + stepY) + 16;
            }
            else
            {
                if (lCol3 == 8)
                {
                    return objMapGetBack(sPix, stepX + stepY) + 16;
                }
                else
                {
                    return objMapGetDiff(lCol3, sPix, stepX + stepY) + 16;
                }
            }
        }
        else
        {
            if (lCol2 == 8)
            {
                return objMapGetBack(sPix, stepX + stepY) + 8;
            }
            else
            {
                return objMapGetDiff(lCol2, sPix, stepX + stepY) + 8;
            }
        }
    }
    else
    {
        if (lCol1 == 8)
        {
            if (colWork->dir != NULL)
                dir = *colWork->dir;

            if (colWork->attr != NULL)
                attr = *colWork->attr;

            offsetX   = -stepX;
            offsetY   = -stepY;
            s32 lCol4 = objGetColData(work, colWork->x + offsetX, colWork->y + offsetY, colWork->flag, colWork->dir, colWork->attr);
            if (lCol4 == 8)
            {
                if (colWork->dir != NULL)
                    dir = *colWork->dir;

                if (colWork->attr != NULL)
                    attr = *colWork->attr;

                offsetX += -stepX;
                offsetY += -stepY;
                s32 lCol5 = objGetColData(work, colWork->x + offsetX, colWork->y + offsetY, colWork->flag, colWork->dir, colWork->attr);
                if (lCol5 == 0)
                {
                    if (colWork->dir != NULL)
                        *colWork->dir = dir;

                    if (colWork->attr != NULL)
                        *colWork->attr = attr;

                    return objMapGetForwardRev(sPix, stepX + stepY) - 16;
                }
                else
                {
                    if (lCol5 == 8)
                    {
                        return objMapGetBack(sPix, stepX + stepY) - 16;
                    }
                    else
                    {
                        return objMapGetDiff(lCol5, sPix, stepX + stepY) - 16;
                    }
                }
            }
            else
            {
                if (lCol4 == 0)
                {
                    if (colWork->dir != NULL)
                        *colWork->dir = dir;

                    if (colWork->attr != NULL)
                        *colWork->attr = attr;

                    return objMapGetForwardRev(sPix, stepX + stepY) - 8;
                }
                else
                {
                    return objMapGetDiff(lCol4, sPix, stepX + stepY) - 8;
                }
            }
        }
        else
        {
            return objMapGetDiff(lCol1, sPix, stepX + stepY);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r10, r1
	ldr r1, [r10, #8]
	mov r4, #0
	mov r11, r0
	cmp r1, #0
	ldrneh r0, [r1]
	mov r5, r4
	mov r7, r4
	strne r0, [sp, #8]
	ldr r0, [r10, #0xc]
	mov r8, r4
	cmp r0, #0
	ldrne r2, [r0]
	strne r2, [sp, #0xc]
	ldrh r2, [r10, #0x12]
	ands r3, r2, #2
	beq _01FFAE38
	mov r8, #8
	tst r2, #1
	subne r8, r8, #0x10
	b _01FFAE44
_01FFAE38:
	mov r7, #8
	tst r2, #1
	subne r7, r7, #0x10
_01FFAE44:
	cmp r3, #0
	ldreq r3, [r10]
	ldreq r2, [r11, #0x44]
	ldreq r6, =objGetColDataX
	beq _01FFAE64
	ldr r3, [r10, #4]
	ldr r2, [r11, #0x48]
	ldr r6, =objGetColDataY
_01FFAE64:
	str r1, [sp]
	str r0, [sp, #4]
	sub r2, r3, r2
	and r2, r2, #7
	mov r2, r2, lsl #0x18
	mov r9, r2, asr #0x18
	ldrh r3, [r10, #0x10]
	mov r0, r11
	ldmia r10, {r1, r2}
	blx r6
	cmp r0, #0
	bne _01FFB040
	ldr r0, [r10, #8]
	add r4, r4, r7
	str r0, [sp]
	ldr r0, [r10, #0xc]
	add r5, r5, r8
	str r0, [sp, #4]
	ldr r1, [r10]
	ldr r0, [r10, #4]
	add r1, r1, r4
	add r2, r0, r5
	mov r0, r11
	ldrh r3, [r10, #0x10]
	blx r6
	cmp r0, #0
	bne _01FFAFC8
	ldr r0, [r10, #8]
	add r1, r4, r7
	str r0, [sp]
	ldr r0, [r10, #0xc]
	add r2, r5, r8
	str r0, [sp, #4]
	ldr r5, [r10]
	ldr r4, [r10, #4]
	ldrh r3, [r10, #0x10]
	mov r0, r11
	add r1, r5, r1
	add r2, r4, r2
	blx r6
	cmp r0, #0
	bne _01FFAF50
	ldr r1, [r10, #8]
	cmp r1, #0
	ldrne r0, [sp, #8]
	strneh r0, [r1]
	ldr r1, [r10, #0xc]
	cmp r1, #0
	ldrne r0, [sp, #0xc]
	add sp, sp, #0x10
	strne r0, [r1]
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	rsbgt r0, r9, #8
	addle r0, r9, #1
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFAF50:
	cmp r0, #8
	bne _01FFAF80
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	suble r0, r9, #8
	add sp, sp, #0x10
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFAF80:
	add r1, r7, r8
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FFAFA8
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r9, #1
	subgt r0, r0, r1
	rsble r0, r9, #8
	b _01FFAFBC
_01FFAFA8:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	addle r0, r0, r9
_01FFAFBC:
	add sp, sp, #0x10
	add r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFAFC8:
	cmp r0, #8
	bne _01FFAFF8
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	suble r0, r9, #8
	add sp, sp, #0x10
	add r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFAFF8:
	add r1, r7, r8
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FFB020
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r9, #1
	subgt r0, r0, r1
	rsble r0, r9, #8
	b _01FFB034
_01FFB020:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	addle r0, r0, r9
_01FFB034:
	add sp, sp, #0x10
	add r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB040:
	cmp r0, #8
	bne _01FFB234
	ldr r1, [r10, #8]
	sub r4, r4, r7
	cmp r1, #0
	ldrneh r0, [r1]
	sub r5, r5, r8
	strne r0, [sp, #8]
	ldr r2, [r10, #0xc]
	cmp r2, #0
	ldrne r0, [r2]
	stmia sp, {r1, r2}
	strne r0, [sp, #0xc]
	ldr r1, [r10]
	ldr r0, [r10, #4]
	ldrh r3, [r10, #0x10]
	add r2, r0, r5
	add r1, r1, r4
	mov r0, r11
	blx r6
	cmp r0, #8
	bne _01FFB1A0
	ldr r1, [r10, #8]
	sub ip, r4, r7
	cmp r1, #0
	ldrneh r0, [r1]
	sub r4, r5, r8
	strne r0, [sp, #8]
	ldr r2, [r10, #0xc]
	cmp r2, #0
	ldrne r0, [r2]
	stmia sp, {r1, r2}
	ldmia r10, {r1, r2}
	strne r0, [sp, #0xc]
	ldrh r3, [r10, #0x10]
	mov r0, r11
	add r1, r1, ip
	add r2, r2, r4
	blx r6
	cmp r0, #0
	bne _01FFB128
	ldr r1, [r10, #8]
	cmp r1, #0
	ldrne r0, [sp, #8]
	strneh r0, [r1]
	ldr r1, [r10, #0xc]
	cmp r1, #0
	ldrne r0, [sp, #0xc]
	add sp, sp, #0x10
	strne r0, [r1]
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r9, #1
	rsbgt r9, r0, #8
	sub r0, r9, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB128:
	cmp r0, #8
	bne _01FFB158
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	suble r0, r9, #8
	add sp, sp, #0x10
	sub r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB158:
	add r1, r7, r8
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FFB180
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r9, #1
	subgt r0, r0, r1
	rsble r0, r9, #8
	b _01FFB194
_01FFB180:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	addle r0, r0, r9
_01FFB194:
	add sp, sp, #0x10
	sub r0, r0, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB1A0:
	cmp r0, #0
	bne _01FFB1EC
	ldr r1, [r10, #8]
	cmp r1, #0
	ldrne r0, [sp, #8]
	strneh r0, [r1]
	ldr r1, [r10, #0xc]
	cmp r1, #0
	ldrne r0, [sp, #0xc]
	add sp, sp, #0x10
	strne r0, [r1]
	add r0, r7, r8
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0
	addgt r0, r9, #1
	rsbgt r9, r0, #8
	sub r0, r9, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB1EC:
	add r1, r7, r8
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FFB214
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r9, #1
	subgt r0, r0, r1
	rsble r0, r9, #8
	b _01FFB228
_01FFB214:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	addle r0, r0, r9
_01FFB228:
	add sp, sp, #0x10
	sub r0, r0, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB234:
	add r1, r7, r8
	cmp r0, #0
	mov r1, r1, lsl #0x18
	ble _01FFB260
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r1, r9, #1
	subgt r0, r0, r1
	add sp, sp, #0x10
	rsble r0, r9, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_01FFB260:
	mov r1, r1, asr #0x18
	cmp r1, #0
	addgt r0, r9, #1
	rsbgt r0, r0, #0
	addle r0, r0, r9
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

s32 objGetColDataX(StageTaskCollisionObj *work, fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    u16 tile;
    s32 depth;
    s8 penetration;
    u16 x;
    u16 y;

    if (lPosX < work->left || lPosX >= work->right)
        return 0;

    if (lPosY < work->top || lPosY >= work->bottom)
        return 0;

    x = (lPosX - work->left) >> 3;
    y = (lPosY - work->top) >> 3;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
        x = (work->width >> 3) - 1 - x;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
        y = (work->height >> 3) - 1 - y;

    tile = x + y * (work->width >> 3);

    depth = (lPosY - work->top) & 7;
    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
        depth = 7 - depth;

    penetration = ((s8)work->diff_data[(tile << 3) + depth] & 15);
    if ((penetration & 8) != 0)
        penetration |= -16;

    if (penetration == -8)
        penetration = 8;

    if (work->attr_data != NULL)
    {
        if ((flags & OBJ_COL_FLAG_80) != 0 && ((work->attr_data[tile >> 3] & 1) != 0 || (work->attr & 1) != 0))
            penetration = 0;
    }
    else
    {
        if ((flags & OBJ_COL_FLAG_80) != 0 && (work->attr & 1) != 0)
            penetration = 0;
    }

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0 && penetration != 8 && penetration != 0)
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

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_4) != 0)
            dir += work->check_dir;

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_8) != 0)
        {
            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
                dir = -(s16)dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
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

s32 objGetColDataY(StageTaskCollisionObj *work, fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr)
{
    u16 tile;
    s32 depth;
    s8 penetration;
    u16 x;
    u16 y;

    if (lPosX < work->left || lPosX >= work->right)
        return 0;

    if (lPosY < work->top || lPosY >= work->bottom)
        return 0;

    x = (lPosX - work->left) >> 3;
    y = (lPosY - work->top) >> 3;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
        x = (work->width >> 3) - 1 - x;

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
        y = (work->height >> 3) - 1 - y;

    tile = x + y * (work->width >> 3);

    depth = (lPosX - work->left) & 7;
    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
        depth = 7 - depth;

    penetration = ((s32)(s8)((s8)work->diff_data[(tile << 3) + depth] >> 4));
    if ((penetration & 8) != 0)
        penetration |= -16;

    if (penetration == -8)
        penetration = 8;

    if (work->attr_data != NULL)
    {
        if ((flags & OBJ_COL_FLAG_80) != 0 && ((work->attr_data[tile >> 3] & 1) != 0 || (work->attr & 1) != 0))
            penetration = 0;
    }
    else
    {
        if ((flags & OBJ_COL_FLAG_80) != 0 && (work->attr & 1) != 0)
            penetration = 0;
    }

    if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0 && penetration != 8 && penetration != 0)
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

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_4) != 0)
            dir += work->check_dir;

        if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_8) != 0)
        {
            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_40000000) != 0)
                dir = -(s16)dir;

            if ((work->flag & STAGE_TASK_OBJCOLLISION_FLAG_80000000) != 0)
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
