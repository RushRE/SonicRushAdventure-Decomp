#include <ex/system/exHitCheck.h>
#include <ex/system/exSystem.h>
#include <ex/player/exPlayer.h>
#include <ex/boss/exBoss.h>
#include <ex/effects/exBlazeDashEffect.h>
#include <ex/effects/exSonicDashEffect.h>

// --------------------
// VARIABLES
// --------------------

static u16 sonicBarrierHitCheckListSize;
static u16 playerBodyHitCheckListSize;
static u16 stageObjectHitCheckListSize;
static u16 blazeFireballHitCheckListSize;
static s16 exHitCheckTaskPauseLevel;
static u16 repelledProjectileHitCheckListSize;

static exHitCheck *sonicBarrierHitCheckList[5];
static exHitCheck *playerBodyHitCheckList[10];
static exHitCheck *repelledProjectileHitCheckList[10];
static exHitCheck *blazeFireballHitCheckList[10];
static exHitCheck *stageObjectHitCheckList[64];

static BOOL isStageObjectHitCheckListAvailable        = TRUE;
static BOOL isPlayerBodyHitCheckListAvailable         = TRUE;
static BOOL isSonicBarrierHitCheckListAvailable       = TRUE;
static BOOL isRepelledProjectileHitCheckListAvailable = TRUE;
static BOOL isBlazeFireballHitCheckListAvailable      = TRUE;

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
static void exHitCheckTask_OnCheckStageFinished(void);
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
        if (work->type == EXHITCHECK_TYPE_RING && work->input.isRing == TRUE)
        {
            if (isStageObjectHitCheckListAvailable)
            {
                stageObjectHitCheckList[stageObjectHitCheckListSize] = work;
                stageObjectHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }

        return FALSE;
    }

    if (stageObjectHitCheckListSize >= 64)
        isStageObjectHitCheckListAvailable = FALSE;

    if (playerBodyHitCheckListSize >= 10)
        isPlayerBodyHitCheckListAvailable = FALSE;

    if (sonicBarrierHitCheckListSize >= 5)
        isSonicBarrierHitCheckListAvailable = FALSE;

    if (repelledProjectileHitCheckListSize >= 10)
        isRepelledProjectileHitCheckListAvailable = FALSE;

    if (blazeFireballHitCheckListSize >= 10)
        isBlazeFireballHitCheckListAvailable = FALSE;

    if (work->type == EXHITCHECK_TYPE_HAZARD)
    {
        if ((work->input.isBoss == TRUE || work->input.isBossMeteor == TRUE) || (work->input.isBossMeteorBomb == TRUE || work->input.isBossFireRed == TRUE)
            || (work->input.isBossFireBlue == TRUE || work->input.isBossMagmaWaveAttack == TRUE) || (work->input.isBossDragon == TRUE || work->input.isBluntLineMissile == TRUE)
            || (work->input.isSpikedLineMissile == TRUE || work->input.isBossHomingLaserTrail == TRUE))
        {
            if (isStageObjectHitCheckListAvailable)
            {
                stageObjectHitCheckList[stageObjectHitCheckListSize] = work;
                stageObjectHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }
    }

    if (work->type == EXHITCHECK_TYPE_INTRO_METEOR && work->input.isIntroMeteor == TRUE)
    {
        if (isStageObjectHitCheckListAvailable)
        {
            stageObjectHitCheckList[stageObjectHitCheckListSize] = work;
            stageObjectHitCheckListSize++;
        }
        else
        {
            return FALSE;
        }
    }

    if (work->type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
    {
        if (work->input.isSonicBarrierEffect == TRUE)
        {
            if (isSonicBarrierHitCheckListAvailable)
            {
                sonicBarrierHitCheckList[sonicBarrierHitCheckListSize] = work;
                sonicBarrierHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }
        else if (work->input.isRepelledProjectile == TRUE)
        {
            if (isRepelledProjectileHitCheckListAvailable)
            {
                repelledProjectileHitCheckList[repelledProjectileHitCheckListSize] = work;
                repelledProjectileHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }
        else if (work->input.isBlazeFireballEffect == TRUE)
        {
            if (isBlazeFireballHitCheckListAvailable)
            {
                blazeFireballHitCheckList[blazeFireballHitCheckListSize] = work;
                blazeFireballHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }
        else
        {
            if (isPlayerBodyHitCheckListAvailable)
            {
                playerBodyHitCheckList[playerBodyHitCheckListSize] = work;
                playerBodyHitCheckListSize++;
            }
            else
            {
                return FALSE;
            }
        }
    }

    if (work->type == EXHITCHECK_TYPE_RING && work->input.isRing == TRUE)
    {
        if (isStageObjectHitCheckListAvailable)
        {
            stageObjectHitCheckList[stageObjectHitCheckListSize] = work;
            stageObjectHitCheckListSize++;
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216AF2C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =stageObjectHitCheckList
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
	ldrhs r0, =isSonicBarrierHitCheckListAvailable
	movhs r2, #0
	strhs r2, [r0, #0x10]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh r2, [r0, #8]
	cmp r2, #0xa
	ldrhs r0, =isSonicBarrierHitCheckListAvailable
	movhs r3, #0
	strhs r3, [r0, #0xc]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh r3, [r0, #0xa]
	cmp r3, #5
	ldrhs r0, =isSonicBarrierHitCheckListAvailable
	movhs r5, #0
	strhs r5, [r0]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh ip, [r0, #6]
	cmp ip, #0xa
	ldrhs r0, =isSonicBarrierHitCheckListAvailable
	movhs r5, #0
	strhs r5, [r0, #8]
	ldr r0, =exHitCheckTaskPauseLevel
	ldrh lr, [r0, #2]
	cmp lr, #0xa
	ldrhs r0, =isSonicBarrierHitCheckListAvailable
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B07C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r6, =stageObjectHitCheckList
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B0D0
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r5, =stageObjectHitCheckList
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0216B124
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =sonicBarrierHitCheckList
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0216B16C
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =repelledProjectileHitCheckList
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0216B1B0
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =blazeFireballHitCheckList
	ldrh r1, [r0, #2]
	str r4, [r2, lr, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	b _0216B1EC
_0216B1B0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B1B8:
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _0216B1E4
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r3, =playerBodyHitCheckList
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
	ldr r0, =isSonicBarrierHitCheckListAvailable
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B238
	ldr r0, =exHitCheckTaskPauseLevel
	ldr r2, =stageObjectHitCheckList
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
        work->hitChecker.output.wasOutOfBounds    = FALSE;
        work->hitChecker.output.touchingBoundaryT = FALSE;
        work->hitChecker.output.touchingBoundaryB = FALSE;
        work->hitChecker.output.touchingBoundaryL = FALSE;
        work->hitChecker.output.touchingBoundaryR = FALSE;

        if (work->model.translation.y > FLOAT_TO_FX32(17.0))
        {
            work->model.translation.y                 = FLOAT_TO_FX32(17.0);
            work->hitChecker.output.touchingBoundaryT = TRUE;
            work->hitChecker.output.wasOutOfBounds    = TRUE;
        }

        if (work->model.translation.y < -FLOAT_TO_FX32(32.0))
        {
            work->model.translation.y                 = -FLOAT_TO_FX32(32.0);
            work->hitChecker.output.touchingBoundaryB = TRUE;
            work->hitChecker.output.wasOutOfBounds    = TRUE;
        }

        if (work->model.translation.x < -FLOAT_TO_FX32(70.0))
        {
            work->model.translation.x                 = -FLOAT_TO_FX32(70.0);
            work->hitChecker.output.touchingBoundaryL = TRUE;
            work->hitChecker.output.wasOutOfBounds    = TRUE;
        }

        if (work->model.translation.x > FLOAT_TO_FX32(70.0))
        {
            work->model.translation.x                 = FLOAT_TO_FX32(70.0);
            work->hitChecker.output.touchingBoundaryR = TRUE;
            work->hitChecker.output.wasOutOfBounds    = TRUE;
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
        && (work->hitChecker.input.isSuperSonicPlayer || work->hitChecker.input.isBurningBlazePlayer))
    {
        exHitCheckTask_CheckArenaBounds(work);
    }
}

void exHitCheckTask_DoArenaBoundsCheck(void *work, ExDrawReqTaskType type)
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
    GetExBossAssets();

    u16 i;
    u16 ii;

    if (CheckExStageFinished() == FALSE && GetExPlayerWorker()->moveFlags.hasDied != TRUE && GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED || GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
        {
            // Check stage ring interactions for sonic
            if (playerSonic->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
            {
                for (i = 0; i < stageObjectHitCheckListSize; i++)
                {
                    exHitCheck *other = stageObjectHitCheckList[i];

                    if (other->output.hasCollision != TRUE)
                    {
                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (exHitCheckTask_CheckBoxOverlap(&playerSonic->hitChecker.box, &other->box))
                            {
                                other = stageObjectHitCheckList[i];

                                if (other->input.isRing && playerSonic->hitChecker.output.isHurt == FALSE)
                                {
                                    other->output.hasCollision = TRUE;

                                    playerSonic->hitChecker.output.hasCollision = TRUE;
                                    playerSonic->hitChecker.output.touchedRing  = TRUE;
                                }
                            }
                        }
                    }
                }
            }

            // Check stage ring interactions for blaze
            if (playerBlaze->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
            {
                for (i = 0; i < stageObjectHitCheckListSize; i++)
                {
                    exHitCheck *other = stageObjectHitCheckList[i];

                    if (other->output.hasCollision != TRUE)
                    {
                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (exHitCheckTask_CheckBoxOverlap(&playerBlaze->hitChecker.box, &other->box))
                            {
                                other = stageObjectHitCheckList[i];

                                if (other->input.isRing && playerBlaze->hitChecker.output.isHurt == FALSE)
                                {
                                    other->output.hasCollision = TRUE;

                                    playerBlaze->hitChecker.output.hasCollision = TRUE;
                                    playerBlaze->hitChecker.output.touchedRing  = TRUE;
                                }
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if (playerSonic != NULL && playerBlaze != NULL && stageObjectHitCheckListSize != 0)
            {
                if (sonicBarrierHitCheckListSize > 0)
                {
                    for (i = 0; i < stageObjectHitCheckListSize; i++)
                    {
                        exHitCheck *other = stageObjectHitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD || other->type == EXHITCHECK_TYPE_INTRO_METEOR)
                            {
                                for (ii = 0; ii < sonicBarrierHitCheckListSize; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&sonicBarrierHitCheckList[ii]->box, &stageObjectHitCheckList[i]->box))
                                    {
                                        other = stageObjectHitCheckList[i];

                                        if (other->input.isBossMeteor)
                                        {
                                            if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                                            {
                                                if (sonicBarrierHitCheckList[ii]->power == EXPLAYER_BARRIER_CHARGED_POWER_NORMAL)
                                                {
                                                    sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                                    stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                                    stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                                    stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                                }
                                            }
                                            else
                                            {
                                                if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                                                {
                                                    if (sonicBarrierHitCheckList[ii]->power == EXPLAYER_BARRIER_CHARGED_POWER_EASY)
                                                    {
                                                        sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                                        stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                                        stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                                        stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                                    }
                                                }
                                            }
                                        }
                                        else if (other->input.isBossFireRed || other->input.isBossFireBlue)
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                        }
                                        else if (other->input.isBossDragon)
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                        }
                                        else if (other->input.isBluntLineMissile)
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                        }
                                        else if (other->input.isSpikedLineMissile)
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;
                                        }
                                        else if (other->input.isBossHomingLaserTrail)
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;
                                        }
                                        else
                                        {
                                            sonicBarrierHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->type                = EXHITCHECK_TYPE_ACTIVE_PLAYER;
                                            stageObjectHitCheckList[i]->power               = sonicBarrierHitCheckList[ii]->power;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (repelledProjectileHitCheckListSize > 0)
                {
                    for (i = 0; i < stageObjectHitCheckListSize; i++)
                    {
                        exHitCheck *other = stageObjectHitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD)
                            {
                                for (ii = 0; ii < repelledProjectileHitCheckListSize; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&repelledProjectileHitCheckList[ii]->box, &stageObjectHitCheckList[i]->box))
                                    {
                                        other = stageObjectHitCheckList[i];

                                        if (other->input.isBossFireRed == FALSE && other->input.isBossFireBlue == FALSE && other->input.isBossDragon == FALSE
                                            && other->input.isBluntLineMissile == FALSE && other->input.isBossHomingLaserTrail == FALSE)
                                        {
                                            repelledProjectileHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.isHurt       = TRUE;
                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->power               = repelledProjectileHitCheckList[ii]->power;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (blazeFireballHitCheckListSize > 0)
                {
                    for (i = 0; i < stageObjectHitCheckListSize; i++)
                    {
                        exHitCheck *other = stageObjectHitCheckList[i];

                        if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                        {
                            if (other->type == EXHITCHECK_TYPE_HAZARD || other->type == EXHITCHECK_TYPE_INTRO_METEOR)
                            {
                                for (ii = 0; ii < blazeFireballHitCheckListSize; ii++)
                                {
                                    if (exHitCheckTask_CheckBoxOverlap(&blazeFireballHitCheckList[ii]->box, &stageObjectHitCheckList[i]->box))
                                    {
                                        other = stageObjectHitCheckList[i];

                                        if (other->input.isBossFireRed || other->input.isBossFireBlue)
                                        {
                                            blazeFireballHitCheckList[ii]->output.hasCollision = TRUE;
                                        }
                                        else if (other->input.isBossMagmaWaveAttack)
                                        {
                                            blazeFireballHitCheckList[ii]->output.hasCollision = TRUE;
                                        }
                                        else if (other->input.isBossDragon)
                                        {
                                            other->output.hasCollision = TRUE;

                                            blazeFireballHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->power = blazeFireballHitCheckList[ii]->power;
                                        }
                                        else if (other->input.isBossHomingLaserTrail == FALSE)
                                        {
                                            blazeFireballHitCheckList[ii]->output.hasCollision = TRUE;

                                            stageObjectHitCheckList[i]->output.isHurt       = TRUE;
                                            stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                            stageObjectHitCheckList[i]->power               = blazeFireballHitCheckList[ii]->power;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if (playerSonic->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
                {
                    for (i = 0; i < stageObjectHitCheckListSize; i++)
                    {
                        exHitCheck *other = stageObjectHitCheckList[i];

                        if (other->output.hasCollision != 1)
                        {
                            if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                            {
                                if (exHitCheckTask_CheckBoxOverlap(&playerSonic->hitChecker.box, &other->box))
                                {
                                    other = stageObjectHitCheckList[i];

                                    if (other->input.isIntroMeteor)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE)
                                        {
                                            if (GetExPlayerWorker()->dashTimer > 0)
                                                stageObjectHitCheckList[i]->output.hasCollision = TRUE;

                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossMeteor)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossMeteorBomb)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossFireRed)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossFireBlue)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossMagmaWaveAttack)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossDragon)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.willExplodeOnContact    = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBluntLineMissile)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE)
                                        {
                                            if (GetExPlayerWorker()->dashTimer > 0)
                                            {
                                                stageObjectHitCheckList[i]->output.willExplodeOnContact = TRUE;
                                            }
                                            else
                                            {
                                                stageObjectHitCheckList[i]->output.hasCollision = TRUE;
                                                playerSonic->hitChecker.output.isHurt           = TRUE;
                                            }
                                        }
                                    }
                                    else if (other->input.isSpikedLineMissile)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerSonic->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossHomingLaserTrail)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE && playerSonic->hitChecker.output.isInvincible == FALSE)
                                            playerSonic->hitChecker.output.isStunned = TRUE;
                                    }
                                    else if (other->input.isRing)
                                    {
                                        if (playerSonic->hitChecker.output.isHurt == FALSE)
                                        {
                                            other->output.hasCollision = TRUE;

                                            playerSonic->hitChecker.output.hasCollision = TRUE;
                                            playerSonic->hitChecker.output.touchedRing  = TRUE;
                                        }
                                    }
                                    else
                                    {
                                        other->output.hasCollision = TRUE;

                                        playerSonic->hitChecker.output.hasCollision = TRUE;
                                    }
                                }
                            }
                        }
                    }
                }

                playerSonic->hitChecker.output.isInvincible = FALSE;

                if (playerBlaze->hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
                {
                    for (i = 0; i < stageObjectHitCheckListSize; i++)
                    {
                        exHitCheck *other = stageObjectHitCheckList[i];

                        if (other->output.hasCollision != 1)
                        {
                            if ((other->box.position->z <= FLOAT_TO_FX32(65.0) && other->box.position->z >= FLOAT_TO_FX32(50.0)) || other->box.position->z == FLOAT_TO_FX32(0.0))
                            {
                                if (exHitCheckTask_CheckBoxOverlap(&playerBlaze->hitChecker.box, &other->box))
                                {
                                    other = stageObjectHitCheckList[i];

                                    if (other->input.isIntroMeteor)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                    }
                                    else if (other->input.isBossMagmaWaveAttack)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossMeteor)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossFireRed)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossFireBlue)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossDragon)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.willExplodeOnContact    = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBluntLineMissile)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isSpikedLineMissile)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                        {
                                            other->output.hasCollision            = TRUE;
                                            playerBlaze->hitChecker.output.isHurt = TRUE;
                                        }
                                    }
                                    else if (other->input.isBossHomingLaserTrail)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE && playerBlaze->hitChecker.output.isInvincible == FALSE)
                                            playerBlaze->hitChecker.output.isStunned = TRUE;
                                    }
                                    else if (other->input.isRing)
                                    {
                                        if (playerBlaze->hitChecker.output.isHurt == FALSE)
                                        {
                                            other->output.hasCollision = TRUE;

                                            playerBlaze->hitChecker.output.hasCollision = TRUE;
                                            playerBlaze->hitChecker.output.touchedRing  = TRUE;
                                        }
                                    }
                                    else
                                    {
                                        other->output.hasCollision                  = TRUE;
                                        playerBlaze->hitChecker.output.hasCollision = TRUE;
                                    }
                                }
                            }
                        }
                    }
                }

                playerBlaze->hitChecker.output.isInvincible = FALSE;
            }
        }
    }
}

void exHitCheckTask_Main_Init(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    stageObjectHitCheckListSize        = 0;
    sonicBarrierHitCheckListSize       = 0;
    repelledProjectileHitCheckListSize = 0;
    playerBodyHitCheckListSize         = 0;
    blazeFireballHitCheckListSize      = 0;

    SetCurrentExTaskMainEvent(exHitCheckTask_Main_Active);
}

void exHitCheckTask_OnCheckStageFinished(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    isStageObjectHitCheckListAvailable        = TRUE;
    isSonicBarrierHitCheckListAvailable       = TRUE;
    isRepelledProjectileHitCheckListAvailable = TRUE;
    isPlayerBodyHitCheckListAvailable         = TRUE;
    isBlazeFireballHitCheckListAvailable      = TRUE;

    stageObjectHitCheckListSize        = 0;
    sonicBarrierHitCheckListSize       = 0;
    repelledProjectileHitCheckListSize = 0;
    playerBodyHitCheckListSize         = 0;
    blazeFireballHitCheckListSize      = 0;

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void exHitCheckTask_Destructor(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    isStageObjectHitCheckListAvailable        = TRUE;
    isSonicBarrierHitCheckListAvailable       = TRUE;
    isRepelledProjectileHitCheckListAvailable = TRUE;
    isPlayerBodyHitCheckListAvailable         = TRUE;
    isBlazeFireballHitCheckListAvailable      = TRUE;

    stageObjectHitCheckListSize        = 0;
    sonicBarrierHitCheckListSize       = 0;
    repelledProjectileHitCheckListSize = 0;
    playerBodyHitCheckListSize         = 0;
    blazeFireballHitCheckListSize      = 0;
}

void exHitCheckTask_Main_Active(void)
{
    exHitCheckTask *work = ExTaskGetWorkCurrent(exHitCheckTask);
    UNUSED(work);

    exHitCheckTask_DoHitChecks();

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void exHitCheckTask_Create(void)
{
    Task *task = ExTaskCreate(exHitCheckTask_Main_Init, exHitCheckTask_Destructor, TASK_PRIORITY_UPDATE_LIST_END - 2, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exHitCheckTask);

    exHitCheckTask *work = ExTaskGetWork(task, exHitCheckTask);
    UNUSED(work);

    SetExTaskOnCheckStageFinishedEvent(task, exHitCheckTask_OnCheckStageFinished);
}