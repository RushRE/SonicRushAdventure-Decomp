#include <stage/objects/swingRope.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// CONSTANTS
// --------------------

#define SWINGROPE_COLLIDER_NODE_INDEX_OFFSET 16

// --------------------
// ENUMS
// --------------------

enum SwingRopeObjectFlags
{
    SWINGROPE_OBJFLAG_NONE,

    SWINGROPE_OBJFLAG_USE_START_OFFSET = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

void SwingRope_Destructor(Task *task);
void SwingRope_Action_Init(SwingRope *work);
void SwingRope_State_Swing(SwingRope *work);
void SwingRope_Draw(void);
void SwingRope_Collide(void);
void SwingRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SwingRope_HandleNodePositions(SwingRope *work);

// --------------------
// FUNCTIONS
// --------------------

// TEMP
NOT_DECOMPILED void _s32_div_f(void);

void *CreateSwingRope(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    s32 i;

    Task *task = CreateStageTask(SwingRope_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), SwingRope);
    if (task == HeapNull)
        return NULL;

    SwingRope *work = TaskGetWork(task, SwingRope);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->nodeCount = SWINGROPE_NODE_COUNT;

    s16 timer;
    if ((mapObject->flags & SWINGROPE_OBJFLAG_USE_START_OFFSET) != 0)
        timer = (playerGameStatus.stageTimer + 90) % 180;
    else
        timer = playerGameStatus.stageTimer % 180;

    work->swingTimer    = timer;
    work->swingProgress = 91 * timer;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_rope_tar.bac", GetObjectDataWork(OBJDATAWORK_161), gGameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetObjectSpriteRef(OBJDATAWORK_162));
    StageTask__SetAnimation(&work->gameWork.objWork, 0);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 11);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    OBS_ACTION2D_BAC_WORK *aniNode = &work->aniNode;
    aniNode->spriteRef             = GetObjectSpriteRef(OBJDATAWORK_164);
    AnimatorSpriteDS__Init(
        &aniNode->ani, work->gameWork.objWork.obj_2d->fileWork->fileData, 1, ANIMATORSPRITEDS_FLAG_NONE, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_PALETTES,
        PIXEL_MODE_SPRITE, ObjActionAllocSprite(&aniNode->spriteRef->engineRef[0], GRAPHICS_ENGINE_A, 1), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
        ObjActionAllocSprite(&aniNode->spriteRef->engineRef[1], GRAPHICS_ENGINE_B, 1), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_2, SPRITE_ORDER_23);
    aniNode->ani.cParam[1].palette = aniNode->ani.cParam[0].palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniNode->ani.work.cParam.palette                                = aniNode->ani.cParam[0].palette;

    ObjRect__SetGroupFlags(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], 2, 1);
    ObjRect__SetBox3D(&work->colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -4, -4, -16, 4, 4, 16);
    ObjRect__SetAttackStat(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], SwingRope_OnDefend);
    work->colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    OBS_RECT_WORK *collider = &work->colliders[GAMEOBJECT_COLLIDER_ATK];
    for (i = 1; i < work->nodeCount; i++)
    {
        MI_CpuCopy8(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], collider, sizeof(work->colliders[GAMEOBJECT_COLLIDER_WEAK]));
        collider->rect.front = SWINGROPE_COLLIDER_NODE_INDEX_OFFSET + i;
        collider++;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    SwingRope_Action_Init(work);

    return work;
}

void SwingRope_Destructor(Task *task)
{
    SwingRope *work = TaskGetWork(task, SwingRope);

    ObjActionReleaseSprite(&work->aniNode.spriteRef->engineRef[0], GRAPHICS_ENGINE_A);
    ObjActionReleaseSprite(&work->aniNode.spriteRef->engineRef[1], GRAPHICS_ENGINE_B);

    GameObject__Destructor(task);
}

void SwingRope_Action_Init(SwingRope *work)
{
    SetTaskState(&work->gameWork.objWork, SwingRope_State_Swing);
    SetTaskOutFunc(&work->gameWork.objWork, SwingRope_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, SwingRope_Collide);
}

void SwingRope_State_Swing(SwingRope *work)
{
    work->swingTimer++;
    if (work->swingTimer >= SECONDS_TO_FRAMES(3.0))
        work->swingTimer = 0;
    work->swingProgress = (s32)(FLOAT_TO_FX32(4.0) / (float)SECONDS_TO_FRAMES(3.0)) * work->swingTimer;

    SwingRope_HandleNodePositions(work);

    Player *player = (Player *)work->gameWork.parent;
    if (player != NULL)
    {
        if (CheckPlayerGimmickObj(player, work))
        {
            if (work->nodeGrabIndex < work->nodeCount - 1)
            {
                // Update angle & position that the player will grab onto
                work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x + (2 - (work->nodeGrabTimer & 1)) * (work->nodePositions[work->nodeGrabIndex].x >> 1)
                                                        + (work->nodeGrabTimer & 1) * (work->nodePositions[work->nodeGrabIndex + 1].x >> 1);

                work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + (2 - (work->nodeGrabTimer & 1)) * (work->nodePositions[work->nodeGrabIndex].y >> 1)
                                                        + (work->nodeGrabTimer & 1) * (work->nodePositions[work->nodeGrabIndex + 1].y >> 1);

                work->gameWork.objWork.dir.z =
                    (2 - (work->nodeGrabTimer & 1)) * (work->nodeAngle[work->nodeGrabIndex] >> 1) + (work->nodeGrabTimer & 1) * (work->nodeAngle[work->nodeGrabIndex + 1] >> 1);

                // Increment timer so the player "slides" down towards the bottom node
                work->nodeGrabTimer++;
                work->nodeGrabIndex = work->nodeGrabTimer >> 1;
            }
            else
            {
                work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x + work->nodePositions[work->nodeGrabIndex].x;
                work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + work->nodePositions[work->nodeGrabIndex].y;
                work->gameWork.objWork.dir.z          = work->nodeAngle[work->nodeGrabIndex];
            }

            if ((work->gameWork.parent->displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->gameWork.objWork.dir.z -= FLOAT_DEG_TO_IDX(90.0f);
            else
                work->gameWork.objWork.dir.z += FLOAT_DEG_TO_IDX(90.0f);
        }
        else
        {
            work->gameWork.parent            = NULL;
            work->gameWork.objWork.userTimer = SECONDS_TO_FRAMES(0.5);
        }
    }
    else
    {
        if (work->gameWork.objWork.userTimer != 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer == 0)
                work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        }
    }
}

void SwingRope_Draw(void)
{
    s32 i;

    SwingRope *work = TaskGetWorkCurrent(SwingRope);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    for (i = 0; i < work->nodeCount; i++)
    {
        VecFx32 position = work->gameWork.objWork.position;

        position.x += work->nodePositions[i].x;
        position.y += work->nodePositions[i].y;
        StageTask__Draw2DEx(&work->aniNode.ani, &position, NULL, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
    }
}

void SwingRope_Collide(void)
{
    s32 i;
    SwingRope *work = TaskGetWorkCurrent(SwingRope);

    OBS_RECT_WORK *colliders = work->colliders;
    s16 nodeCount            = work->nodeCount;

    Player *player = gPlayer;

    if (!IsStageTaskDestroyedAny(&work->gameWork.objWork) && (g_obj.flag & OBJECTMANAGER_FLAG_ALLOW_RECT_COLLISIONS) != 0
        && (work->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
    {
        s32 lastNode   = nodeCount - 1;
        fx32 lastNodeX = work->nodePositions[lastNode].x;

        fx32 left;
        fx32 right;
        if (lastNodeX >= 0)
        {
            left  = work->gameWork.objWork.position.x - FLOAT_TO_FX32(32.0);
            right = work->gameWork.objWork.position.x + lastNodeX + FLOAT_TO_FX32(32.0);
        }
        else
        {
            left  = work->gameWork.objWork.position.x + lastNodeX - FLOAT_TO_FX32(32.0);
            right = work->gameWork.objWork.position.x + FLOAT_TO_FX32(32.0);
        }

        if (player->objWork.position.x >= left && right >= player->objWork.position.x)
        {
            if (player->objWork.position.y >= work->gameWork.objWork.position.y - FLOAT_TO_FX32(32.0)
                && work->gameWork.objWork.position.y + work->nodePositions[lastNode].y + FLOAT_TO_FX32(32.0) >= player->objWork.position.y)
            {
                i = 0;
                if (nodeCount > 0)
                {
                    for (; i < nodeCount; i++)
                    {
                        colliders->rect.pos.x = FX32_TO_WHOLE(work->nodePositions[i].x);
                        colliders->rect.pos.y = FX32_TO_WHOLE(work->nodePositions[i].y);
                        ObjRect__Register(colliders);
                        colliders++;
                    }
                }
            }
        }
    }
}

void SwingRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SwingRope *swingRope = (SwingRope *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (swingRope == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    swingRope->gameWork.parent = &player->objWork;
    swingRope->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    swingRope->nodeGrabIndex                   = rect2->rect.front - SWINGROPE_COLLIDER_NODE_INDEX_OFFSET;
    swingRope->nodeGrabTimer                   = 2 * swingRope->nodeGrabIndex;
    swingRope->gameWork.objWork.prevPosition.x = swingRope->gameWork.objWork.position.x + swingRope->nodePositions[swingRope->nodeGrabIndex].x;
    swingRope->gameWork.objWork.prevPosition.y = swingRope->gameWork.objWork.position.y + swingRope->nodePositions[swingRope->nodeGrabIndex].y;
    swingRope->gameWork.objWork.dir.z          = swingRope->nodeAngle[swingRope->nodeGrabIndex];

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        swingRope->gameWork.objWork.dir.z = swingRope->nodeAngle[swingRope->nodeGrabIndex] - FLOAT_DEG_TO_IDX(90.0);
    else
        swingRope->gameWork.objWork.dir.z = swingRope->nodeAngle[swingRope->nodeGrabIndex] + FLOAT_DEG_TO_IDX(90.0);

    Player__Action_SwingRope(player, &swingRope->gameWork, FLOAT_TO_FX32(0.0), FLOAT_DEG_TO_IDX(90.0));
    Player__ChangeAction(player, PLAYER_ACTION_ROPE_SWING);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
}

NONMATCH_FUNC void SwingRope_HandleNodePositions(SwingRope *work)
{
    // https://decomp.me/scratch/hqvlL -> 74.42%
#ifdef NON_MATCHING
    s32 i;
    u16 swingAngle;
    u16 nodeOffsetAngle;
    s16 swingProgress;
    s32 nodeCount;
    s16 angleStep;

    swingProgress = work->swingProgress;
    nodeCount     = work->nodeCount;
    angleStep     = FLOAT_TO_FX32(1.0) / work->nodeCount;

    if (swingProgress < FLOAT_TO_FX32(1.0))
    {
        swingAngle      = mtLerpEx2(swingProgress, FLOAT_DEG_TO_IDX(150.0), FLOAT_DEG_TO_IDX(90.0), 1);
        nodeOffsetAngle = mtLerpEx2(swingProgress, FLOAT_DEG_TO_IDX(30.0), FLOAT_DEG_TO_IDX(0.0), 3);
    }
    else if (swingProgress < FLOAT_TO_FX32(2.0))
    {
        s16 progress = swingProgress - FLOAT_TO_FX32(1.0);

        swingAngle      = mtLerpEx2(progress, FLOAT_DEG_TO_IDX(90.0), FLOAT_DEG_TO_IDX(30.004), 1);
        nodeOffsetAngle = -mtLerpEx2(progress, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(30.0), 3);
    }
    else if (swingProgress < FLOAT_TO_FX32(3.0))
    {
        s16 progress = swingProgress - FLOAT_TO_FX32(2.0);

        swingAngle      = mtLerpEx2(progress, FLOAT_DEG_TO_IDX(30.004), FLOAT_DEG_TO_IDX(90.0), 1);
        nodeOffsetAngle = -mtLerpEx2(progress, FLOAT_DEG_TO_IDX(30.0), FLOAT_DEG_TO_IDX(0.0), 3);
    }
    else
    {
        s16 progress = swingProgress - FLOAT_TO_FX32(3.0);

        swingAngle      = mtLerpEx2(progress, FLOAT_DEG_TO_IDX(90.0), FLOAT_DEG_TO_IDX(150.0), 1);
        nodeOffsetAngle = mtLerpEx2(progress, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(30.0), 3);
    }

    work->nodeAngle[0]       = swingAngle;
    work->nodePositions[0].x = 16 * CosFX(swingAngle);
    work->nodePositions[0].y = 16 * SinFX(swingAngle);

    s32 angleStart = (nodeOffsetAngle < 0x8000) ? FLOAT_DEG_TO_IDX(0.0) : (s32)(360.0f * (65536.0f / 360.0f));

    for (i = 1; i < nodeCount; i++)
    {
        u16 angle = swingAngle + mtLerpEx2(i * angleStep, angleStart, nodeOffsetAngle, 1);

        work->nodeAngle[i]       = angle;
        work->nodePositions[i].x = work->nodePositions[i - 1].x + 8 * CosFX(angle);
        work->nodePositions[i].y = work->nodePositions[i - 1].y + 8 * SinFX(angle);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r1, r4, #0x400
	ldrsh r0, [r1, #0x14]
	ldrsh r5, [r1, #0x18]
	str r0, [sp]
	ldr r1, [sp]
	mov r0, #0x1000
	bl _s32_div_f
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r5, #0x1000
	str r0, [sp, #8]
	bge _02162A8C
	ldr r2, =0xFFFF9556
	mov r1, r5, asr #0x1f
	mov r0, #1
	mov r7, #0x4000
	mov r6, #0
	mov r3, #0x800
_021629F0:
	add r7, r7, r2
	umull r9, r8, r7, r5
	mla r8, r7, r1, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r5, r8
	adds r9, r9, r3
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r7, r8, #0xaa
	cmp r0, #0
	add r7, r7, #0x6a00
	sub r0, r0, #1
	bne _021629F0
	mov r0, r7, lsl #0x10
	mov r7, #0
	mov r11, r0, lsr #0x10
	ldr r2, =0xFFFFEAAB
	mov r0, #3
	mov r6, r7
	mov r3, #0x800
_02162A44:
	add r8, r7, r2
	umull r7, r9, r8, r5
	adds r7, r7, r3
	mov r10, r7, lsr #0xc
	mla r9, r8, r1, r9
	mov r7, r8, asr #0x1f
	mla r9, r7, r5, r9
	adc r7, r9, r6
	orr r10, r10, r7, lsl #20
	add r7, r10, #0x55
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162A44
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162A8C:
	cmp r5, #0x2000
	bge _02162B50
	sub r0, r5, #0x1000
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	ldr r2, =0x00001556
	mov r3, r5, asr #0x1f
	mov r1, #1
	mov r0, #0x4000
	mov r7, #0
	mov r6, #0x800
_02162AB8:
	sub r8, r2, r0
	umull r10, r9, r8, r5
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, r5, r9
	adds r10, r10, r6
	adc r8, r9, r7
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r1, #0
	add r0, r0, r9
	sub r1, r1, #1
	bne _02162AB8
	mov r0, r0, lsl #0x10
	mov r1, #0
	ldr r6, =0x00001555
	mov r11, r0, lsr #0x10
	mov r2, #3
	mov r8, r1
	mov r7, #0x800
_02162B08:
	sub r10, r6, r1
	umull r0, ip, r10, r5
	mla ip, r10, r3, ip
	mov r9, r10, asr #0x1f
	adds r0, r0, r7
	mla ip, r9, r5, ip
	adc r9, ip, r8
	mov r0, r0, lsr #0xc
	orr r0, r0, r9, lsl #20
	cmp r2, #0
	add r1, r1, r0
	sub r2, r2, #1
	bne _02162B08
	rsb r0, r1, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162B50:
	cmp r5, #0x3000
	bge _02162C1C
	sub r0, r5, #0x2000
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	ldr r3, =0xFFFFEAAA
	mov r1, r2, asr #0x1f
	mov r0, #1
	mov r7, #0x4000
	mov r6, #0
	mov r5, #0x800
_02162B7C:
	add r7, r7, r3
	umull r9, r8, r7, r2
	mla r8, r7, r1, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r2, r8
	adds r9, r9, r5
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r7, r8, #0x56
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162B7C
	mov r0, r7, lsl #0x10
	mov r7, #0
	mov r11, r0, lsr #0x10
	ldr r3, =0xFFFFEAAB
	mov r0, #3
	mov r6, r7
	mov r5, #0x800
_02162BD0:
	add r8, r7, r3
	umull r7, r9, r8, r2
	adds r7, r7, r5
	mov r10, r7, lsr #0xc
	mla r9, r8, r1, r9
	mov r7, r8, asr #0x1f
	mla r9, r7, r2, r9
	adc r7, r9, r6
	orr r10, r10, r7, lsl #20
	add r7, r10, #0x55
	cmp r0, #0
	add r7, r7, #0x1500
	sub r0, r0, #1
	bne _02162BD0
	rsb r0, r7, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	b _02162CD0
_02162C1C:
	sub r0, r5, #0x3000
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	ldr r2, =0x00006AAA
	mov r3, r5, asr #0x1f
	mov r1, #1
	mov r0, #0x4000
	mov r7, #0
	mov r6, #0x800
_02162C40:
	sub r8, r2, r0
	umull r10, r9, r8, r5
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, r5, r9
	adds r10, r10, r6
	adc r8, r9, r7
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r1, #0
	add r0, r0, r9
	sub r1, r1, #1
	bne _02162C40
	mov r0, r0, lsl #0x10
	mov r1, #0
	ldr r6, =0x00001555
	mov r11, r0, lsr #0x10
	mov r2, #3
	mov r8, r1
	mov r7, #0x800
_02162C90:
	sub r10, r6, r1
	umull r0, ip, r10, r5
	mla ip, r10, r3, ip
	mov r9, r10, asr #0x1f
	adds r0, r0, r7
	mla ip, r9, r5, ip
	adc r9, ip, r8
	mov r0, r0, lsr #0xc
	orr r0, r0, r9, lsl #20
	cmp r2, #0
	add r1, r1, r0
	sub r2, r2, #1
	bne _02162C90
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
_02162CD0:
	ldr r0, [sp, #4]
	ldr r2, =FX_SinCosTable_
	cmp r0, #0x8000
	mov r0, r11, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	add r0, r4, #0x900
	strh r11, [r0, #0x30]
	add r1, r3, #1
	mov r0, r1, lsl #1
	ldrsh r1, [r2, r0]
	ldr r9, [sp, #8]
	mov r0, r3, lsl #1
	mov r1, r1, lsl #4
	str r1, [r4, #0x420]
	ldrsh r1, [r2, r0]
	movlo r10, #0
	ldr r0, [sp]
	movhs r10, #0x10000
	cmp r0, #1
	mov r0, r1, lsl #4
	mov r5, #1
	addle sp, sp, #0xc
	str r0, [r4, #0x424]
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02162D38:
	ldr r2, [sp, #4]
	mov r8, r9, asr #0x1f
	mov r6, #1
	mov r1, #0
	mov r0, #0x800
_02162D4C:
	sub r3, r2, r10
	umull lr, ip, r3, r9
	mla ip, r3, r8, ip
	mov r2, r3, asr #0x1f
	adds r3, lr, r0
	mla ip, r2, r9, ip
	mov r7, r6
	adc r2, ip, r1
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r7, #0
	sub r6, r6, #1
	add r2, r10, r3
	bne _02162D4C
	add r0, r11, r2
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r1, r4, r5, lsl #1
	add r6, r1, #0x900
	mov r2, r0, lsl #1
	add r1, r4, r5, lsl #3
	strh r3, [r6, #0x30]
	ldr r0, =FX_SinCosTable_
	ldr r7, [r1, #0x418]
	add r3, r0, r2, lsl #1
	ldrsh r6, [r3, #2]
	ldr r3, [sp, #8]
	add r5, r5, #1
	add r6, r7, r6, lsl #3
	str r6, [r1, #0x420]
	add r3, r9, r3
	mov r6, r2, lsl #1
	mov r2, r3, lsl #0x10
	ldrsh r3, [r0, r6]
	ldr r0, [sp]
	ldr r6, [r1, #0x41c]
	cmp r5, r0
	add r0, r6, r3, lsl #3
	str r0, [r1, #0x424]
	mov r9, r2, asr #0x10
	blt _02162D38
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}