#include <ex/system/exHitCheck.h>
#include <ex/system/exSystem.h>
#include <ex/player/exPlayer.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/effects/exBlazeDashEffect.h>
#include <ex/effects/exSonicDashEffect.h>

// --------------------
// VARIABLES
// --------------------

static u16 exHitCheckTask_hitCheckCount2;
static u16 exHitCheckTask_hitCheckCount5;
static u16 exHitCheckTask_hitCheckCount;
static u16 exHitCheckTask_hitCheckCount4;
static s16 exHitCheckTaskPauseLevel;
static u16 exHitCheckTask_hitCheckCount3;

static exHitCheck *exHitCheckTask_hitCheckList2[5];
static exHitCheck *exHitCheckTask_hitCheckList5[10];
static exHitCheck *exHitCheckTask_hitCheckList3[10];
static exHitCheck *exHitCheckTask_hitCheckList4[10];
static exHitCheck *exHitCheckTask_hitCheckList[64];

static BOOL exHitCheckTaskIsList1Available = TRUE;
static BOOL exHitCheckTaskIsList5Available = TRUE;
static BOOL exHitCheckTaskIsList2Available = TRUE;
static BOOL exHitCheckTaskIsList3Available = TRUE;
static BOOL exHitCheckTaskIsList4Available = TRUE;

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL exHitCheckTask_CheckBoxOverlap(exHitCheckTaskUnknown *check1, exHitCheckTaskUnknown *check2);

static void exHitCheckTask_CheckArenaBounds(EX_ACTION_NN_WORK *work);
static void exHitCheckTask_ArenaCheck_Sprite2D(exHitCheck *work);
static void exHitCheckTask_ArenaCheck_Sprite3D(exHitCheck *work);
static void exHitCheckTask_ArenaCheck_Model(EX_ACTION_NN_WORK *work);

static void exHitCheckTask_DoHitChecks(void);

static void exHitCheckTask_Main_Init(void);
static void exHitCheckTask_TaskUnknown(void);
static void exHitCheckTask_Destructor(void);
static void exHitCheckTask_Main_Active(void);

// --------------------
// FUNCTIONS
// --------------------

void exHitCheckTask_SetPauseLevel(s32 pauseLevel)
{
    if (pauseLevel > 0 && exHitCheckTaskPauseLevel <= 0)
        exHitCheckTaskPauseLevel = pauseLevel;
}

BOOL exHitCheckTask_IsPaused(void)
{
    return exHitCheckTaskPauseLevel > 0;
}

void exHitCheckTask_DecPauseLevel(void)
{
    if (exHitCheckTaskPauseLevel > 0)
        exHitCheckTaskPauseLevel--;
}

void exHitCheckTask_InitHitChecker(exHitCheck *work)
{
    MI_CpuClear8(work, sizeof(*work));
}

NONMATCH_FUNC BOOL exHitCheckTask_CheckBoxOverlap(exHitCheckTaskUnknown *check1, exHitCheckTaskUnknown *check2)
{
    // https://decomp.me/scratch/gmdJi -> 5.54%
#ifdef NON_MATCHING
    if (check1->position->x + check1->size.x + check2->size.x >= check2->position->x && check1->position->x - check1->size.x - check2->size.x < check2->position->x
        && check1->position->y + check1->size.y + check2->size.y >= check2->position->y && check1->position->y - check1->size.y - check2->size.y < check2->position->y)
        return TRUE;

    return FALSE;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, [r0, #0xc]
	ldr r2, [r1, #0xc]
	ldr ip, [r0]
	ldr r7, [r0, #4]
	ldmia r4, {r3, r6}
	sub r0, r3, ip
	ldr lr, [r1]
	ldr r5, [r1, #4]
	add ip, r3, ip
	add r4, r6, r7
	sub r3, r6, r7
	ldr r1, [r2, #0]
	sub r0, r0, lr
	cmp r0, r1
	add r4, r5, r4
	add r0, lr, ip
	sub r3, r3, r5
	bge _0216AE70
	cmp r0, r1
	ldrgt r0, [r2, #4]
	cmpgt r4, r0
	ble _0216AE70
	cmp r3, r0
	movlt r0, #1
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
_0216AE70:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exHitCheckTask_AddHitCheck(exHitCheck *work)
{
    // https://decomp.me/scratch/o2gEV -> 95.86%
#ifdef NON_MATCHING
    if (CheckExStageFinished())
        return FALSE;

    if (GetExPlayerWorker()->moveFlags.hasDied == TRUE)
        return FALSE;

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
        return FALSE;

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
    {
        if (work->type == EXHITCHECK_TYPE_RING && work->field_4.isRing == TRUE)
        {
            if (exHitCheckTaskIsList1Available)
            {
                exHitCheckTask_hitCheckList[exHitCheckTask_hitCheckCount] = work;
                exHitCheckTask_hitCheckCount++;
            }
            else
            {
                return FALSE;
            }
        }

        return FALSE;
    }

    if (exHitCheckTask_hitCheckCount >= 64)
        exHitCheckTaskIsList1Available = FALSE;

    if (exHitCheckTask_hitCheckCount5 >= 10)
        exHitCheckTaskIsList5Available = FALSE;

    if (exHitCheckTask_hitCheckCount2 >= 5)
        exHitCheckTaskIsList2Available = FALSE;

    if (exHitCheckTask_hitCheckCount3 >= 10)
        exHitCheckTaskIsList3Available = FALSE;

    if (exHitCheckTask_hitCheckCount4 >= 10)
        exHitCheckTaskIsList4Available = FALSE;

    if (work->type == EXHITCHECK_TYPE_HAZARD)
    {
        if ((work->flags.value_1 == TRUE || work->flags.isBossMeteor == TRUE) || (work->field_2.isBossMeteorBomb == TRUE || work->field_2.isBossFireRed == TRUE)
            || (work->field_2.isBossFireBlue == TRUE || work->field_2.isBossMagmaWaveAttack == TRUE) || (work->field_2.value_2_20 == TRUE || work->field_2.value_2_80 == TRUE)
            || (work->field_3.value_3_1 == TRUE || work->field_3.isBossHomingLaserTrail == TRUE))
        {
            if (exHitCheckTaskIsList1Available)
            {
                exHitCheckTask_hitCheckList[exHitCheckTask_hitCheckCount] = work;
                exHitCheckTask_hitCheckCount++;
            }
            else
            {
                return FALSE;
            }
        }
    }

    if (work->type == EXHITCHECK_TYPE_INTRO_METEOR && work->field_4.isIntroMeteor == TRUE)
    {
        if (exHitCheckTaskIsList1Available)
        {
            exHitCheckTask_hitCheckList[exHitCheckTask_hitCheckCount] = work;
            exHitCheckTask_hitCheckCount++;
        }
        else
        {
            return FALSE;
        }
    }

    if (work->type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
    {
        if (work->field_3.isSonicBarrierEffect == TRUE)
        {
            if (exHitCheckTaskIsList2Available)
            {
                exHitCheckTask_hitCheckList2[exHitCheckTask_hitCheckCount2] = work;
                exHitCheckTask_hitCheckCount2++;
            }
            else
            {
                return FALSE;
            }
        }
        else if (work->field_4.value_4_2 == TRUE)
        {
            if (exHitCheckTaskIsList3Available)
            {
                exHitCheckTask_hitCheckList3[exHitCheckTask_hitCheckCount3] = work;
                exHitCheckTask_hitCheckCount3++;
            }
            else
            {
                return FALSE;
            }
        }
        else if (work->field_4.isBlazeFireballEffect == TRUE)
        {
            if (exHitCheckTaskIsList4Available)
            {
                exHitCheckTask_hitCheckList4[exHitCheckTask_hitCheckCount4] = work;
                exHitCheckTask_hitCheckCount4++;
            }
            else
            {
                return FALSE;
            }
        }
        else
        {
            if (exHitCheckTaskIsList5Available)
            {
                exHitCheckTask_hitCheckList5[exHitCheckTask_hitCheckCount5] = work;
                exHitCheckTask_hitCheckCount5++;
            }
            else
            {
                return FALSE;
            }
        }
    }

    if (work->type == EXHITCHECK_TYPE_RING && work->field_4.isRing == TRUE)
    {
        if (exHitCheckTaskIsList1Available)
        {
            exHitCheckTask_hitCheckList[exHitCheckTask_hitCheckCount] = work;
            exHitCheckTask_hitCheckCount++;
        }
        else
        {
            return FALSE;
        }
    }

    return TRUE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	bl CheckExStageFinished
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	bl GetExPlayerWorker
	ldrb r0, [r0, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _0216AEE0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	bne _0216AF3C
_0216AEE0:
	ldrb r0, [r4, #0]
	cmp r0, #4
	bne _0216AF34
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216AF34
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216AF2C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =exHitCheckTask_hitCheckList
	ldrh r3, [r0, #4]
	add r1, r3, #1
	str r4, [r2, r3, lsl #2]
	strh r1, [r0, #4]
	b _0216AF34
_0216AF2C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216AF34:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216AF3C:
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh r1, [r0, #4]
	cmp r1, #0x40
	ldrhs r0, =exHitCheckTaskIsList2Available
	movhs r2, #0
	strhs r2, [r0, #0x10]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh r2, [r0, #8]
	cmp r2, #0xa
	ldrhs r0, =exHitCheckTaskIsList2Available
	movhs r3, #0
	strhs r3, [r0, #0xc]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh r3, [r0, #0xa]
	cmp r3, #5
	ldrhs r0, =exHitCheckTaskIsList2Available
	movhs r5, #0
	strhs r5, [r0]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh ip, [r0, #6]
	cmp ip, #0xa
	ldrhs r0, =exHitCheckTaskIsList2Available
	movhs r5, #0
	strhs r5, [r0, #8]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh lr, [r0, #2]
	cmp lr, #0xa
	ldrhs r0, =exHitCheckTaskIsList2Available
	movhs r5, #0
	strhs r5, [r0, #4]
	ldrb r0, [r4, #0]
	cmp r0, #1
	bne _0216B084
	ldrb r0, [r4, #1]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r0, r0, lsl #0x18
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	beq _0216B050
	ldrb r0, [r4, #2]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r5, r0, lsl #0x1e
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1d
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1b
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1a
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r0, r0, lsl #0x18
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	beq _0216B050
	ldrb r0, [r4, #3]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r0, r0, lsl #0x1e
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	bne _0216B084
_0216B050:
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B07C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r6, =exHitCheckTask_hitCheckList
	ldrh r5, [r0, #4]
	str r4, [r6, r1, lsl #2]
	add r1, r5, #1
	strh r1, [r0, #4]
	b _0216B084
_0216B07C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B084:
	ldrb r0, [r4, #0]
	cmp r0, #5
	bne _0216B0D8
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B0D8
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B0D0
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r5, =exHitCheckTask_hitCheckList
	ldrh r6, [r0, #4]
	add r1, r6, #1
	str r4, [r5, r6, lsl #2]
	strh r1, [r0, #4]
	b _0216B0D8
_0216B0D0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B0D8:
	ldrb r0, [r4, #0]
	cmp r0, #2
	bne _0216B1EC
	ldrb r0, [r4, #3]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B12C
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0216B124
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =exHitCheckTask_hitCheckList2
	ldrh r1, [r0, #0xa]
	str r4, [r2, r3, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #0xa]
	b _0216B1EC
_0216B124:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B12C:
	ldrb r0, [r4, #4]
	mov r1, r0, lsl #0x1e
	mov r1, r1, lsr #0x1f
	cmp r1, #1
	bne _0216B174
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0216B16C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =exHitCheckTask_hitCheckList3
	ldrh r1, [r0, #6]
	str r4, [r2, ip, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #6]
	b _0216B1EC
_0216B16C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B174:
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B1B8
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0216B1B0
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =exHitCheckTask_hitCheckList4
	ldrh r1, [r0, #2]
	str r4, [r2, lr, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	b _0216B1EC
_0216B1B0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B1B8:
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _0216B1E4
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r3, =exHitCheckTask_hitCheckList5
	ldrh r1, [r0, #8]
	str r4, [r3, r2, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #8]
	b _0216B1EC
_0216B1E4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B1EC:
	ldrb r0, [r4, #0]
	cmp r0, #4
	bne _0216B240
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B240
	ldr r0, =exHitCheckTaskIsList2Available
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B238
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =exHitCheckTask_hitCheckList
	ldrh r3, [r0, #4]
	add r1, r3, #1
	str r4, [r2, r3, lsl #2]
	strh r1, [r0, #4]
	b _0216B240
_0216B238:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B240:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void exHitCheckTask_CheckArenaBounds(EX_ACTION_NN_WORK *work)
{
    if (GetExSystemStatus()->state >= EXSYSTASK_STATE_BOSS_ACTIVE)
    {
        work->hitChecker.hitFlags.wasOutOfBounds    = FALSE;
        work->hitChecker.hitFlags.touchingBoundaryT = FALSE;
        work->hitChecker.hitFlags.touchingBoundaryB  = FALSE;
        work->hitChecker.hitFlags.touchingBoundaryL  = FALSE;
        work->hitChecker.hitFlags.touchingBoundaryR  = FALSE;

        if (work->model.translation.y > FLOAT_TO_FX32(17.0))
        {
            work->model.translation.y                   = FLOAT_TO_FX32(17.0);
            work->hitChecker.hitFlags.touchingBoundaryT = TRUE;
            work->hitChecker.hitFlags.wasOutOfBounds    = TRUE;
        }

        if (work->model.translation.y < -FLOAT_TO_FX32(32.0))
        {
            work->model.translation.y                  = -FLOAT_TO_FX32(32.0);
            work->hitChecker.hitFlags.touchingBoundaryB = TRUE;
            work->hitChecker.hitFlags.wasOutOfBounds   = TRUE;
        }

        if (work->model.translation.x < -FLOAT_TO_FX32(70.0))
        {
            work->model.translation.x                  = -FLOAT_TO_FX32(70.0);
            work->hitChecker.hitFlags.touchingBoundaryL = TRUE;
            work->hitChecker.hitFlags.wasOutOfBounds   = TRUE;
        }

        if (work->model.translation.x > FLOAT_TO_FX32(70.0))
        {
            work->model.translation.x                  = FLOAT_TO_FX32(70.0);
            work->hitChecker.hitFlags.touchingBoundaryR = TRUE;
            work->hitChecker.hitFlags.wasOutOfBounds   = TRUE;
        }
    }
}

void exHitCheckTask_ArenaCheck_Sprite2D(exHitCheck *work)
{
    // Do nothing
}

void exHitCheckTask_ArenaCheck_Sprite3D(exHitCheck *work)
{
    // Do nothing
}

void exHitCheckTask_ArenaCheck_Model(EX_ACTION_NN_WORK *work)
{
    if ((work->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER || work->hitChecker.type == EXHITCHECK_TYPE_INACTIVE_PLAYER)
        && (work->hitChecker.field_3.isSuperSonicPlayer || work->hitChecker.field_3.isBurningBlazePlayer))
    {
        exHitCheckTask_CheckArenaBounds(work);
    }
}

void exHitCheckTask_DoArenaBoundsCheck(void *work, exDrawReqTaskType type)
{
    if (type == EXDRAWREQTASK_TYPE_SPRITE2D)
    {
        exHitCheckTask_ArenaCheck_Sprite2D(work);
    }
    else if (type == EXDRAWREQTASK_TYPE_MODEL)
    {
        exHitCheckTask_ArenaCheck_Model(work);
    }
    else if (type == EXDRAWREQTASK_TYPE_SPRITE3D)
    {
        exHitCheckTask_ArenaCheck_Sprite3D(work);
    }
}

void exHitCheckTask_DoHitChecks(void)
{
    EX_ACTION_NN_WORK *playerSonic = GetExSuperSonicWorker();
    EX_ACTION_NN_WORK *playerBlaze = GetExBurningBlazeWorker();
    exBossHelpers__GetBossAssets();

    u16 i;
    u16 ii;

    if (CheckExStageFinished() == FALSE && GetExPlayerWorker()->moveFlags.hasDied != TRUE && GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
        {
            if (playerSonic->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
            {
                for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                {
                    exHitCheck *other = exHitCheckTask_hitCheckList[i];

                    if (other->hitFlags.hasCollision != TRUE)
                    {
                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (exHitCheckTask_CheckBoxOverlap(&playerSonic->hitChecker.box, &other->box))
                            {
                                other = exHitCheckTask_hitCheckList[i];

                                if (other->field_4.isRing && playerSonic->hitChecker.hitFlags.isHurt == FALSE)
                                {
                                    other->hitFlags.hasCollision = TRUE;

                                    playerSonic->hitChecker.hitFlags.hasCollision = TRUE;
                                    playerSonic->hitChecker.hitFlags.touchedRing   = TRUE;
                                }
                            }
                        }
                    }
                }
            }

            if (playerBlaze->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
            {
                for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                {
                    exHitCheck *other = exHitCheckTask_hitCheckList[i];

                    if (other->hitFlags.hasCollision != TRUE)
                    {
                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (exHitCheckTask_CheckBoxOverlap(&playerBlaze->hitChecker.box, &other->box))
                            {
                                other = exHitCheckTask_hitCheckList[i];

                                if (other->field_4.isRing && playerBlaze->hitChecker.hitFlags.isHurt == FALSE)
                                {
                                    other->hitFlags.hasCollision = TRUE;

                                    playerBlaze->hitChecker.hitFlags.hasCollision = TRUE;
                                    playerBlaze->hitChecker.hitFlags.touchedRing   = TRUE;
                                }
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if (playerSonic != NULL && playerBlaze != NULL && exHitCheckTask_hitCheckCount != 0)
            {
                if (exHitCheckTask_hitCheckCount2 > 0)
                {
                    for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                    {
                        exHitCheck *other = exHitCheckTask_hitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD || other->type == EXHITCHECK_TYPE_INTRO_METEOR)
                            {
                                for (ii = 0; ii < exHitCheckTask_hitCheckCount2; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&exHitCheckTask_hitCheckList2[ii]->box, &exHitCheckTask_hitCheckList[i]->box))
                                    {
                                        other = exHitCheckTask_hitCheckList[i];

                                        if (other->flags.isBossMeteor)
                                        {
                                            if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                                            {
                                                if (exHitCheckTask_hitCheckList2[ii]->power == EXPLAYER_BARRIER_CHARGED_POWER_NORMAL)
                                                {
                                                    exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                                    exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                                    exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                                    exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                                }
                                            }
                                            else
                                            {
                                                if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                                                {
                                                    if (exHitCheckTask_hitCheckList2[ii]->power == EXPLAYER_BARRIER_CHARGED_POWER_EASY)
                                                    {
                                                        exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                                        exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                                        exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                                        exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                                    }
                                                }
                                            }
                                        }
                                        else if (other->field_2.isBossFireRed || other->field_2.isBossFireBlue)
                                        {
                                            exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                            exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                        }
                                        else if (other->field_2.value_2_20)
                                        {
                                            exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                            exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                        }
                                        else if (other->field_2.value_2_80)
                                        {
                                            exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                            exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                        }
                                        else
                                        {
                                            if (other->field_3.value_3_1)
                                            {
                                                exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;
                                            }
                                            else
                                            {
                                                if (other->field_3.isBossHomingLaserTrail)
                                                {
                                                    exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;
                                                }
                                                else
                                                {
                                                    exHitCheckTask_hitCheckList2[ii]->hitFlags.hasCollision = TRUE;

                                                    exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                                    exHitCheckTask_hitCheckList[i]->type                  = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                                    exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList2[ii]->power;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (exHitCheckTask_hitCheckCount3 > 0)
                {
                    for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                    {
                        exHitCheck *other = exHitCheckTask_hitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD)
                            {
                                for (ii = 0; ii < exHitCheckTask_hitCheckCount3; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&exHitCheckTask_hitCheckList3[ii]->box, &exHitCheckTask_hitCheckList[i]->box))
                                    {
                                        other = exHitCheckTask_hitCheckList[i];

                                        if (other->field_2.isBossFireRed == FALSE && other->field_2.isBossFireBlue == FALSE && other->field_2.value_2_20 == FALSE
                                            && other->field_2.value_2_80 == FALSE && other->field_3.isBossHomingLaserTrail == FALSE)
                                        {
                                            exHitCheckTask_hitCheckList3[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->hitFlags.isHurt       = TRUE;
                                            exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                            exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList3[ii]->power;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (exHitCheckTask_hitCheckCount4 > 0)
                {
                    for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                    {
                        exHitCheck *other = exHitCheckTask_hitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD || other->type == EXHITCHECK_TYPE_INTRO_METEOR)
                            {
                                for (ii = 0; ii < exHitCheckTask_hitCheckCount4; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&exHitCheckTask_hitCheckList4[ii]->box, &exHitCheckTask_hitCheckList[i]->box))
                                    {
                                        other = exHitCheckTask_hitCheckList[i];

                                        if (other->field_2.isBossFireRed || other->field_2.isBossFireBlue)
                                        {
                                            exHitCheckTask_hitCheckList4[ii]->hitFlags.hasCollision = TRUE;
                                        }
                                        else if (other->field_2.isBossMagmaWaveAttack)
                                        {
                                            exHitCheckTask_hitCheckList4[ii]->hitFlags.hasCollision = TRUE;
                                        }
                                        else if (other->field_2.value_2_20)
                                        {
                                            other->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList4[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->power = exHitCheckTask_hitCheckList4[ii]->power;
                                        }
                                        else if (other->field_3.isBossHomingLaserTrail == FALSE)
                                        {
                                            exHitCheckTask_hitCheckList4[ii]->hitFlags.hasCollision = TRUE;

                                            exHitCheckTask_hitCheckList[i]->hitFlags.isHurt       = TRUE;
                                            exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                            exHitCheckTask_hitCheckList[i]->power                 = exHitCheckTask_hitCheckList4[ii]->power;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if (playerSonic->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
                {
                    for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                    {
                        exHitCheck *other = exHitCheckTask_hitCheckList[i];

                        if (other->hitFlags.hasCollision != 1)
                        {
                            if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                            {
                                if (exHitCheckTask_CheckBoxOverlap(&playerSonic->hitChecker.box, &other->box))
                                {
                                    other = exHitCheckTask_hitCheckList[i];

                                    if (other->field_4.isIntroMeteor)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE)
                                        {
                                            if (GetExPlayerWorker()->dashTimer > 0)
                                                exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;

                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->flags.isBossMeteor)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossMeteorBomb)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossFireRed)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossFireBlue)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossMagmaWaveAttack)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.value_2_20)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.value_10                = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.value_2_80)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE)
                                        {
                                            if (GetExPlayerWorker()->dashTimer > 0)
                                            {
                                                exHitCheckTask_hitCheckList[i]->hitFlags.value_10 = TRUE;
                                            }
                                            else
                                            {
                                                exHitCheckTask_hitCheckList[i]->hitFlags.hasCollision = TRUE;
                                                playerSonic->hitChecker.hitFlags.isHurt               = TRUE;
                                            }
                                        }
                                    }
                                    else if (other->field_3.value_3_1)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerSonic->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_3.isBossHomingLaserTrail)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE && playerSonic->hitChecker.hitFlags.isInvincible == FALSE)
                                            playerSonic->hitChecker.hitFlags.isStunned = TRUE;
                                    }
                                    else if (other->field_4.isRing)
                                    {
                                        if (playerSonic->hitChecker.hitFlags.isHurt == FALSE)
                                        {
                                            other->hitFlags.hasCollision = TRUE;

                                            playerSonic->hitChecker.hitFlags.hasCollision = TRUE;
                                            playerSonic->hitChecker.hitFlags.touchedRing   = TRUE;
                                        }
                                    }
                                    else
                                    {
                                        other->hitFlags.hasCollision = TRUE;

                                        playerSonic->hitChecker.hitFlags.hasCollision = TRUE;
                                    }
                                }
                            }
                        }
                    }
                }

                playerSonic->hitChecker.hitFlags.isInvincible = FALSE;

                if (playerBlaze->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
                {
                    for (i = 0; i < exHitCheckTask_hitCheckCount; i++)
                    {
                        exHitCheck *other = exHitCheckTask_hitCheckList[i];

                        if (other->hitFlags.hasCollision != 1)
                        {
                            if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                            {
                                if (exHitCheckTask_CheckBoxOverlap(&playerBlaze->hitChecker.box, &other->box))
                                {
                                    other = exHitCheckTask_hitCheckList[i];

                                    if (other->field_4.isIntroMeteor)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                    }
                                    else if (other->field_2.isBossMagmaWaveAttack)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->flags.isBossMeteor)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossFireRed)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.isBossFireBlue)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.value_2_20)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.value_10                = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_2.value_2_80)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_3.value_3_1)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                        {
                                            other->hitFlags.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.hitFlags.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->field_3.isBossHomingLaserTrail)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE && playerBlaze->hitChecker.hitFlags.isInvincible == FALSE)
                                            playerBlaze->hitChecker.hitFlags.isStunned = TRUE;
                                    }
                                    else if (other->field_4.isRing)
                                    {
                                        if (playerBlaze->hitChecker.hitFlags.isHurt == FALSE)
                                        {
                                            other->hitFlags.hasCollision = TRUE;

                                            playerBlaze->hitChecker.hitFlags.hasCollision = TRUE;
                                            playerBlaze->hitChecker.hitFlags.touchedRing   = TRUE;
                                        }
                                    }
                                    else
                                    {
                                        other->hitFlags.hasCollision                  = TRUE;
                                        playerBlaze->hitChecker.hitFlags.hasCollision = TRUE;
                                    }
                                }
                            }
                        }
                    }
                }

                playerBlaze->hitChecker.hitFlags.isInvincible = FALSE;
            }
        }
    }
}

void exHitCheckTask_Main_Init(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    exHitCheckTask_hitCheckCount  = 0;
    exHitCheckTask_hitCheckCount2 = 0;
    exHitCheckTask_hitCheckCount3 = 0;
    exHitCheckTask_hitCheckCount5 = 0;
    exHitCheckTask_hitCheckCount4 = 0;

    SetCurrentExTaskMainEvent(exHitCheckTask_Main_Active);
}

void exHitCheckTask_TaskUnknown(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    exHitCheckTaskIsList1Available = TRUE;
    exHitCheckTaskIsList2Available = TRUE;
    exHitCheckTaskIsList3Available = TRUE;
    exHitCheckTaskIsList5Available = TRUE;
    exHitCheckTaskIsList4Available = TRUE;

    exHitCheckTask_hitCheckCount  = 0;
    exHitCheckTask_hitCheckCount2 = 0;
    exHitCheckTask_hitCheckCount3 = 0;
    exHitCheckTask_hitCheckCount5 = 0;
    exHitCheckTask_hitCheckCount4 = 0;

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void exHitCheckTask_Destructor(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    exHitCheckTaskIsList1Available = TRUE;
    exHitCheckTaskIsList2Available = TRUE;
    exHitCheckTaskIsList3Available = TRUE;
    exHitCheckTaskIsList5Available = TRUE;
    exHitCheckTaskIsList4Available = TRUE;

    exHitCheckTask_hitCheckCount  = 0;
    exHitCheckTask_hitCheckCount2 = 0;
    exHitCheckTask_hitCheckCount3 = 0;
    exHitCheckTask_hitCheckCount5 = 0;
    exHitCheckTask_hitCheckCount4 = 0;
}

void exHitCheckTask_Main_Active(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    exHitCheckTask_DoHitChecks();

    RunCurrentExTaskUnknownEvent();
}

void exHitCheckTask_Create(void)
{
    Task *task = ExTaskCreate(exHitCheckTask_Main_Init, exHitCheckTask_Destructor, TASK_PRIORITY_UPDATE_LIST_END - 2, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exHitCheckTask);

    exHitCheckTask *work = ExTaskGetWork(task, exHitCheckTask);
    UNUSED(work);

    SetExTaskUnknownEvent(task, exHitCheckTask_TaskUnknown);
}