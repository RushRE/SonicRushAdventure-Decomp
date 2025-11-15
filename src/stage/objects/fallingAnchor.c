#include <stage/objects/fallingAnchor.h>
#include <game/stage/gameSystem.h>
#include <game/stage/stageAssets.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/graphics/screenShake.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/slingDust.h>

NOT_DECOMPILED void *aActAcGmkAnchor_0;

// --------------------
// FUNCTION DECLS
// --------------------

static void FallingAnchor_Destructor(Task *task);
static void FallingAnchor_State_Active(FallingAnchor *work);
static void FallingAnchor_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC FallingAnchor *CreateFallingAnchor(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/5kwk4 -> 97.36%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(FallingAnchor_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), FallingAnchor);
    if (task == HeapNull)
        return NULL;

    FallingAnchor *work = TaskGetWork(task, FallingAnchor);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_anchor_elv.bac", GetObjectDataWork(OBJDATAWORK_166), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 31, GetObjectSpriteRef(OBJDATAWORK_167));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 92);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 0);

    AnimatorSpriteDS *aniChain = &work->aniChain;
    ObjAction2dBACLoad(&work->aniChain, "/act/ac_gmk_anchor_elv.bac", 31, GetObjectDataWork(OBJDATAWORK_166), gameArchiveStage);
    aniChain->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniChain->cParam[0].palette = aniChain->cParam[1].palette = aniChain->work.cParam.palette;
    aniChain->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(&work->aniChain, 1);
    StageTask__SetOAMOrder(&aniChain->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniChain->work, SPRITE_PRIORITY_2);

    ObjRect__SetGroupFlags(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -40, -163, 40, -133);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS | OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -36, -163, 36, -133);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_USER_1, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS | OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 80;
    work->gameWork.collisionObject.work.height    = 32;
    work->gameWork.collisionObject.work.ofst_x    = -40;
    work->gameWork.collisionObject.work.ofst_y    = -166;
    StageTask__SetHitbox(&work->gameWork.objWork, -32, -163, 32, -155);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.viewOutOffsetBoundsBottom = 512;

    work->originPos = work->gameWork.objWork.position.y;

    if (mapObject->left > 0)
        work->gameWork.objWork.userTimer = mapObject->left;

    SetTaskOutFunc(&work->gameWork.objWork, FallingAnchor_Draw);
    SetTaskState(&work->gameWork.objWork, FallingAnchor_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x0000040C
	ldr r0, =StageTask_Main
	ldr r1, =FallingAnchor_Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, =0x0000040C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0xa6
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkAnchor_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x1f
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x5c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	add r5, r4, #0x364
	mov r0, #0xa6
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, =gameArchiveStage
	mov r0, r5
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkAnchor_0
	str r2, [sp]
	mov r2, #0x1f
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #1
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	ldr r2, [r5, #0x3c]
	orr r2, r2, #0x10
	str r2, [r5, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r2, =0x00000201
	add r0, r4, #0x200
	strh r2, [r0, #0x4c]
	rsb r5, r2, #0x17c
	mvn r1, #0x27
	add r0, r4, #0x218
	sub r2, r1, #0x7b
	mov r3, #0x28
	str r5, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x230]
	mvn r2, #0x84
	orr r0, r0, #0x820
	str r0, [r4, #0x230]
	str r2, [sp]
	add r1, r2, #0x61
	add r0, r4, #0x258
	sub r2, r2, #0x1e
	mov r3, #0x24
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #4
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFF
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	mov r3, #0x20
	orr r1, r1, #0x820
	str r1, [r4, #0x270]
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	mov r1, #0x50
	add r0, r4, #0x300
	strh r1, [r0, #8]
	strh r3, [r0, #0xa]
	sub r1, r3, #0x48
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r3, #0xc6
	strh r1, [r0, #0xf2]
	sub r0, r3, #0xbb
	str r0, [sp]
	mov r0, r4
	sub r1, r3, #0x40
	sub r2, r3, #0xc3
	bl StageTask__SetHitbox
	ldr r1, [r4, #0x1c]
	mov r0, #0x200
	orr r1, r1, #0x2300
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	strh r0, [r4, #0x14]
	ldr r0, [r4, #0x48]
	ldr r1, =FallingAnchor_State_Active
	str r0, [r4, #0x408]
	ldrsb r0, [r7, #6]
	cmp r0, #0
	strgt r0, [r4, #0x2c]
	ldr r0, =FallingAnchor_Draw
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void FallingAnchor_Destructor(Task *task)
{
    FallingAnchor *work = TaskGetWork(task, FallingAnchor);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_166), &work->aniChain);
    GameObject__Destructor(task);
}

void FallingAnchor_State_Active(FallingAnchor *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case 0:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.flags |= 1;
                work->gameWork.objWork.userTimer = 8;
            }
            break;

        case 1:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.flags &= ~1;
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EV_DOWN);
            }
            break;

        case 2:
            work->gameWork.objWork.velocity.y = ObjSpdUpSet(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(8.0));

            if (work->gameWork.objWork.velocity.y + work->gameWork.objWork.position.y > (work->originPos + FLOAT_TO_FX32(512.0)))
                work->gameWork.objWork.velocity.y = (work->originPos + FLOAT_TO_FX32(512.0)) - work->gameWork.objWork.position.y;

            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

            u32 touchingFloor = work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
            if (touchingFloor || work->gameWork.objWork.position.y >= work->originPos + FLOAT_TO_FX32(512.0))
            {
                if (touchingFloor)
                {
                    EffectSlingDust__Create(work->gameWork.objWork.position.x - FLOAT_TO_FX32(26.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            -FLOAT_TO_FX32(2.0) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(256)) >> 8), -FLOAT_TO_FX32(4.0) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(128)) >> 8), mtMathRandRepeat(2));

                    EffectSlingDust__Create(work->gameWork.objWork.position.x - FLOAT_TO_FX32(12.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            -FLOAT_TO_FX32(1.5) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(256)) >> 8), -FLOAT_TO_FX32(4.5) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(128)) >> 8), 0);

                    EffectSlingDust__Create(work->gameWork.objWork.position.x + FLOAT_TO_FX32(25.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            FLOAT_TO_FX32(1.5) + ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(256)) >> 8), -FLOAT_TO_FX32(4.5) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(128)) >> 8), 1);

                    EffectSlingDust__Create(work->gameWork.objWork.position.x + FLOAT_TO_FX32(13.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            FLOAT_TO_FX32(2.0) + ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(256)) >> 8), -FLOAT_TO_FX32(4.0) - ((u32)FX32_FROM_WHOLE(mtMathRandRepeat(128)) >> 8), mtMathRandRepeat(2));
                }

                work->gameWork.objWork.moveFlag &=
                    ~(STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING | STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

                work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = NULL;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

                if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) == 0
                    && work->gameWork.objWork.position.y - FLOAT_TO_FX32(61.0) >= gPlayer->objWork.position.y)
                {
                    ShakeScreen(SCREENSHAKE_BIG_MIDDLE);
                }

                work->gameWork.objWork.userWork++;

                work->gameWork.objWork.userTimer = 4 * work->gameWork.mapObject->top;
                if (work->gameWork.objWork.userTimer <= 0)
                    work->gameWork.objWork.userTimer = 120;

                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EV_FALL);
            }
            break;

        case 3:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.125) * MATH_MIN(work->gameWork.mapObject->height, 8) - FLOAT_TO_FX32(1.5);
                if (mapCamera.camera[0].waterLevel < FX32_TO_WHOLE(work->gameWork.objWork.position.y) - 163)
                    work->gameWork.objWork.velocity.y = (work->gameWork.objWork.velocity.y >> 1) + (work->gameWork.objWork.velocity.y >> 2);
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EV_UP);
            }
            break;

        case 4:
            if (work->gameWork.objWork.position.y + work->gameWork.objWork.velocity.y <= work->originPos)
            {
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

                work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;
                work->gameWork.objWork.move.y         = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;
                work->gameWork.objWork.position.y     = work->originPos;
                work->gameWork.objWork.velocity.y     = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.userWork++;
                work->gameWork.flags |= 1;
                work->gameWork.objWork.userTimer = 8;
            }
            break;

        case 5:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.flags &= ~1;
                work->gameWork.objWork.userWork  = 0;
                work->gameWork.objWork.userTimer = 4 * work->gameWork.mapObject->width;
                if (work->gameWork.objWork.userTimer <= 0)
                    work->gameWork.objWork.userTimer = 120;
            }
            break;
    }

    if ((work->gameWork.flags & 1) != 0)
    {
        work->gameWork.objWork.offset.x = FX32_FROM_WHOLE(mtMathRandRange2(-2, 2));
        work->gameWork.objWork.offset.y = FX32_FROM_WHOLE(mtMathRandRange2(-2, 2));
    }
}

void FallingAnchor_Draw(void)
{
    FallingAnchor *work = TaskGetWorkCurrent(FallingAnchor);

    u32 displayFlag = work->gameWork.objWork.displayFlag;
    s32 chainPos    = FX_DivS32(work->gameWork.objWork.position.y - work->originPos + (FLOAT_TO_FX32(40.0) - 1), FLOAT_TO_FX32(40.0));

    VecFx32 position;
    position.x = work->gameWork.objWork.position.x + work->gameWork.objWork.offset.x;

    s32 i      = chainPos + 1;
    position.y = work->gameWork.objWork.position.y - FLOAT_TO_FX32(253.0) + work->gameWork.objWork.offset.y - (FLOAT_TO_FX32(40.0) * (i - 1));
    for (; i > 0; i--)
    {
        StageTask__Draw2DEx(&work->aniChain, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
        position.y += FLOAT_TO_FX32(40.0);
    }

    position.x = work->gameWork.objWork.position.x + work->gameWork.objWork.offset.x;
    position.y = work->gameWork.objWork.position.y - FLOAT_TO_FX32(253.0) + work->gameWork.objWork.offset.y;
    position.z = FLOAT_TO_FX32(0.0);

    displayFlag = work->gameWork.objWork.displayFlag;
    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

    displayFlag |= DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
}