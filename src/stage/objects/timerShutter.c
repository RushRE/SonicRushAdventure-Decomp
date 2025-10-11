#include <stage/objects/timerShutter.h>
#include <game/stage/gameSystem.h>
#include <game/stage/stageAssets.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/math/akMath.h>
#include <stage/effects/waterGush.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void *aActAcGmkTimerS;

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_seconds mapObject->left
#define mapObjectParam_minutes mapObject->top

// --------------------
// ENUMS
// --------------------

enum TimerShutterAnimIDs
{
    TIMERSHUTTER_ANI_PANEL_SAFE,
    TIMERSHUTTER_ANI_PANEL_HALFWAY,
    TIMERSHUTTER_ANI_PANEL_WARNING,
    TIMERSHUTTER_ANI_PANEL_CLOSED,
    TIMERSHUTTER_ANI_WATER_DISPENSER,
    TIMERSHUTTER_ANI_COMMA,
    TIMERSHUTTER_ANI_DIGIT_0,
    TIMERSHUTTER_ANI_DIGIT_1,
    TIMERSHUTTER_ANI_DIGIT_2,
    TIMERSHUTTER_ANI_DIGIT_3,
    TIMERSHUTTER_ANI_DIGIT_4,
    TIMERSHUTTER_ANI_DIGIT_5,
    TIMERSHUTTER_ANI_DIGIT_6,
    TIMERSHUTTER_ANI_DIGIT_7,
    TIMERSHUTTER_ANI_DIGIT_8,
    TIMERSHUTTER_ANI_DIGIT_9,
    TIMERSHUTTER_ANI_WATERFALL,
    TIMERSHUTTER_ANI_WATERSPLASH,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void TimerShutter_Destructor(Task *task);
static void TimerShutter_State_Active(TimerShutter *work);
static void TimerShutter_Draw(void);

static void TimerShutterWater_Destructor(Task *task);
static void TimerShutterWater_State_Active(TimerShutterWater *work);
static void TimerShutterWater_Draw(void);
static void TimerShutterWater_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC TimerShutter *CreateTimerShutter(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/Sfy6I -> 95.16%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(TimerShutter_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TimerShutter);
    if (task == HeapNull)
        return NULL;

    TimerShutter *work = TaskGetWork(task, TimerShutter);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    s16 minutes = ClampS32(mapObjectParam_minutes, 0, 9);
    s16 seconds = ClampS32(mapObjectParam_seconds, 0, 59);

    s16 secondsDigit2 = FX_ModS32(seconds, 10);
    s16 minutesDigit2 = FX_DivS32(minutes, 10);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_timer_shutter.bac", GetObjectDataWork(OBJDATAWORK_117), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 24, GetObjectSpriteRef(OBJDATAWORK_118));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 4, 93);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, TIMERSHUTTER_ANI_WATER_DISPENSER);

    AnimatorSpriteDS *aniShutter = &work->aniShutter;
    ObjAction2dBACLoad(aniShutter, "/act/ac_gmk_timer_shutter.bac", 17, GetObjectDataWork(OBJDATAWORK_117), gameArchiveStage);
    aniShutter->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniShutter->cParam[0].palette = aniShutter->cParam[1].palette = aniShutter->work.cParam.palette;

    aniShutter->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(aniShutter, TIMERSHUTTER_ANI_PANEL_SAFE);
    StageTask__SetOAMOrder(&aniShutter->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniShutter->work, SPRITE_PRIORITY_2);

    u16 timeAnims[4];
    timeAnims[0] = minutes + TIMERSHUTTER_ANI_DIGIT_0;
    timeAnims[1] = TIMERSHUTTER_ANI_COMMA;
    timeAnims[2] = minutesDigit2 + TIMERSHUTTER_ANI_DIGIT_0;
    timeAnims[3] = secondsDigit2 + TIMERSHUTTER_ANI_DIGIT_0;

    AnimatorSpriteDS *aniTimeDigit = work->aniTimeDigits;
    for (s16 i = 0; i < 4; i++)
    {
        ObjAction2dBACLoad(aniTimeDigit, "/act/ac_gmk_timer_shutter.bac", 2, GetObjectDataWork(OBJDATAWORK_117), gameArchiveStage);
        aniTimeDigit->work.cParam.palette      = ObjDrawAllocSpritePalette(work->gameWork.animator.fileWork->fileData, timeAnims[i], 95);
        aniTimeDigit->cParam[0].palette = aniTimeDigit->cParam[1].palette = aniTimeDigit->work.cParam.palette;
        aniTimeDigit->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
        AnimatorSpriteDS__SetAnimation(aniTimeDigit, timeAnims[i]);
        StageTask__SetOAMOrder(&aniTimeDigit->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&aniTimeDigit->work, SPRITE_PRIORITY_2);

        aniTimeDigit++;
    }
    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 48;
    work->gameWork.collisionObject.work.height    = 56;
    work->gameWork.collisionObject.work.ofst_x    = -24;
    work->gameWork.collisionObject.work.ofst_y    = -56;
    work->closeTime                               = 3600 * minutes + 60 * seconds;

    if (playerGameStatus.stageTimer >= work->closeTime)
    {
        TimerShutterWater *water = SpawnStageObject(MAPOBJECT_331, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, TimerShutterWater);
        if (water != NULL)
        {
            water->gameWork.objWork.parentObj = &work->gameWork.objWork;
            AnimatorSpriteDS__SetAnimation(&work->aniShutter, TIMERSHUTTER_ANI_PANEL_CLOSED);
        }
    }
    else
    {
        SetTaskState(&work->gameWork.objWork, TimerShutter_State_Active);
    }

    SetTaskOutFunc(&work->gameWork.objWork, TimerShutter_Draw);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, =0x0000069C
	ldr r0, =StageTask_Main
	ldr r1, =TimerShutter_Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0x24
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, =0x0000069C
	mov r8, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r8
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r0, [r8, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r8, #0x1c]
	ldrsb r0, [r6, #7]
	cmp r0, #0
	movlt r0, #0
	blt _021800B0
	cmp r0, #9
	movgt r0, #9
_021800B0:
	ldrsb r1, [r6, #6]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r1, #0
	str r0, [sp, #0x18]
	movlt r1, #0
	blt _021800D4
	cmp r1, #0x3b
	movgt r1, #0x3b
_021800D4:
	mov r0, r1, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x14]
	mov r1, #0xa
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	mov r1, #0xa
	mov r4, r2, asr #0x10
	bl FX_ModS32
	mov r1, r0, lsl #0x10
	mov r0, #0x75
	mov r5, r1, asr #0x10
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r8
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcGmkTimerS
	add r1, r8, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0x76
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r8
	mov r1, #0x18
	bl ObjObjectActionAllocSprite
	mov r0, r8
	mov r1, #4
	mov r2, #0x5d
	bl ObjActionAllocSpritePalette
	mov r0, r8
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r8
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r8
	mov r1, #4
	bl StageTask__SetAnimation
	mov r0, #0x75
	add r9, r8, #0x364
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkTimerS
	str r2, [sp]
	mov r0, r9
	mov r2, #0x11
	bl ObjAction2dBACLoad
	ldr r1, [r8, #0x128]
	mov r0, r9
	ldrh r2, [r1, #0x50]
	mov r1, #0
	strh r2, [r9, #0x50]
	strh r2, [r9, #0x92]
	strh r2, [r9, #0x90]
	ldr r2, [r9, #0x3c]
	orr r2, r2, #0x10
	str r2, [r9, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r9
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r0, [sp, #0x18]
	add r2, r4, #6
	add r6, r0, #6
	add r1, r5, #6
	add r0, r8, #8
	mov r3, #5
	strh r6, [sp, #0x1c]
	strh r3, [sp, #0x1e]
	strh r2, [sp, #0x20]
	strh r1, [sp, #0x22]
	add r9, r0, #0x400
	mov r10, #0
	mov r7, #0x75
	ldr r6, =aActAcGmkTimerS
	mov r11, #2
	add r5, sp, #0x1c
	ldr r4, =gameArchiveStage
	b _021802C4
_02180238:
	mov r0, r7
	bl GetObjectFileWork
	ldr r1, [r4, #0]
	mov r3, r0
	str r1, [sp]
	mov r0, r9
	mov r1, r6
	mov r2, r11
	bl ObjAction2dBACLoad
	ldr r0, [r8, #0x20c]
	mov r1, r10, lsl #1
	ldrh r1, [r5, r1]
	ldr r0, [r0, #0]
	mov r2, #0x5f
	bl ObjDrawAllocSpritePalette
	strh r0, [r9, #0x50]
	strh r0, [r9, #0x92]
	strh r0, [r9, #0x90]
	ldr r1, [r9, #0x3c]
	mov r0, r9
	orr r1, r1, #0x10
	str r1, [r9, #0x3c]
	mov r1, r10, lsl #1
	ldrh r1, [r5, r1]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r9
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r9
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, asr #0x10
	add r9, r9, #0xa4
_021802C4:
	cmp r10, #4
	blt _02180238
	ldr r0, [sp, #0x18]
	mov r1, #0x3c
	smulbb r0, r0, r1
	mul r2, r0, r1
	mov r3, #0
	str r3, [r8, #0x13c]
	ldr r0, [sp, #0x14]
	mov r4, #0x38
	smlabb r1, r0, r1, r2
	ldr r0, =StageTask__DefaultDiffData
	str r8, [r8, #0x2d8]
	str r0, [r8, #0x2fc]
	add r0, r8, #0x300
	mov r2, #0x30
	strh r2, [r0, #8]
	strh r4, [r0, #0xa]
	sub r2, r4, #0x50
	add r0, r8, #0x200
	strh r2, [r0, #0xf0]
	sub r2, r4, #0x70
	strh r2, [r0, #0xf2]
	ldr r0, =playerGameStatus
	str r1, [r8, #0x698]
	ldr r0, [r0, #0xc]
	cmp r0, r1
	blo _02180374
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r8, #0x44]
	ldr r2, [r8, #0x48]
	ldr r0, =0x0000014B
	bl GameObject__SpawnObject
	cmp r0, #0
	beq _0218037C
	str r8, [r0, #0x11c]
	add r0, r8, #0x364
	mov r1, #3
	bl AnimatorSpriteDS__SetAnimation
	b _0218037C
_02180374:
	ldr r0, =TimerShutter_State_Active
	str r0, [r8, #0xf4]
_0218037C:
	ldr r1, =TimerShutter_Draw
	mov r0, r8
	str r1, [r8, #0xfc]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC TimerShutterWater *CreateTimerShutterWater(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // should match when aActAcGmkTimerS is decompiled
#ifdef NON_MATCHING
    Task *task = CreateStageTask(TimerShutterWater_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1801, TASK_GROUP(2), TimerShutterWater);
    if (task == HeapNull)
        return NULL;

    TimerShutterWater *work = TaskGetWork(task, TimerShutterWater);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_timer_shutter.bac", GetObjectDataWork(OBJDATAWORK_117), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 16, 93);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, TIMERSHUTTER_ANI_WATERFALL);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    AnimatorSpriteDS *aniWater = &work->aniWater;
    ObjAction2dBACLoad(aniWater, "/act/ac_gmk_timer_shutter.bac", 16, GetObjectDataWork(OBJDATAWORK_117), gameArchiveStage);
    aniWater->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniWater->cParam[0].palette = aniWater->cParam[1].palette = aniWater->work.cParam.palette;
    aniWater->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(aniWater, TIMERSHUTTER_ANI_WATERSPLASH);
    StageTask__SetOAMOrder(&aniWater->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniWater->work, SPRITE_PRIORITY_2);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -20, 0, 20, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], TimerShutterWater_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.userTimer = -FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, TimerShutterWater_State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, TimerShutterWater_Draw);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x00001801
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000408
	ldr r0, =StageTask_Main
	ldr r1, =TimerShutterWater_Destructor
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
	ldr r2, =0x00000408
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0x75
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #8
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcGmkTimerS
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x10
	mov r2, #0x5d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	add r5, r4, #0x364
	orr r0, r0, #4
	str r0, [r4, #0x20]
	mov r0, #0x75
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkTimerS
	str r2, [sp]
	mov r0, r5
	mov r2, #0x10
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #0x11
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
	mov r2, #0
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	sub r1, r2, #0x14
	mov r3, #0x14
	str r2, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =TimerShutterWater_OnDefend
	mov r0, #0x40000
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	rsb r0, r0, #0
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x2c]
	ldr r1, =TimerShutterWater_State_Active
	ldr r0, =TimerShutterWater_Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void TimerShutter_Destructor(Task *task)
{
    TimerShutter *work = TaskGetWork(task, TimerShutter);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_117), &work->aniShutter);

    s32 i;
    AnimatorSpriteDS *aniTimeDigit = work->aniTimeDigits;
    for (i = 0; i < 4; i++)
    {
        ObjDrawReleaseSpritePalette(aniTimeDigit->work.cParam.palette);
        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_117), aniTimeDigit);

        aniTimeDigit++;
    }

    GameObject__Destructor(task);
}

void TimerShutter_State_Active(TimerShutter *work)
{
    u32 closeTime = work->closeTime;
    if (playerGameStatus.stageTimer >= closeTime)
    {
        TimerShutterWater *water = SpawnStageObject(MAPOBJECT_331, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, TimerShutterWater);
        if (water != NULL)
            water->gameWork.objWork.parentObj = &work->gameWork.objWork;

        AnimatorSpriteDS__SetAnimation(&work->aniShutter, TIMERSHUTTER_ANI_PANEL_CLOSED);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
    else
    {
        u16 anim;
        if (closeTime - playerGameStatus.stageTimer < closeTime >> 2)
            anim = TIMERSHUTTER_ANI_PANEL_WARNING;
        else if (closeTime - playerGameStatus.stageTimer < closeTime >> 1)
            anim = TIMERSHUTTER_ANI_PANEL_HALFWAY;
        else
            anim = TIMERSHUTTER_ANI_PANEL_SAFE;

        if (work->aniShutter.work.animID != anim)
            AnimatorSpriteDS__SetAnimation(&work->aniShutter, anim);
    }
}

void TimerShutter_Draw(void)
{
    static const s8 digitPositionTable[4][2] = {
        [0] = { -11, -19 },
        [1] = { -4, -24 },
        [2] = { 2, -19 },
        [3] = { 12, -19 },
    };

    TimerShutter *work = TaskGetWorkCurrent(TimerShutter);

    u32 displayFlag = work->gameWork.objWork.displayFlag;

    AnimatorSpriteDS *aniTimeDigit = work->aniTimeDigits;
    VecFx32 position;
    position.z = FLOAT_TO_FX32(0.0);
    for (s32 i = 0; i < 4; i++)
    {
        position.x = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(digitPositionTable[i][0]);
        position.y = work->gameWork.objWork.position.y + FX32_FROM_WHOLE(digitPositionTable[i][1]);
        StageTask__Draw2DEx(aniTimeDigit, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

        aniTimeDigit++;
    }

    displayFlag = work->gameWork.objWork.displayFlag;

    position.x = work->gameWork.objWork.position.x;
    position.y = work->gameWork.objWork.position.y;

    if (work->aniShutter.work.animID == TIMERSHUTTER_ANI_PANEL_CLOSED)
        displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    StageTask__Draw2DEx(&work->aniShutter, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, NULL, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL, NULL);
}

void TimerShutterWater_Destructor(Task *task)
{
    TimerShutterWater *work = TaskGetWork(task, TimerShutterWater);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_117), &work->aniWater);

    GameObject__Destructor(task);
}

void TimerShutterWater_State_Active(TimerShutterWater *work)
{
    work->gameWork.objWork.userTimer += FLOAT_TO_FX32(6.0);

    if (work->gameWork.objWork.userTimer >= 0)
    {
        work->gameWork.objWork.userTimer = 0;
        SetTaskState(&work->gameWork.objWork, NULL);
    }

    work->gameWork.colliders[0].rect.bottom = FX32_TO_WHOLE(work->gameWork.objWork.userTimer + FLOAT_TO_FX32(64.0));
}

void TimerShutterWater_Draw(void)
{
    TimerShutterWater *work = TaskGetWorkCurrent(TimerShutterWater);

    VecFx32 position;
    u32 displayFlag;
    if (work->gameWork.objWork.userTimer == 0)
    {
        displayFlag = work->gameWork.objWork.displayFlag;

        position.x = work->gameWork.objWork.position.x;
        position.y = work->gameWork.objWork.position.y + FLOAT_TO_FX32(64.0);
        position.z = FLOAT_TO_FX32(0.0);
        StageTask__Draw2DEx(&work->aniWater, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
    }

    position.x  = work->gameWork.objWork.position.x;
    position.z  = FLOAT_TO_FX32(0.0);
    displayFlag = work->gameWork.objWork.displayFlag;
    s32 targetY = work->gameWork.objWork.userTimer;

    for (s32 currentY = FLOAT_TO_FX32(0.0); currentY < FLOAT_TO_FX32(64.0); currentY += FLOAT_TO_FX32(32.0))
    {
        if (targetY + currentY > -FLOAT_TO_FX32(32.0))
        {
            position.y = work->gameWork.objWork.position.y + targetY + currentY;
            StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
            displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB;
        }
    }
}

void TimerShutterWater_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player           = (Player *)rect1->parent;
    TimerShutterWater *water = (TimerShutterWater *)rect2->parent;

    if (water == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 waterGushVelX;
    fx32 playerVelX;

    if (player->objWork.position.x <= water->gameWork.objWork.position.x)
    {
        playerVelX    = -FLOAT_TO_FX32(2.0);
        waterGushVelX = playerVelX + FLOAT_TO_FX32(10.0);
    }
    else
    {
        playerVelX    = FLOAT_TO_FX32(2.0);
        waterGushVelX = playerVelX - FLOAT_TO_FX32(10.0);
    }

    Player__Action_Knockback_NoHurt(player, playerVelX, -FLOAT_TO_FX32(3.0));
    EffectWaterGush__Create(&player->objWork, waterGushVelX, -FLOAT_TO_FX32(4.0), 0);
    EffectWaterGush__Create(&player->objWork, waterGushVelX, -FLOAT_TO_FX32(12.0), 0);
}
