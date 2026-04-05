#include <stage/objects/tripleGrindRail.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapFarSys.h>
#include <stage/core/ringManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_railSize mapObject->left
#define mapObjectParam_railID   mapObject->left

// --------------------
// VARIABLES
// --------------------

extern RingManager *gRingManagerWork;
extern s16 gSpillRingGravityStrength;

extern TripleGrindRail *sTripleGrindRailSingleton;

static const VecFx32 sMushroomParticleDefaultScale             = { FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0) };
static const VecFx32 sLeafParticleDefaultScale                 = { FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(1.5) };
static const TripleGrindRailParticleType sLeafParticleTypes[8] = { TRIPLEGRINDRAIL_PARTICLE_LEAF_GREEN_1, TRIPLEGRINDRAIL_PARTICLE_LEAF_GREEN_2,
                                                                   TRIPLEGRINDRAIL_PARTICLE_LEAF_BROWN_1, TRIPLEGRINDRAIL_PARTICLE_LEAF_BROWN_2,
                                                                   TRIPLEGRINDRAIL_PARTICLE_LEAF_GREEN_3, TRIPLEGRINDRAIL_PARTICLE_LEAF_GREEN_4,
                                                                   TRIPLEGRINDRAIL_PARTICLE_LEAF_GREEN_1, TRIPLEGRINDRAIL_PARTICLE_LEAF_BROWN_1 };

NOT_DECOMPILED const char aActAcGmkBallSi[];

// --------------------
// FUNCTIONS
// --------------------

TripleGrindRailEntity *TripleGrindRailEntity__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    if (sTripleGrindRailSingleton == NULL)
        return NULL;
    if (x <= sTripleGrindRailSingleton->gameWork.objWork.position.x)
        return NULL;
    if ((sTripleGrindRailSingleton->flags & TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START) != 0)
        return NULL;

    TripleGrindRailEntity *work;
    Task *task;
#ifdef RUSH_BUG_FIX
    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRailEntity);
#else
    // Sic: we're allocating a TripleGrindRailEntity by asking for the (much greater) size of a TripleGrindRail
    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRail);
#endif
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, TripleGrindRailEntity);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    s32 railID   = ClampS32(mapObjectParam_railID, 0, 2);
    work->radius = railID * TRIPLEGRINDRAIL_DISTANCE_BETWEEN_RAILS + TRIPLEGRINDRAIL_RADIUS_RAIL_0;
    if ((mapObject->id == MAPOBJECT_122) || (mapObject->id != MAPOBJECT_123))
    {
        ObjObjectAction3dBACLoad(&work->gameWork.objWork, &work->aniSprite, aActAcGmkBallSi, OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_177),
                                 gameArchiveStage);
        ObjObjectActionAllocTexture(&work->gameWork.objWork, 0x800, 16, GetObjectFileWork(OBJDATAWORK_178));
        OBS_DATA_WORK *work178 = GetObjectFileWork(OBJDATAWORK_178);
        if ((work178->referenceCount & ~0x8000) == 1)
        {
            work->aniSprite.ani.animatorSprite.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES;
            AnimatorSprite3D__ProcessAnimation(&work->aniSprite.ani, work->gameWork.objWork.ppSpriteCallback, work);
            work->aniSprite.ani.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES;
        }
        ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_INVINCIBLE);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->gameWork.objWork.scale.x = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.y = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.z = FLOAT_TO_FX32(2.5);
    }
    else
    {
        MI_CpuCopy8(&sTripleGrindRailSingleton->aniRingSparkle, &work->aniSprite.ani, sizeof(work->aniSprite.ani));
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
        ObjRect__SetBox3D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -8, -16, -4, 8, 0, 4);
        ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = TripleGrindRailEntity__OnDefend;
        work->gameWork.objWork.scale.x                              = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.y                              = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.z                              = FLOAT_TO_FX32(2.5);
    }
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    SetTaskState(&work->gameWork.objWork, TripleGrindRailEntity__State_Inactive);

    return work;
}

NONMATCH_FUNC void TripleGrindRailRingLoss__Create(Player *player)
{
    // https://decomp.me/scratch/fV24Q => 91.97%
#ifdef NON_MATCHING
    VecFx32 position;
    fx32 ringAngle;
    s32 ringCount;
    fx32 *currentRingVelocityX;
    fx32 *currentRingVelocityY;
    VecFx32 *currentRingPosition;
    s32 i;

    ringAngle = FLOAT_DEG_TO_IDX(6.375);

    if (sTripleGrindRailSingleton == NULL)
        return;
    if ((sTripleGrindRailSingleton->flags & TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START) != 0)
        return;

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRailRingLoss);
    if (task == HeapNull)
        return;

    TripleGrindRailRingLoss *work = TaskGetWork(task, TripleGrindRailRingLoss);
    TaskInitWork8(work);

    work->objWork.objType = STAGE_OBJ_TYPE_OBJECT;
    fx32 scale            = GetStageRingScale();
    work->objWork.scale.x = scale;
    work->objWork.scale.y = scale;
    work->objWork.scale.z = scale;
    ringCount             = MATH_MIN(player->rings, RINGMANAGER_RING_SPILL_MAX);
    player->rings         = 0;
    work->ringCount       = ringCount;
    position              = work->objWork.position;
    ringAngle += (gRingManagerWork->ringPenaltyCount[player->controlID] << 8);

    currentRingVelocityX = &work->ringVelocityX[0];
    currentRingVelocityY = &work->ringVelocityY[0];
    currentRingPosition  = &work->ringPosition[0];

    fx32 velocityX;
    fx32 velocityY;
    for (i = 0; i < ringCount; i++, currentRingPosition++)
    {
        *currentRingPosition = position;
        if (ringAngle >= 0)
        {
            u16 index16   = ringAngle << 8;
            s32 ang8      = ringAngle >> 8;
            s32 shift     = (ang8 >= 6) ? (9 - ang8) : ang8;
            fx32 sin      = SinFX((s32)(u16)(s32)index16);
            fx32 cos      = CosFX((s32)(u16)(s32)index16);
            fx32 tempVelX = (sin << 4) >> shift;
            fx32 tempVelY = (cos << 4) >> shift;
            velocityX     = tempVelX - (tempVelX >> 2);
            velocityY     = tempVelY - (tempVelY >> 2);
            ringAngle     = (ringAngle + 0x10) | 0x80;
        }
        *(currentRingVelocityX++) = velocityX;
        *(currentRingVelocityY++) = velocityY;
        ringAngle                 = -ringAngle;
        velocityX                 = -velocityX;
    }
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskOutFunc(&work->objWork, TripleGrindRailRingLoss__Draw);
    SetTaskState(&work->objWork, TripleGrindRailRingLoss__State_Active);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r1, =sTripleGrindRailSingleton
	mov r8, r0
	ldr r0, [r1, #0]
	ldr r4, =0x00000488
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r0, #0xe04]
	tst r0, #1
	addne sp, sp, #0x18
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	add r5, r4, #0x1e4
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl GetTaskWork_
	add r2, r4, #0x1e4
	mov r1, #0
	mov r5, r0
	bl MI_CpuFill8
	mov r0, #3
	strh r0, [r5]
	bl GetStageRingScale
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	add r0, r8, #0x600
	ldrsh r10, [r0, #0x7e]
	mov r1, #0
	add lr, r5, #0x16c
	strh r1, [r0, #0x7e]
	cmp r10, #0x40
	movgt r10, #0x40
	add ip, sp, #0xc
	str r10, [r5, #0x168]
	add r0, r8, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, =gRingManagerWork
	ldrb r1, [r8, #0x5d1]
	ldr r0, [r0, #0]
	cmp r10, #0
	add r0, r0, r1
	ldrb r1, [r0, #0x364]
	add r0, r5, #0x6c
	add r8, r0, #0x400
	add r9, lr, #0x400
	add r4, r4, r1, lsl #8
	mov r11, #0
	ble _02163F14
	ldr r3, =FX_SinCosTable_
_02163E88:
	ldmia ip, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	cmp r4, #0
	blt _02163EF4
	mov r1, r4, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	mov r2, r1, lsl #1
	add r1, r3, r1, lsl #1
	ldrsh r6, [r3, r2]
	ldrsh r2, [r1, #2]
	mov r0, r4, asr #8
	cmp r0, #6
	add r1, r4, #0x10
	rsbge r0, r0, #9
	mov r4, r6, lsl #4
	mov r4, r4, asr r0
	mov r2, r2, lsl #4
	mov r0, r2, asr r0
	sub r6, r4, r4, asr #2
	sub r7, r0, r0, asr #2
	orr r4, r1, #0x80
_02163EF4:
	str r6, [r8], #4
	add r11, r11, #1
	cmp r11, r10
	str r7, [r9], #4
	rsb r4, r4, #0
	rsb r6, r6, #0
	add lr, lr, #0xc
	blt _02163E88
_02163F14:
	ldr r0, [r5, #0x18]
	ldr r1, =TripleGrindRailRingLoss__Draw
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	ldr r0, =TripleGrindRailRingLoss__State_Active
	orr r2, r2, #0x2100
	str r2, [r5, #0x1c]
	str r1, [r5, #0xfc]
	str r0, [r5, #0xf4]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void TripleGrindRailSpring__State_Active(TripleGrindRailSpring *work)
{
    if (work->gameWork.animator.ani.work.animID != 1)
        return;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
        return;

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~(OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME);
    StageTask__SetAnimation(&work->gameWork.objWork, 0);
}

void TripleGrindRailSpring__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    TripleGrindRailSpring *railSpring = (TripleGrindRailSpring *)rect2->parent;
    Player *player                    = (Player *)rect1->parent;
    if (railSpring == NULL)
        return;
    if ((player == NULL) || (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER))
        return;

    player->objWork.position.x = railSpring->gameWork.objWork.position.x;
    player->objWork.position.y = railSpring->gameWork.objWork.position.y;
    StageTask__SetAnimation(&railSpring->gameWork.objWork, 1);
    s32 springStrength = MTM_MATH_CLIP_3(railSpring->gameWork.mapObject->left, 0x30, 0x40);
    fx32 velocityX     = FX32_FROM_WHOLE(springStrength << 0x3) / 90;
    fx32 velocityY     = FLOAT_TO_FX32(-17.06640625);
    Player__Action_TripleGrindRailStartSpring(player, &railSpring->gameWork, velocityX, velocityY);
    player->overSpeedLimitTimer     = 90;
    player->objWork.gravityStrength = FLOAT_TO_FX32(0.379150390625);
    Player__Action_AllowTrickCombos(player, &railSpring->gameWork);
}

void TripleGrindRail__Destructor(Task *task)
{
    for (s32 i = 0; i < TRIPLEGRINDRAIL_PARTICLE_COUNT; i++)
    {
        AnimatorSprite3D__Release(&sTripleGrindRailSingleton->aniDecorations[i]);
    }
    AnimatorSprite3D__Release(&sTripleGrindRailSingleton->aniRing);
    AnimatorSprite3D__Release(&sTripleGrindRailSingleton->aniRingSparkle);

    sTripleGrindRailSingleton = NULL;
    g_obj.scroll.x            = 0;
    SetStageRingScale(FLOAT_TO_FX32(1.0));
    GameObject__Destructor(task);
}

void TripleGrindRail__State_WaitUntilPlayerOnRails(TripleGrindRail *work)
{
    work->gameWork.objWork.offset.x = TRIPLEGRINDRAIL_X_OFFSET;
    if (work->gameWork.objWork.dir.x != 0)
    {
        work->gameWork.objWork.dir.x = work->gameWork.objWork.dir.x - FLOAT_DEG_TO_IDX(4.658203125);
        if ((work->gameWork.objWork.dir.x == 0) || (work->gameWork.objWork.dir.x > FLOAT_TO_FX32(8.0)))
            work->gameWork.objWork.dir.x = 0;

        MTX_Identity33(&work->aniTripleGrindRail.ani.work.rotation.nnMtx[0]);
        s32 index = (u16)(-work->gameWork.objWork.dir.x);
        MTX_RotX33(&work->aniTripleGrindRail.ani.work.rotation.nnMtx[0], SinFX(index), CosFX(index));
    }

    Player *player = (Player *)work->gameWork.parent;
    if (CheckPlayerGimmickObj(work->gameWork.parent, work) == FALSE || (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.parent = NULL;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_Destroy);
        work->gameWork.objWork.userWork = 600;
        return;
    }

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
        return;

    Player__Gimmick_TripleGrindRail(player);
    player->gimmickFlag |= PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X | PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y;
    SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_PlayerGrinding);
    work->scrollAndAniSpeedMultiplier = FLOAT_TO_FX32(0.25);
}

RUSH_INLINE fx32 FX32_AddSignBit(fx32 val)
{
    s32 signBit = (u32)(val >> (FX32_DEC_SIZE - 1)) >> (FX32_INT_SIZE + 1);
    return val + signBit;
}

NONMATCH_FUNC void TripleGrindRail__State_PlayerGrinding(TripleGrindRail *work)
{
    // https://decomp.me/scratch/OjJOV => 99.92%, bad regalloc
#ifdef NON_MATCHING
    VecFx32 positionLeaf;
    VecFx32 scaleLeaf;
    VecFx32 positionMushroom;
    VecFx32 scaleMushroom;
    StageDisplayFlags displayFlagsLeaf;
    StageDisplayFlags displayFlagsMushroom;
    TripleGrindRailParticle *currentLeafParticle;
    TripleGrindRailParticle *currentMushroomParticle;
    Player *player;
    s32 listIndexUnusedParticle;

    work->gameWork.objWork.offset.x = TRIPLEGRINDRAIL_X_OFFSET;
    player                          = (Player *)work->gameWork.parent;

    if (!CheckPlayerGimmickObj(player, work) || (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.parent = NULL;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_Destroy);
        work->gameWork.objWork.userWork = 600;
        return;
    }

    if (work->railStartExitX <= work->gameWork.objWork.position.x)
    {
        Player__PrepareTripleGrindRailExit(player);
        player->gimmickFlag &= ~(PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X | PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y);
        g_obj.scroll.x                               = 0;
        work->aniTripleGrindRail.ani.speedMultiplier = 0;
        work->flags |= TRIPLEGRINDRAIL_FLAG_EXIT_STARTED;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_PlayerExiting);
        return;
    }

    if ((work->railStartExitX - FLOAT_TO_FX32(9.375)) <= work->gameWork.objWork.position.x)
    {
        work->flags |= TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START;
        player->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ;
    }
    else if ((work->railStartExitX - FLOAT_TO_FX32(31.875)) <= work->gameWork.objWork.position.x)
    {
        work->flags |= TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START;
    }

    work->scrollAndAniSpeedMultiplier += FLOAT_TO_FX32(0.00390625);
    if (work->scrollAndAniSpeedMultiplier > FLOAT_TO_FX32(1.0))
        work->scrollAndAniSpeedMultiplier = FLOAT_TO_FX32(1.0);

    s32 val        = FX32_AddSignBit(work->scrollAndAniSpeedMultiplier * FLOAT_TO_FX32(0.375));
    g_obj.scroll.x = FX32_TO_WHOLE(val);

    // equal to work->scrollAndAniSpeedMultiplier * 6
    fx32 move = (work->scrollAndAniSpeedMultiplier << 2) + (work->scrollAndAniSpeedMultiplier << 1);
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapFarSys__AdvanceScrollSpeed(GRAPHICS_ENGINE_A, move);
        MapFarSys__AdvanceScrollSpeed(GRAPHICS_ENGINE_B, move);
    }
    else
    {
        MapFarSys__AdvanceScrollSpeed(player->cameraID, move);
    }

    s32 lsm                                      = FX32_AddSignBit(work->scrollAndAniSpeedMultiplier << 12);
    work->aniTripleGrindRail.ani.speedMultiplier = (lsm >> 12) << 2;

    // Weird bit-shifting, since it doesn't increase precision in computing the quotient
    s32 quotient        = (work->aniTripleGrindRail.ani.speedMultiplier << 14) / 60;
    work->sequenceSpeed = quotient >> 14;
    AnimatorSprite3D__ProcessAnimation(&work->aniRing, NULL, NULL);

    scaleLeaf               = sLeafParticleDefaultScale;
    displayFlagsLeaf        = DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
    currentLeafParticle     = &work->leafList[0];
    listIndexUnusedParticle = -1;
    for (int i = 0; i < TRIPLEGRINDRAIL_LEAF_COUNT; i++, currentLeafParticle++)
    {
        if (currentLeafParticle->y == TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE)
        {
            listIndexUnusedParticle = i;
        }
        else
        {
            // equal to currentLeafParticle->angle -= sTripleGrindRailSingleton->sequenceSpeed * 5 / 4
            currentLeafParticle->angle -= sTripleGrindRailSingleton->sequenceSpeed + (sTripleGrindRailSingleton->sequenceSpeed >> 2);
            if ((currentLeafParticle->angle <= TRIPLEGRINDRAIL_PARTICLE_END_ANGLE) || (currentLeafParticle->y < FLOAT_TO_FX32(-400.0)))
            {
                currentLeafParticle->y  = TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE;
                listIndexUnusedParticle = i;
            }
            else
            {
                currentLeafParticle->y = -(sTripleGrindRailSingleton->sequenceSpeed * 16) + currentLeafParticle->y;
                s32 particleType       = currentLeafParticle->type;

                fx32 cos       = CosFX(currentLeafParticle->angle);
                fx32 cosByRad  = FX_MulInline(cos, currentLeafParticle->radius);
                positionLeaf.x = sTripleGrindRailSingleton->gameWork.objWork.position.x + cosByRad + TRIPLEGRINDRAIL_X_OFFSET;
                positionLeaf.y = currentLeafParticle->y + sTripleGrindRailSingleton->gameWork.objWork.position.y;
                fx32 sin       = SinFX(currentLeafParticle->angle);
                positionLeaf.z = FX_MulInline(sin, currentLeafParticle->radius);
                StageTask__Draw3DEx(&work->aniDecorations[particleType].work, &positionLeaf, NULL, &scaleLeaf, &displayFlagsLeaf, NULL, NULL, NULL);
            }
        }
    }

    // Try spawning a new leaf if there is a spot for it and if it is time to do so.
    if ((work->flags & (TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START | TRIPLEGRINDRAIL_FLAG_EXIT_STARTED)) == 0)
    {
        work->countFramesToNextLeafParticle--;
        if ((work->countFramesToNextLeafParticle <= 0) && (listIndexUnusedParticle != -1))
        {
            s32 val = 256 - sTripleGrindRailSingleton->sequenceSpeed;
            TripleGrindRail__CreateLeafParticle(&work->leafList[listIndexUnusedParticle]);
            s32 val2                            = (val >> 3) + (val >> 5); // equal to val * 5 / 32
            work->countFramesToNextLeafParticle = MTM_MATH_CLIP_3(val2, 3, 0x30);
        }
    }

    displayFlagsMushroom    = DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
    scaleMushroom           = sMushroomParticleDefaultScale;
    listIndexUnusedParticle = -1;
    currentMushroomParticle = &work->mushroomList[0];
    for (int i = 0; i < TRIPLEGRINDRAIL_MUSHROOM_COUNT; i++, currentMushroomParticle++)
    {
        if (currentMushroomParticle->y == TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE)
        {
            listIndexUnusedParticle = i;
        }
        else
        {
            currentMushroomParticle->angle = currentMushroomParticle->angle - sTripleGrindRailSingleton->sequenceSpeed;
            if (currentMushroomParticle->angle <= TRIPLEGRINDRAIL_PARTICLE_END_ANGLE)
            {
                currentMushroomParticle->y = TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE;
                listIndexUnusedParticle    = i;
            }
            else
            {
                fx32 cos           = CosFX((s32)currentMushroomParticle->angle);
                fx32 cosRad        = FX_MulInline(cos, currentMushroomParticle->radius);
                positionMushroom.x = sTripleGrindRailSingleton->gameWork.objWork.position.x + cosRad + TRIPLEGRINDRAIL_X_OFFSET;
                positionMushroom.y = currentMushroomParticle->y + sTripleGrindRailSingleton->gameWork.objWork.position.y;
                fx32 sin           = SinFX(currentMushroomParticle->angle);
                fx32 sinRad        = FX_MulInline(sin, currentMushroomParticle->radius);
                positionMushroom.z = sinRad;
                StageTask__Draw3DEx(&work->aniDecorations[TRIPLEGRINDRAIL_PARTICLE_MUSHROOM].work, &positionMushroom, NULL, &scaleMushroom, &displayFlagsMushroom, NULL, NULL,
                                    NULL);
            }
        }
    }

    if ((work->flags & (TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START | TRIPLEGRINDRAIL_FLAG_EXIT_STARTED)) != 0)
        return;

    work->countFramesToNextMushroomParticle--;
    if ((work->countFramesToNextMushroomParticle > 0) || (listIndexUnusedParticle == -1))
        return;

    s32 val2 = 256 - sTripleGrindRailSingleton->sequenceSpeed;
    TripleGrindRail__CreateMushroomParticle(&work->mushroomList[listIndexUnusedParticle]);

    s32 clampedVal                          = MTM_MATH_CLIP_3(val2, 20, 165);
    s32 randVal                             = mtMathRandRepeat(0x20);
    work->countFramesToNextMushroomParticle = randVal + clampedVal;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r1, =0x00141BB2
	mov r6, r0
	str r1, [r6, #0x50]
	ldr r4, [r6, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r6
	bne _02164210
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _02164230
_02164210:
	mov r1, #0
	ldr r0, =TripleGrindRail__State_Destroy
	str r1, [r6, #0x35c]
	str r0, [r6, #0xf4]
	mov r0, #0x258
	add sp, sp, #0x50
	str r0, [r6, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164230:
	ldr r2, [r6, #0x44]
	ldr r1, [r6, #0xe08]
	cmp r1, r2
	bgt _02164280
	mov r0, r4
	bl Player__PrepareTripleGrindRailExit
	ldr r1, [r4, #0x5dc]
	ldr r0, =g_obj
	bic r1, r1, #0x600
	str r1, [r4, #0x5dc]
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r6, #0x47c]
	ldr r1, [r6, #0xe04]
	ldr r0, =TripleGrindRail__State_PlayerExiting
	orr r1, r1, #2
	str r1, [r6, #0xe04]
	add sp, sp, #0x50
	str r0, [r6, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164280:
	sub r0, r1, #0x9600
	cmp r0, r2
	bgt _021642A8
	ldr r0, [r6, #0xe04]
	orr r0, r0, #1
	str r0, [r6, #0xe04]
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #0x200000
	str r0, [r4, #0x5d8]
	b _021642C0
_021642A8:
	ldr r0, =0xFFFE0200
	add r0, r1, r0
	cmp r0, r2
	ldrle r0, [r6, #0xe04]
	orrle r0, r0, #1
	strle r0, [r6, #0xe04]
_021642C0:
	ldr r0, [r6, #0xe0c]
	add r0, r0, #0x10
	str r0, [r6, #0xe0c]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r6, #0xe0c]
	ldr r1, [r6, #0xe0c]
	mov r0, #0x600
	mul r2, r1, r0
	mov r0, r2, asr #0xb
	add r0, r2, r0, lsr #20
	ldr r1, =g_obj
	mov r0, r0, asr #0xc
	str r0, [r1, #0x14]
	ldr r0, =mapCamera
	ldr r2, [r6, #0xe0c]
	ldr r0, [r0, #0xe0]
	mov r1, r2, lsl #1
	tst r0, #1
	add r5, r1, r2, lsl #2
	beq _02164330
	mov r1, r5
	mov r0, #0
	bl MapFarSys__AdvanceScrollSpeed
	mov r1, r5
	mov r0, #1
	bl MapFarSys__AdvanceScrollSpeed
	b _0216433C
_02164330:
	ldrb r0, [r4, #0x5d3]
	mov r1, r5
	bl MapFarSys__AdvanceScrollSpeed
_0216433C:
	ldr r0, [r6, #0xe0c]
	ldr r2, =0x88888889
	mov r1, r0, lsl #0xc
	mov r0, r1, asr #0xb
	add r0, r1, r0, lsr #20
	mov r0, r0, asr #0xc
	mov r7, r0, lsl #2
	mov r3, r7, lsl #0xe
	smull r0, r5, r2, r3
	mov r0, r3, lsr #0x1f
	add r5, r5, r7, lsl #14
	mov r1, #0
	add r5, r0, r5, asr #5
	add r4, r6, #0x3fc
	mov r2, r1
	str r7, [r6, #0x47c]
	mov r5, r5, asr #0xe
	add r3, r6, #0xe00
	add r0, r4, #0x800
	strh r5, [r3, #0x14]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, =sLeafParticleDefaultScale
	add r4, r6, #0x218
	mov r5, #0x1100
	str r5, [sp, #0x1c]
	add r3, sp, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x190000
	str r0, [sp, #0x14]
	add r0, r6, #0x4e0
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r7, =sTripleGrindRailSingleton
	rsb r0, r0, #0
	add r4, r4, #0xc00
	mvn r11, #0
	mov r5, #0
	str r0, [sp, #0x14]
_021643D8:
	ldr r0, [r4, #4]
	cmp r0, #0x100000
	moveq r11, r5
	beq _02164514
	ldr r0, [r7, #0]
	ldrh r1, [r4, #8]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	add r0, r0, r0, asr #2
	sub r0, r1, r0
	strh r0, [r4, #8]
	ldrh r1, [r4, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bls _02164424
	ldr r0, [r4, #4]
	ldr r1, [sp, #0x14]
	cmp r0, r1
	bge _02164434
_02164424:
	mov r0, #0x100000
	str r0, [r4, #4]
	mov r11, r5
	b _02164514
_02164434:
	ldr r2, [r7, #0]
	add r1, sp, #0x44
	add r2, r2, #0xe00
	ldrh r8, [r2, #0x14]
	mov r2, #0
	add r3, sp, #0x38
	mov r8, r8, lsl #4
	rsb r8, r8, #0
	add r0, r0, r8
	str r0, [r4, #4]
	ldrh r0, [r4, #0xa]
	ldrh r10, [r4, #8]
	ldr ip, [r4]
	add r8, r0, r0, lsl #6
	ldr r0, [sp, #0x10]
	mov r10, r10, asr #4
	add r0, r0, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldr r9, [r7, #0]
	add r8, r8, r10, lsl #2
	ldrsh r10, [r8, #2]
	ldr r8, [r9, #0x44]
	smull lr, ip, r10, ip
	adds lr, lr, #0x800
	mov r10, r2
	adc r10, ip, r10
	mov ip, lr, lsr #0xc
	orr ip, ip, r10, lsl #20
	add r10, r8, ip
	ldr r8, =0x00141BB2
	add r8, r10, r8
	str r8, [sp, #0x44]
	ldr r8, [r9, #0x48]
	ldr r9, [r4, #4]
	add r8, r9, r8
	str r8, [sp, #0x48]
	ldrh r8, [r4, #8]
	ldr r9, [r4, #0]
	mov r8, r8, asr #4
	mov r10, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldrsh r8, [r8, r10]
	smull r10, r9, r8, r9
	adds r10, r10, #0x800
	mov r8, r2
	adc r8, r9, r8
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	str r9, [sp, #0x4c]
	add r8, sp, #0x1c
	str r8, [sp]
	mov r8, r2
	str r8, [sp, #4]
	str r8, [sp, #8]
	str r8, [sp, #0xc]
	bl StageTask__Draw3DEx
_02164514:
	add r5, r5, #1
	cmp r5, #0x40
	add r4, r4, #0xc
	blt _021643D8
	ldr r0, [r6, #0xe04]
	tst r0, #3
	bne _021645A4
	add r0, r6, #0xe00
	ldrsh r1, [r0, #0x16]
	sub r1, r1, #1
	strh r1, [r0, #0x16]
	ldrsh r0, [r0, #0x16]
	cmp r0, #0
	bgt _021645A4
	mvn r0, #0
	cmp r11, r0
	beq _021645A4
	ldr r1, =sTripleGrindRailSingleton
	add r0, r6, #0x218
	ldr r3, [r1, #0]
	add r2, r0, #0xc00
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r11, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateLeafParticle
	mov r0, r4, asr #5
	add r1, r0, r4, asr #3
	cmp r1, #3
	movlt r1, #3
	blt _0216459C
	cmp r1, #0x30
	movgt r1, #0x30
_0216459C:
	add r0, r6, #0xe00
	strh r1, [r0, #0x16]
_021645A4:
	ldr r0, =sMushroomParticleDefaultScale
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	mov r5, #0x1100
	add r4, r6, #0x11c
	str r5, [sp, #0x18]
	add r5, r4, #0x1000
	stmia r3, {r0, r1, r2}
	ldr r4, =FX_SinCosTable_
	mvn r8, #0
	mov r7, #0
	add r9, r6, #0x2f8
_021645D4:
	ldr r0, [r5, #4]
	cmp r0, #0x100000
	moveq r8, r7
	beq _021646D4
	ldr r0, =sTripleGrindRailSingleton
	ldrh r1, [r5, #8]
	ldr r0, [r0, #0]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	strh r0, [r5, #8]
	ldrh r1, [r5, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bhi _02164620
	mov r0, #0x100000
	str r0, [r5, #4]
	mov r8, r7
	b _021646D4
_02164620:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r0, r4, r0, lsl #2
	ldrsh r3, [r0, #2]
	ldr r2, [r5, #0]
	ldr r0, =sTripleGrindRailSingleton
	smull r11, r10, r3, r2
	adds r3, r11, #0x800
	ldr r1, [r0, #0]
	adc r2, r10, #0
	mov r3, r3, lsr #0xc
	ldr r0, [r1, #0x44]
	orr r3, r3, r2, lsl #20
	add r2, r0, r3
	ldr r0, =0x00141BB2
	add r3, sp, #0x20
	add r0, r2, r0
	str r0, [sp, #0x2c]
	ldr r1, [r1, #0x48]
	ldr r2, [r5, #4]
	add r0, r9, #0x800
	add r1, r2, r1
	str r1, [sp, #0x30]
	ldrh r2, [r5, #8]
	ldr r11, [r5, #0]
	add r1, sp, #0x2c
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r10, [r4, r2]
	mov r2, #0
	smull ip, r11, r10, r11
	adds r10, ip, #0x800
	mov ip, r2
	adc r11, r11, ip
	mov r10, r10, lsr #0xc
	orr r10, r10, r11, lsl #20
	str r10, [sp, #0x34]
	add r10, sp, #0x18
	str r10, [sp]
	mov r10, r2
	str r10, [sp, #4]
	str r10, [sp, #8]
	str r10, [sp, #0xc]
	bl StageTask__Draw3DEx
_021646D4:
	add r7, r7, #1
	cmp r7, #8
	add r5, r5, #0xc
	blt _021645D4
	ldr r0, [r6, #0xe04]
	tst r0, #3
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r6, #0x1100
	ldrsh r1, [r0, #0x18]
	sub r1, r1, #1
	strh r1, [r0, #0x18]
	ldrsh r0, [r0, #0x18]
	cmp r0, #0
	addgt sp, sp, #0x50
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, #0
	cmp r8, r0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, =sTripleGrindRailSingleton
	add r0, r6, #0x11c
	ldr r3, [r1, #0]
	add r2, r0, #0x1000
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r8, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateMushroomParticle
	cmp r4, #0x14
	movlt r4, #0x14
	blt _02164760
	cmp r4, #0xa5
	movgt r4, #0xa5
_02164760:
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r5, [r3, #0]
	ldr r1, =0x3C6EF35F
	add r2, r6, #0x1100
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, r4
	strh r0, [r2, #0x18]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void TripleGrindRail__CreateLeafParticle(TripleGrindRailParticle *particle)
{
    TripleGrindRailParticleType particleTypeList[8];
    ARRAY_COPY(particleTypeList, sLeafParticleTypes);
    s32 newY                    = 0x80 - mtMathRandRepeat(0x200);
    particle->y                 = FX32_FROM_WHOLE(newY);
    s32 randVal                 = mtMathRandRepeat(0x40) - 0x1F;
    particle->radius            = randVal * FLOAT_TO_FX32(3.2998046875) + TRIPLEGRINDRAIL_X_OFFSET;
    particle->angle             = FLOAT_DEG_TO_IDX(299.99267578125);
    particle->type              = particleTypeList[mtMathRand() & 0x7];
}

void TripleGrindRail__CreateMushroomParticle(TripleGrindRailParticle *particle)
{
    particle->y      = FX32_FROM_WHOLE(mtMathRandRepeat(0x20) + 8);
    particle->radius = FLOAT_TO_FX32(463.62255859375);
    particle->angle  = FLOAT_DEG_TO_IDX(304.991455078125);
}

void TripleGrindRail__State_PlayerExiting(TripleGrindRail *work)
{
    if (work->gameWork.parent->userTimer != 0)
        work->zOffset = work->gameWork.parent->userTimer;
    work->gameWork.objWork.offset.x = TRIPLEGRINDRAIL_X_OFFSET;
    work->gameWork.objWork.offset.z = work->zOffset;
    if (work->gameWork.parent->userWork == 0)
        return;
    SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_Destroy);
    work->gameWork.objWork.userWork = work->gameWork.parent->userWork;
}

void TripleGrindRail__State_Destroy(TripleGrindRail *work)
{
    work->gameWork.objWork.userWork--;
    if (work->gameWork.objWork.userWork == 0)
        DestroyStageTask(&work->gameWork.objWork);

    work->gameWork.objWork.offset.x = TRIPLEGRINDRAIL_X_OFFSET;
    work->gameWork.objWork.offset.z = work->zOffset;
}

void TripleGrindRail__OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    TripleGrindRail *rail = (TripleGrindRail *)rect2->parent;
    Player *player        = (Player *)rect1->parent;

    if ((rail == NULL) || (player == NULL) || (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER))
        return;

    if (!StageTaskStateMatches(&player->objWork, Player__State_TripleGrindRailStartSpring))
        return;

    rail->flags &= ~TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START;
    rail->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    rail->gameWork.parent = &player->objWork;
    Player__Action_TripleGrindRailEndSpring(player, &rail->gameWork);
    SetStageRingScale(FLOAT_TO_FX32(2.0));
    SetTaskState(&rail->gameWork.objWork, TripleGrindRail__State_WaitUntilPlayerOnRails);
    rail->gameWork.objWork.dir.x = FLOAT_DEG_TO_IDX(67.5);
    rail->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    rail->aniTripleGrindRail.ani.speedMultiplier = FLOAT_TO_FX32(0.0);
    rail->gameWork.collisionObject.work.parent   = &rail->gameWork.objWork;
}

void TripleGrindRailEntity__State_Inactive(TripleGrindRailEntity *work)
{
    if ((sTripleGrindRailSingleton == NULL) || (sTripleGrindRailSingleton->flags & (TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START | TRIPLEGRINDRAIL_FLAG_EXIT_STARTED)) != 0)
    {
        DestroyStageTask(&work->gameWork.objWork);
        return;
    }

    if (work->gameWork.objWork.position.x > (sTripleGrindRailSingleton->gameWork.objWork.position.x + FX32_FROM_WHOLE(0xA0)))
        return;

    work->angle = FLOAT_DEG_TO_IDX(289.9951171875);
    work->gameWork.objWork.displayFlag &= ~STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;
    SetTaskState(&work->gameWork.objWork, TripleGrindRailEntity__State_Active);
    TripleGrindRailEntity__State_Active(work);

    if (work->gameWork.mapObject->id == MAPOBJECT_123)
        SetTaskOutFunc(&work->gameWork.objWork, TripleGrindRailEntity__Draw);
}

void TripleGrindRailEntity__State_Active(TripleGrindRailEntity *work)
{
    if ((sTripleGrindRailSingleton == NULL) || (g_obj.scroll.x == 0) || ((sTripleGrindRailSingleton->flags & TRIPLEGRINDRAIL_FLAG_EXIT_STARTED) != 0))
    {
        DestroyStageTask(&work->gameWork.objWork);
        return;
    }

    work->angle = work->angle - sTripleGrindRailSingleton->sequenceSpeed;
    if (work->angle <= FLOAT_DEG_TO_IDX(160.0048828125))
    {
        DestroyStageTask(&work->gameWork.objWork);
        return;
    }

    if (work->gameWork.mapObject->id == MAPOBJECT_122)
        work->aniSprite.ani.animatorSprite.animAdvance = sTripleGrindRailSingleton->aniTripleGrindRail.ani.speedMultiplier >> 1;

    fx32 cos                          = CosFX(work->angle);
    fx32 cosRad                       = MultiplyFX(cos, work->radius);
    work->gameWork.objWork.position.x = sTripleGrindRailSingleton->gameWork.objWork.position.x + cosRad + TRIPLEGRINDRAIL_X_OFFSET;

    fx32 sin                          = SinFX(work->angle);
    fx32 sinRad                       = MultiplyFX(sin, work->radius);
    work->gameWork.objWork.position.z = sinRad;
}

void TripleGrindRailEntity__Draw(void)
{
    StageDisplayFlags flags;
    TripleGrindRailEntity *work = TaskGetWorkCurrent(TripleGrindRailEntity);
    if ((work->gameWork.flags & GAMEOBJECT_FLAG_USER_1) != 0)
    {
        flags = DISPLAY_FLAG_DISABLE_ROTATION;
        StageTask__Draw3DEx(&work->aniSprite.ani.work, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &flags, NULL, NULL, NULL);
        if ((flags & DISPLAY_FLAG_UNKNOWN_40000000) != 0)
            DestroyStageTask(&work->gameWork.objWork);
    }
    else
    {
        flags = DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
        StageTask__Draw3DEx(&sTripleGrindRailSingleton->aniRing.work, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &flags, NULL, NULL, NULL);
    }
}

void TripleGrindRailEntity__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    TripleGrindRailEntity *railEntity = (TripleGrindRailEntity *)rect2->parent;
    Player *player                    = (Player *)rect1->parent;

    if (railEntity == NULL)
        return;

    if ((player == NULL) || (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER) || (player->controlID != PLAYER_CONTROL_P1))
        return;

    Player__GiveRings(player, 1);
    railEntity->gameWork.flags |= GAMEOBJECT_FLAG_USER_1;
    railEntity->gameWork.flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;
    railEntity->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
}

void TripleGrindRailRingLoss__State_Active(TripleGrindRailRingLoss *work)
{
    BOOL allRingsOffscreen;
    s32 i;
    s32 ringCount;
    VecFx32 *ringPosition;
    fx32 *ringVelocityX;
    fx32 *ringVelocityY;

    allRingsOffscreen = TRUE;
    ringCount         = work->ringCount;
    if ((sTripleGrindRailSingleton == NULL) || (g_obj.scroll.x == 0) || (sTripleGrindRailSingleton->flags & TRIPLEGRINDRAIL_FLAG_EXIT_STARTED) != 0)
    {
        DestroyStageTask(&work->objWork);
        return;
    }

    ringPosition  = &work->ringPosition[0];
    ringVelocityX = &work->ringVelocityX[0];
    ringVelocityY = &work->ringVelocityY[0];
    for (i = 0; i < ringCount; i++)
    {
        ringPosition->x += *ringVelocityX;
        s32 gravityStrength = gSpillRingGravityStrength;
        ringPosition->y += *ringVelocityY + gravityStrength;
        *ringVelocityY += gravityStrength;
        if (StageTask__ViewOutCheck(ringPosition->x, ringPosition->y, 0x20, 0, 0, 0, 0) == FALSE)
            allRingsOffscreen = FALSE;

        ringPosition++;
        ringVelocityX++;
        ringVelocityY++;
    }

    if (allRingsOffscreen)
        DestroyStageTask(&work->objWork);
}

void TripleGrindRailRingLoss__Draw(void)
{
    TripleGrindRailRingLoss *work;
    s32 i;
    s32 ringCount;
    VecFx32 scale;
    StageDisplayFlags displayFlag;

    work        = TaskGetWorkCurrent(TripleGrindRailRingLoss);
    scale       = work->objWork.scale;
    displayFlag = DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
    ringCount   = work->ringCount;
    for (i = 0; i < ringCount; i++)
    {
        StageTask__Draw3DEx(&sTripleGrindRailSingleton->aniRing.work, &work->ringPosition[i], NULL, &scale, &displayFlag, NULL, NULL, NULL);
    }
}
