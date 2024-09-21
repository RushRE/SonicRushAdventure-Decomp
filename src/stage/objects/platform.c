#include <stage/objects/platform.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/graphics/oamSystem.h>
#include <game/audio/spatialAudio.h>

// --------------------
// VARIABLES
// --------------------

static s16 Platform__activeCount;
static u32 Platform__value_218A48C;

NOT_DECOMPILED u32 _0218975C[];

NOT_DECOMPILED u16 Platform__spriteTable[];

NOT_DECOMPILED u16 Platform__animTable[];

NOT_DECOMPILED void *aActAcGmkLandBa;

// --------------------
// FUNCTIONS
// --------------------

Platform *Platform__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    static u8 collisionTable[] = { 0, 1, 2, 0, 0, 3, 0, 0 };
    static u16 animTable[]     = { 0, 1, 2, 3, 0, 4, 0 };
    static u16 spriteTable[]   = { 0x10, 0x18, 0x20, 0x10, 0x10, 8, 0x10 };

    Task *task;
    Platform *work;

    size_t structSize = sizeof(Platform);
    if ((s32)mapObject->id == MAPOBJECT_190 || mapObject->id == MAPOBJECT_191)
        structSize = sizeof(Platform2);

    task = TaskCreate_(StageTask_Main, Platform__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_SCOPE_2, structSize);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, Platform);
    MI_CpuFill8(work, 0, structSize);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    u32 platformType;
    if (mapObject->id == MAPOBJECT_329)
    {
        platformType = 6;
    }
    else if (mapObject->id == MAPOBJECT_190)
    {
        platformType = 3;
    }
    else if (mapObject->id == MAPOBJECT_332)
    {
        platformType = 5;
    }
    else
    {
        platformType = mapObject->id - MAPOBJECT_187;
    }

	// yuck, meant to be "mapObject->id", but doesn't seem to match with a proper variable index??
#ifdef NON_MATCHING
    switch (mapObject->id) // using a proper variable index when not matching for readability & editability
#else
    switch (*((u16*)mapObject + 1)) // TODO: see if we can get this to be neat like the non-matching line: https://decomp.me/scratch/mAtBM
#endif
    {
        case MAPOBJECT_191:
            ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_land.bac", GetObjectDataWork(OBJDATAWORK_74), gameArchiveStage,
                                     OBJ_DATA_GFX_NONE);
            break;

        default:
            ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_land.bac", GetObjectDataWork(OBJDATAWORK_73), gameArchiveStage,
                                     OBJ_DATA_GFX_NONE);
            break;
    }
    ObjObjectActionAllocSprite(&work->gameWork.objWork, spriteTable[platformType], GetObjectSpriteRef(2 * platformType + OBJDATAWORK_75));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 74);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, animTable[platformType]);

    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    if ((mapObject->flags & 0x80) == 0 && mapObject->id != MAPOBJECT_189)
        work->gameWork.collisionObject.work.attr = 1;

    switch (collisionTable[platformType])
    {
        case 0:
            work->gameWork.collisionObject.work.width  = 48;
            work->gameWork.collisionObject.work.height = 24;
            work->gameWork.collisionObject.work.ofst_x = -24;
            work->gameWork.collisionObject.work.ofst_y = -11;
            if (work->gameWork.collisionObject.work.attr_data != NULL)
            {
                work->gameWork.collisionObject.work.height = 8;
                work->gameWork.collisionObject.work.ofst_y += 4;
            }
            break;

        case 1:
            work->gameWork.collisionObject.work.width  = 96;
            work->gameWork.collisionObject.work.height = 24;
            work->gameWork.collisionObject.work.ofst_x = -48;
            work->gameWork.collisionObject.work.ofst_y = -11;
            break;

        case 2:
            work->gameWork.collisionObject.work.width  = 48;
            work->gameWork.collisionObject.work.height = 48;
            work->gameWork.collisionObject.work.ofst_x = -24;
            work->gameWork.collisionObject.work.ofst_y = -23;
            break;

        case 3:
            work->gameWork.collisionObject.work.width  = 32;
            work->gameWork.collisionObject.work.height = 32;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -15;
            break;
    }

    if (mapObject->id == MAPOBJECT_193)
    {
        if (Platform__activeCount == 0 && Platform__value_218A48C == 0)
            Platform__value_218A48C = playerGameStatus.stageTimer;

        Platform__activeCount++;
    }

    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
        work->gameWork.collisionObject.work.ofst_y -= 2;
    }

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    if (mapObject->id != MAPOBJECT_191 && mapObject->id != MAPOBJECT_193 && mapObject->id != MAPOBJECT_329)
    {
        Platform__Action_Init(work);
        SetTaskState(&work->gameWork.objWork, Platform__State_Move);
    }

    return work;
}

void Platform__Destructor(Task *task)
{
    Platform *work = TaskGetWork(task, Platform);

    work->gameWork.objWork.collisionObj = NULL;

    if (work->gameWork.mapObject->id == MAPOBJECT_193)
    {
        if (Platform__activeCount != 0)
            Platform__activeCount--;

        if (Platform__activeCount == 0)
            Platform__value_218A48C = 0;
    }

    GameObject__Destructor(task);
}

void Platform__State_Move(Platform *work)
{
    StageTaskCollisionWork *collisionObj = work->gameWork.objWork.collisionObj;

    if (work->gameWork.objWork.userWork < 30)
        Platform__HandleMovement(work);

    if (collisionObj->work.riderObj != NULL && (Platform *)collisionObj->work.riderObj->rideObj == work)
    {
        work->gameWork.flags |= 1;

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            work->gameWork.objWork.offset.y = -FLOAT_TO_FX32(2.0);
        else
            work->gameWork.objWork.offset.y = FLOAT_TO_FX32(2.0);
    }

    if (((work->gameWork.mapObject->flags & 0x40) != 0 || work->gameWork.mapObject->id == MAPOBJECT_190) && (work->gameWork.flags & 1) != 0)
    {
        work->gameWork.objWork.userWork++;
        if (work->gameWork.objWork.userWork == 30)
        {
            if (work->gameWork.mapObject->id == MAPOBJECT_190)
            {
                Platform__Action_Collapse(work);
            }
            else
            {
                work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
                work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;
                SetTaskState(&work->gameWork.objWork, NULL);
            }
        }
    }
}

void Platform__Action_Init(Platform *work)
{
    work->gameWork.objWork.prevPosition.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x) + work->gameWork.mapObject->left + (work->gameWork.mapObject->width >> 1);
    work->gameWork.objWork.prevPosition.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y) + work->gameWork.mapObject->top + (work->gameWork.mapObject->height >> 1);

    if ((work->gameWork.mapObject->width | work->gameWork.mapObject->height) != 0)
    {
        s32 size;
        fx32 curPos;
        fx32 prevPos;
        if (work->gameWork.mapObject->height < (u32)work->gameWork.mapObject->width)
        {
            size    = work->gameWork.mapObject->width >> 1;
            curPos  = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
            prevPos = work->gameWork.objWork.prevPosition.x;
        }
        else
        {
            size    = work->gameWork.mapObject->height >> 1;
            curPos  = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
            prevPos = work->gameWork.objWork.prevPosition.y;
        }

        u16 i = 0x300;
        for (; i > 0x100; i -= 4)
        {
            if (prevPos + FX32_TO_WHOLE(size * SinFX((u16)(s32)(u16)(s32)(i << 6))) > curPos)
                break;
        }

        work->gameWork.objWork.userTimer = i;
        work->gameWork.objWork.userTimer -= (s16)((work->gameWork.mapObject->flags & 0x30) >> 4 << 8);
        work->gameWork.objWork.userTimer &= 0x3FFF;
    }
}

NONMATCH_FUNC void Platform__HandleMovement(Platform *work)
{
    // https://decomp.me/scratch/t395t -> 52.41%
#ifdef NON_MATCHING
    u16 timer = work->gameWork.objWork.userTimer;
    s16 sizeX = work->gameWork.mapObject->width >> 1;
    s16 sizeY = work->gameWork.mapObject->height >> 1;

    fx32 prevPosX = work->gameWork.objWork.prevPosition.x;
    fx32 prevPosY = work->gameWork.objWork.prevPosition.y;

    u16 angle;
    if ((work->gameWork.mapObject->flags & 7) != 0)
        angle = (timer + playerGameStatus.stageTimer * (work->gameWork.mapObject->flags & 7)) & 0x3FF;
    else
        angle = (4 * (playerGameStatus.stageTimer + (timer >> 2))) & 0x3FF;

    fx32 moveX;
    fx32 moveY;
    if ((work->gameWork.mapObject->flags & 8) != 0)
    {
        moveX = sizeX * SinFX((s32)(u16)((angle << 6) + 0x8000));
        moveY = sizeY * SinFX((s32)(u16)(angle << 6));
    }
    else
    {
        moveX = sizeX * SinFX((s32)(u16)(angle << 6));
        moveY = sizeY * SinFX((s32)(u16)(angle << 6));
    }

    fx32 x = FX32_FROM_WHOLE(prevPosX + FX32_TO_WHOLE(moveX));
    fx32 y = FX32_FROM_WHOLE(prevPosY + FX32_TO_WHOLE(moveY));

    work->gameWork.objWork.move.x     = x - work->gameWork.objWork.position.x;
    work->gameWork.objWork.move.y     = y - work->gameWork.objWork.position.y;
    work->gameWork.objWork.position.x = x;
    work->gameWork.objWork.position.y = y;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, [r0, #0x340]
	ldr r1, [r0, #0x2c]
	ldrh lr, [r3, #4]
	ldrb r2, [r3, #8]
	ldrb r3, [r3, #9]
	and r5, lr, #7
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0xf
	mov r4, r3, lsl #0xf
	ands r7, r5, #0xff
	mov r6, r1, lsr #0x10
	mov r3, r2, asr #0x10
	mov ip, r4, asr #0x10
	ldr r1, [r0, #0x8c]
	ldr r2, [r0, #0x90]
	beq _021758BC
	ldr r5, =playerGameStatus
	ldr r4, =0x000003FF
	ldr r5, [r5, #0xc]
	mla r6, r5, r7, r6
	and r4, r6, r4
	b _021758D0
_021758BC:
	ldr r4, =playerGameStatus
	ldr r4, [r4, #0xc]
	add r4, r4, r6, asr #2
	mov r4, r4, lsl #0x18
	mov r4, r4, lsr #0x16
_021758D0:
	mov r4, r4, lsl #0x10
	mov r4, r4, lsr #0x10
	tst lr, #8
	beq _02175934
	mov r5, r4, lsl #6
	add r4, r5, #0x8000
	mov lr, r4, lsl #0x10
	mov r4, r5, lsl #0x10
	mov r5, lr, lsr #0x10
	mov lr, r5, lsl #0x10
	mov r5, lr, lsr #0x10
	mov r4, r4, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r5, r5, asr #4
	mov r4, r4, lsr #0x10
	mov r4, r4, asr #4
	ldr lr, =FX_SinCosTable_
	mov r5, r5, lsl #2
	ldrsh r5, [lr, r5]
	mov r4, r4, lsl #2
	ldrsh r4, [lr, r4]
	smulbb r5, r3, r5
	smulbb r3, ip, r4
	add r4, r1, r5, asr #12
	b _02175960
_02175934:
	mov lr, r4, lsl #0x16
	mov r4, lr, lsr #0x10
	mov lr, r4, lsl #0x10
	mov r4, lr, lsr #0x10
	mov r5, r4, asr #4
	ldr r4, =FX_SinCosTable_
	mov r5, r5, lsl #2
	ldrsh r5, [r4, r5]
	mul r4, r3, r5
	mul r3, ip, r5
	add r4, r1, r4, asr #12
_02175960:
	add r1, r2, r3, asr #12
	mov r3, r1, lsl #0xc
	ldr r1, [r0, #0x44]
	mov r2, r4, lsl #0xc
	sub r1, r2, r1
	str r1, [r0, #0xbc]
	ldr r1, [r0, #0x48]
	sub r1, r3, r1
	str r1, [r0, #0xc0]
	str r2, [r0, #0x44]
	str r3, [r0, #0x48]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Platform__Action_Collapse(Platform *work)
{
    work->gameWork.animator.ani.work.flags &= ~ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK;
    work->gameWork.objWork.userTimer = 0;

    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_COLLAPSE);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    SetTaskState(&work->gameWork.objWork, Platform__State_Collapse);
    SetTaskOutFunc(&work->gameWork.objWork, Platform__Draw_Collapse);
}

NONMATCH_FUNC void Platform__State_Collapse(Platform2 *work)
{
    // https://decomp.me/scratch/xPfQt -> 60.62%
#ifdef NON_MATCHING
    work->gameWork.objWork.userTimer++;

    s8 top   = 8;
    s8 width = 10;
    if (work->gameWork.mapObject->id == MAPOBJECT_191)
    {
        if (work->gameWork.mapObject->top != 0)
            top = work->gameWork.mapObject->top;

        if (work->gameWork.mapObject->width != 0)
            width = work->gameWork.mapObject->width;
    }

    if (work->gameWork.objWork.collisionObj->work.riderObj != NULL && (Platform2 *)work->gameWork.objWork.collisionObj->work.riderObj->rideObj == work)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            work->gameWork.objWork.offset.y = -FLOAT_TO_FX32(2.0);
        else
            work->gameWork.objWork.offset.y = FLOAT_TO_FX32(2.0);
    }

    s32 timer = work->gameWork.objWork.userTimer;

    for (u8 i = 2, y = 0; i > 0; i--)
    {
        for (u8 x = 2; x > 0; x--)
        {
            s32 blockTime = y * top - (3 - i) * width;
            if (blockTime < timer)
            {
                work->fallPosition[y][x].y += work->fallVelocity[y][x].y;
                work->fallPosition[y][x].y = MTM_MATH_CLIP(work->fallPosition[y][x].y, -FLOAT_TO_FX32(4096.0), FLOAT_TO_FX32(4096.0));

                work->fallVelocity[y][x].y = ObjSpdUpSet(work->fallVelocity[y][x].y, 32 * (timer - blockTime) + 128, FLOAT_TO_FX32(48.0));
            }

            y++;
        }
    }

    if (work->fallPosition[0][0].y != 0)
    {
        work->gameWork.collisionObject.work.parent = NULL;
    }
    else if (work->fallPosition[0][1].y != 0)
    {
        work->gameWork.collisionObject.work.width  = 16;
        work->gameWork.collisionObject.work.ofst_x = -8;
    }
    else if (work->fallPosition[0][2].y != 0)
    {
        work->gameWork.collisionObject.work.width  = 32;
        work->gameWork.collisionObject.work.ofst_x = -16;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	str r0, [sp]
	ldr r0, [r0, #0x2c]
	mov r8, #8
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x340]
	mov r0, #0xa
	str r0, [sp, #4]
	ldrh r0, [r1, #2]
	cmp r0, #0xbf
	bne _02175A60
	ldrsb r0, [r1, #7]
	cmp r0, #0
	movne r8, r0
	ldrb r0, [r1, #8]
	cmp r0, #0
	movne r0, r0, lsl #0x18
	movne r0, r0, asr #0x18
	strne r0, [sp, #4]
_02175A60:
	ldr r0, [sp]
	ldr r0, [r0, #0x13c]
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _02175AA8
	ldr r1, [r0, #0x114]
	ldr r0, [sp]
	cmp r1, r0
	bne _02175AA8
	ldr r0, [r0, #0x20]
	mov r1, #0x2000
	tst r0, #2
	ldreq r0, [sp]
	streq r1, [r0, #0x54]
	beq _02175AA8
	ldr r0, [sp]
	rsb r1, r1, #0
	str r1, [r0, #0x54]
_02175AA8:
	mov r0, #3
	sub r1, r0, #1
	ldr r0, [sp]
	and r7, r1, #0xff
	ldr r6, [r0, #0x2c]
	mov r5, #0
_02175AC0:
	ldr r0, [sp, #4]
	rsb r1, r7, #3
	mul r9, r1, r0
	mov r0, #3
	sub r0, r0, #1
	and r10, r0, #0xff
	ldr r0, [sp]
	add r1, r7, r7, lsl #1
	add r4, r0, r1, lsl #3
	mov r11, #0xff000000
_02175AE8:
	mul r0, r5, r8
	sub r3, r0, r9
	cmp r3, r6
	bge _02175B48
	add r2, r4, r10, lsl #3
	ldr r1, [r2, #0x368]
	ldr r0, [r2, #0x3b0]
	add r0, r1, r0
	str r0, [r2, #0x368]
	cmp r0, #0xff000000
	movlt r0, r11
	blt _02175B20
	cmp r0, #0x1000000
	movgt r0, #0x1000000
_02175B20:
	sub r1, r6, r3
	add r2, r4, r10, lsl #3
	mov r1, r1, lsl #5
	str r0, [r2, #0x368]
	ldr r0, [r2, #0x3b0]
	add r1, r1, #0x80
	mov r2, #0x30000
	bl ObjSpdUpSet
	add r1, r4, r10, lsl #3
	str r0, [r1, #0x3b0]
_02175B48:
	add r1, r5, #1
	sub r0, r10, #1
	cmp r10, #0
	and r5, r1, #0xff
	and r10, r0, #0xff
	bne _02175AE8
	sub r0, r7, #1
	cmp r7, #0
	and r7, r0, #0xff
	bne _02175AC0
	ldr r0, [sp]
	ldr r0, [r0, #0x368]
	cmp r0, #0
	beq _02175B94
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x2d8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02175B94:
	ldr r0, [sp]
	ldr r0, [r0, #0x370]
	cmp r0, #0
	beq _02175BCC
	ldr r0, [sp]
	mov r1, #0x10
	add r0, r0, #0x300
	strh r1, [r0, #8]
	ldr r0, [sp]
	sub r1, r1, #0x18
	add r0, r0, #0x200
	strh r1, [r0, #0xf0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02175BCC:
	ldr r0, [sp]
	ldr r0, [r0, #0x378]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	mov r1, #0x20
	add r0, r0, #0x300
	strh r1, [r0, #8]
	ldr r0, [sp]
	sub r1, r1, #0x30
	add r0, r0, #0x200
	strh r1, [r0, #0xf0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Platform__Draw_Collapse(void)
{
#ifdef NON_MATCHING
    Platform2 *work = TaskGetWorkCurrent(Platform2);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.animator.ani);

    for (fx32 e = 0; e < GRAPHICS_ENGINE_COUNT; e++)
    {
        Vec2Fx32 *pos = (Vec2Fx32 *)work->fallPosition;

        GXOamAttr *sprite = work->gameWork.animator.ani.firstSprite[e];
        s16 spriteX       = work->gameWork.animator.ani.position[e].x;
        s16 spriteY       = work->gameWork.animator.ani.position[e].y;

        for (s32 i = 0; i < 9 && sprite != NULL; i++)
        {
            s16 drawX = spriteX + FX32_FROM_WHOLE(pos->x) + 16 * FX_DivS32(i, 3) - 24;
            s16 drawY = spriteY + FX32_FROM_WHOLE(pos->y) + 8 * FX_ModS32(i, 3) - 12;

            s16 x;
            s16 y;
            if (drawX + 16 >= 0 && drawX < HW_LCD_WIDTH && drawY + 8 >= 0 && drawY < HW_LCD_HEIGHT)
            {
                x = FX32_FROM_WHOLE(pos->x) + sprite->x;
                y = FX32_FROM_WHOLE(pos->y) + sprite->y;
            }
            else
            {
                x = 0;
                y = -64;
            }

            sprite->x = x;
            sprite->y = y;

            sprite = OAMSystem__Func_207D624(e, sprite);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	add r1, r0, #0x168
	str r0, [sp, #0xc]
	str r1, [sp, #8]
	bl StageTask__Draw2D
	mov r9, #0
_02175C28:
	ldr r0, [sp, #8]
	mov r11, #0x200
	add r1, r0, r9, lsl #2
	ldr r0, [sp, #0xc]
	ldr r5, [r1, #0x94]
	add r8, r0, #0x364
	ldrsh r0, [r1, #0x68]
	mov r6, #0
	rsb r11, r11, #0
	str r0, [sp, #4]
	ldrsh r0, [r1, #0x6a]
	str r0, [sp]
	b _02175D64
_02175C5C:
	mov r0, r6
	mov r1, #3
	bl FX_DivS32
	ldmia r8, {r2, r4}
	ldr r1, [sp, #4]
	mov r10, r4, asr #0xc
	add r1, r1, r2, asr #12
	add r0, r1, r0, lsl #4
	sub r0, r0, #0x18
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	mov r0, r6
	mov r1, #3
	bl FX_ModS32
	ldr r1, [sp]
	add r1, r1, r4, asr #12
	add r0, r1, r0, lsl #3
	sub r0, r0, #0xc
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	adds r0, r7, #0x10
	bmi _02175CCC
	cmp r7, #0x100
	bge _02175CCC
	adds r0, r1, #8
	bmi _02175CCC
	cmp r1, #0xc0
	blt _02175CD8
_02175CCC:
	mov r1, #0
	mov r2, #0xc0
	b _02175D20
_02175CD8:
	ldrh r1, [r5]
	mov r0, r10, lsl #0x10
	ldrh r4, [r5, #2]
	mov r2, r0, asr #0x10
	ldr r0, =0x000001FF
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	and r0, r4, r0
	ldr r3, [r8]
	add r2, r2, r1, asr #16
	mov r1, r3, lsl #4
	mov r0, r0, lsl #0x10
	mov r1, r1, asr #0x10
	add r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r2, r0, asr #0x10
_02175D20:
	ldrh r4, [r5, #2]
	ldr r0, =0x000001FF
	and r2, r2, #0xff
	and r3, r1, r0
	and r4, r4, r11
	orr r3, r4, r3
	strh r3, [r5, #2]
	ldrh r3, [r5]
	mov r0, r9
	mov r1, r5
	bic r3, r3, #0xff
	orr r2, r3, r2
	strh r2, [r5]
	bl OAMSystem__Func_207D624
	mov r5, r0
	add r6, r6, #1
	add r8, r8, #8
_02175D64:
	cmp r6, #9
	bge _02175D74
	cmp r5, #0
	bne _02175C5C
_02175D74:
	add r9, r9, #1
	cmp r9, #2
	blt _02175C28
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}