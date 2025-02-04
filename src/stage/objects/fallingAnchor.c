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

    ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -40, -163, 40, -133);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 2, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~0, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800 | OBS_RECT_WORK_FLAG_20;

    ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -36, -163, 36, -133);
    ObjRect__SetAttackStat(&work->gameWork.colliders[1], 4, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~0, 0);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800 | OBS_RECT_WORK_FLAG_20;

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

NONMATCH_FUNC void FallingAnchor_State_Active(FallingAnchor *work)
{
    // https://decomp.me/scratch/9lSg2 -> 82.11%
#ifdef NON_MATCHING
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
                work->gameWork.colliders[0].parent = &work->gameWork.objWork;
                work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_800;
                work->gameWork.colliders[1].parent = &work->gameWork.objWork;
                work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_800;
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
                                            -FLOAT_TO_FX32(2.0) - ((16 * mtMathRand()) & 0xFFF), -FLOAT_TO_FX32(4.0) - ((16 * mtMathRand()) & 0x7FF), mtMathRand() & 1);

                    EffectSlingDust__Create(work->gameWork.objWork.position.x - FLOAT_TO_FX32(12.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            -FLOAT_TO_FX32(1.5) - ((16 * mtMathRand()) & 0xFFF), -FLOAT_TO_FX32(4.5) - ((16 * mtMathRand()) & 0x7FF), 0);

                    EffectSlingDust__Create(work->gameWork.objWork.position.x + FLOAT_TO_FX32(25.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            FLOAT_TO_FX32(1.5) + ((16 * mtMathRand()) & 0xFFF), -FLOAT_TO_FX32(4.5) - ((16 * mtMathRand()) & 0x7FF), 1);

                    EffectSlingDust__Create(work->gameWork.objWork.position.x + FLOAT_TO_FX32(13.0), work->gameWork.objWork.position.y - FLOAT_TO_FX32(149.0),
                                            FLOAT_TO_FX32(2.0) + ((16 * mtMathRand()) & 0xFFF), -FLOAT_TO_FX32(4.0) - ((16 * mtMathRand()) & 0x7FF), mtMathRand() & 1);
                }

                work->gameWork.objWork.moveFlag &=
                    ~(STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING | STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

                work->gameWork.colliders[0].parent = NULL;
                work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
                work->gameWork.colliders[1].parent = NULL;
                work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800;

                if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_CAM_B_ON_TOP) == 0
                    && work->gameWork.objWork.position.y - FLOAT_TO_FX32(61.0) >= gPlayer->objWork.position.y)
                {
                    ShakeScreen(SCREENSHAKE_D_LONG);
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
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.5) * MATH_MIN(work->gameWork.mapObject->height, 8) - FLOAT_TO_FX32(1.5);
                if (mapCamera.camera[0].waterLevel < FX32_TO_WHOLE(work->gameWork.objWork.position.y) - 163)
                    work->gameWork.objWork.velocity.y = (work->gameWork.objWork.velocity.y >> 2) + (work->gameWork.objWork.velocity.y >> 1);
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
        work->gameWork.objWork.offset.x = FX32_FROM_WHOLE((mtMathRand() & 3) - 2);
        work->gameWork.objWork.offset.y = FX32_FROM_WHOLE((mtMathRand() & 3) - 2);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0218160C
_02181110: // jump table
	b _02181128 // case 0
	b _02181160 // case 1
	b _021811D8 // case 2
	b _021814CC // case 3
	b _0218155C // case 4
	b _021815C8 // case 5
_02181128:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x28]
	mov r0, #8
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x354]
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x2c]
	b _0218160C
_02181160:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x354]
	ldr r2, [r4, #0x28]
	sub r1, r0, #1
	add r2, r2, #1
	str r2, [r4, #0x28]
	ldr r2, [r4, #0x1c]
	ldr r5, =0x0000011E
	bic r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r4, [r4, #0x234]
	ldr r3, [r4, #0x230]
	mov r2, r1
	bic r3, r3, #0x800
	str r3, [r4, #0x230]
	str r4, [r4, #0x274]
	ldr r6, [r4, #0x270]
	mov r3, r1
	bic r6, r6, #0x800
	str r6, [r4, #0x270]
	stmia sp, {r0, r5}
	bl PlaySfxEx
	b _0218160C
_021811D8:
	ldr r0, [r4, #0x9c]
	mov r1, #0x800
	mov r2, #0x8000
	bl ObjSpdUpSet
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x408]
	ldr r2, [r4, #0x48]
	add r1, r1, #0x200000
	add r0, r0, r2
	cmp r0, r1
	subgt r0, r1, r2
	strgt r0, [r4, #0x9c]
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x1c]
	ands r2, r0, #1
	bne _02181234
	ldr r0, [r4, #0x408]
	ldr r1, [r4, #0x48]
	add r0, r0, #0x200000
	cmp r1, r0
	blt _0218160C
_02181234:
	cmp r2, #0
	beq _02181418
	ldr r3, =_mt_math_rand
	mov r2, #0x2000
	ldr r5, [r3, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	rsb r2, r2, #0
	mla ip, r5, r0, r1
	mla r6, ip, r0, r1
	mla r5, r6, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r1, r0, #1
	mov r0, r6, lsr #0x10
	str r5, [r3]
	str r1, [sp]
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	ldr r0, [r3, #0]
	ldr r1, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, [r4, #0x44]
	mov r6, r0, lsl #0x18
	sub r3, r2, #0x2000
	mov r5, lr, lsl #0x19
	sub r0, ip, #0x1a000
	sub r1, r1, #0x95000
	sub r2, r2, r6, lsr #20
	sub r3, r3, r5, lsr #21
	bl EffectSlingDust__Create
	ldr ip, =_mt_math_rand
	mov r0, #0
	ldr r1, =0x00196225
	ldr r5, [ip]
	ldr r2, =0x3C6EF35F
	sub r3, r0, #0x1800
	mla r6, r5, r1, r2
	mla r1, r6, r1, r2
	str r1, [ip]
	str r0, [sp]
	ldr r1, [ip]
	mov r5, r6, lsr #0x10
	mov r2, r1, lsr #0x10
	mov r1, r5, lsl #0x10
	mov r5, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r1, r2, lsr #0x10
	mov r2, r1, lsl #0x18
	ldr lr, [r4, #0x48]
	ldr r6, [r4, #0x44]
	sub ip, r0, #0x4800
	mov r5, r5, lsl #0x19
	sub r2, r3, r2, lsr #20
	sub r0, r6, #0xc000
	sub r1, lr, #0x95000
	sub r3, ip, r5, lsr #21
	bl EffectSlingDust__Create
	ldr r2, =_mt_math_rand
	mov r3, #0x4800
	ldr ip, [r2]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r5, #1
	mla lr, ip, r0, r1
	mla r0, lr, r0, r1
	str r0, [r2]
	str r5, [sp]
	ldr r0, [r2, #0]
	mov r2, lr, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsl #0x18
	ldr r2, [r4, #0x44]
	mov r1, r0, lsr #0x14
	add r0, r2, #0x19000
	add r2, r1, #0x1800
	mov r1, r5, lsl #0x19
	rsb r3, r3, #0
	ldr r5, [r4, #0x48]
	sub r3, r3, r1, lsr #21
	sub r1, r5, #0x95000
	bl EffectSlingDust__Create
	ldr r2, =_mt_math_rand
	mov r3, #0x4000
	ldr ip, [r2]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	rsb r3, r3, #0
	mla r5, ip, r0, r1
	mla ip, r5, r0, r1
	mla lr, ip, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r1, r0, #1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	str lr, [r2]
	str r1, [sp]
	mov r0, r0, lsr #0x10
	mov ip, r0, lsl #0x19
	ldr r0, [r2, #0]
	ldr r1, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x18
	mov r2, r0, lsr #0x14
	ldr lr, [r4, #0x44]
	sub r1, r1, #0x95000
	add r0, lr, #0xd000
	add r2, r2, #0x2000
	sub r3, r3, ip, lsr #21
	bl EffectSlingDust__Create
_02181418:
	ldr r0, [r4, #0x1c]
	mov r2, #0
	bic r0, r0, #0xf
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	str r2, [r4, #0x9c]
	str r2, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, =mapCamera
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	str r2, [r4, #0x274]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	ldr r0, [r0, #0xe0]
	tst r0, #2
	bne _02181484
	ldr r0, =gPlayer
	ldr r1, [r4, #0x48]
	ldr r0, [r0, #0]
	sub r1, r1, #0x3d000
	ldr r0, [r0, #0x48]
	cmp r1, r0
	blt _02181484
	mov r0, #9
	bl ShakeScreen
_02181484:
	ldr r0, [r4, #0x28]
	ldr ip, =0x0000011F
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	sub r1, ip, #0x120
	ldrsb r0, [r0, #7]
	mov r2, r1
	mov r3, r1
	mov r0, r0, lsl #2
	str r0, [r4, #0x2c]
	cmp r0, #0
	movle r0, #0x78
	strle r0, [r4, #0x2c]
	mov r0, #0
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _0218160C
_021814CC:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #9]
	cmp r0, #8
	movhi r0, #8
	mov r0, r0, lsl #9
	rsb r0, r0, #0
	sub r0, r0, #0x1800
	str r0, [r4, #0x9c]
	ldr r0, =mapCamera
	ldr r1, [r4, #0x48]
	ldrh r2, [r0, #0x6e]
	mov r0, r1, asr #0xc
	sub r0, r0, #0xa3
	cmp r2, r0
	bge _02181538
	ldr r1, [r4, #0x9c]
	mov r0, r1, asr #2
	add r0, r0, r1, asr #1
	str r0, [r4, #0x9c]
_02181538:
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp]
	mov ip, #0x120
	str ip, [sp, #4]
	bl PlaySfxEx
	b _0218160C
_0218155C:
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x9c]
	ldr r0, [r4, #0x408]
	add r1, r2, r1
	cmp r1, r0
	bgt _0218160C
	ldr r0, [r4, #0x1c]
	mov r1, #0
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr r3, [r4, #0x48]
	mov r0, #8
	str r3, [r4, #0x90]
	ldr r2, [r4, #0x48]
	sub r2, r2, r3
	str r2, [r4, #0xc0]
	ldr r2, [r4, #0x408]
	str r2, [r4, #0x48]
	str r1, [r4, #0x9c]
	ldr r1, [r4, #0x28]
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x354]
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x2c]
	b _0218160C
_021815C8:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	mov r0, r0, lsl #2
	str r0, [r4, #0x2c]
	cmp r0, #0
	movle r0, #0x78
	strle r0, [r4, #0x2c]
_0218160C:
	ldr r0, [r4, #0x354]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r0, [r3, #0]
	ldr r2, =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x50]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x54]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
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