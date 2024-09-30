#include <stage/objects/flipboard.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_bounceForce mapObject->left

// --------------------
// ENUMS
// --------------------

enum FlipboardAnimID
{
    FLIPBOARD_ANI_BOARD,
    FLIPBOARD_ANI_SNOW,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Flipboard_Destructor(Task *task);
static void Flipboard_State_Active(Flipboard *work);
static void Flipboard_Draw(void);
static void Flipboard_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *aActAcGmkFlipBo;

NONMATCH_FUNC Flipboard *CreateFlipboard(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
	// https://decomp.me/scratch/1zLJf -> 96.41%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(Flipboard_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Flipboard);
    if (task == HeapNull)
        return NULL;

    Flipboard *work = TaskGetWork(task, Flipboard);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.aniSnow, "/act/ac_gmk_flip_board.bac", GetObjectFileWork(OBJDATAWORK_167), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, FLIPBOARD_ANI_BOARD, 61);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, FLIPBOARD_ANI_BOARD);

    AnimatorSpriteDS *aniSnow = &work->aniSnow;
    ObjAction2dBACLoad(aniSnow, "/act/ac_gmk_flip_board.bac", 35, GetObjectFileWork(OBJDATAWORK_167), gameArchiveStage);
    aniSnow->cParam[0].palette = aniSnow->cParam[1].palette = aniSnow->work.palette = work->gameWork.aniSnow.ani.work.palette;
    AnimatorSpriteDS__SetAnimation(aniSnow, FLIPBOARD_ANI_SNOW);
    StageTask__SetOAMOrder(&aniSnow->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniSnow->work, SPRITE_PRIORITY_2);

    SetTaskOutFunc(&work->gameWork.objWork, Flipboard_Draw);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Flipboard_OnDefend);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 120;
    work->gameWork.collisionObject.work.height    = 24;
    work->gameWork.collisionObject.work.ofst_x    = -60;
    work->gameWork.collisionObject.work.ofst_y    = 0;

    SetTaskState(&work->gameWork.objWork, Flipboard_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000408
	ldr r0, =StageTask_Main
	ldr r1, =Flipboard_Destructor
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
	mov r0, #0xa7
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x10
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkFlipBo
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x3d
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
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, =gameArchiveStage
	mov r0, r5
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkFlipBo
	str r2, [sp]
	mov r2, #0x23
	bl ObjAction2dBACLoad
	add r0, r4, #0x100
	ldrh r2, [r0, #0xb8]
	mov r0, r5
	mov r1, #1
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r1, =Flipboard_Draw
	add r0, r4, #0x218
	str r1, [r4, #0xfc]
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =Flipboard_OnDefend
	mov r1, #0x18
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	mov r3, #0
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	str r3, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r2, #0x78
	strh r2, [r0, #8]
	strh r1, [r0, #0xa]
	sub r1, r1, #0x54
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	ldr r1, =Flipboard_State_Active
	strh r3, [r0, #0xf2]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Flipboard_Destructor(Task *task)
{
    Flipboard *work = TaskGetWork(task, Flipboard);

    // is this meant to be "OBJDATAWORK_167"?
    // this file doesn't use OBJDATAWORK_1 anywhere!
    ObjAction2dBACRelease(GetObjectFileWork(OBJDATAWORK_1), &work->aniSnow);
    GameObject__Destructor(task);
}

void Flipboard_State_Active(Flipboard *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
        StageTask__SetAnimation(&work->gameWork.objWork, FLIPBOARD_ANI_BOARD);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    }
}

void Flipboard_Draw(void)
{
    Flipboard *work = TaskGetWorkCurrent(Flipboard);

    StageDisplayFlags displayFlag = work->gameWork.objWork.displayFlag;

    StageTask__Draw2DEx(&work->aniSnow, &work->gameWork.objWork.position, NULL, NULL, &displayFlag, NULL, NULL);
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    if ((displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        work->gameWork.objWork.ppOut = NULL;
}

void Flipboard_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Flipboard *flipBoard = (Flipboard *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (flipBoard == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    Player__Action_Flipboard(player, FLOAT_TO_FX32(0.0), (-FLOAT_TO_FX32(1.5) * flipBoard->gameWork.mapObjectParam_bounceForce) - FLOAT_TO_FX32(7.5));
    Player__Action_AllowTrickCombos(player, &flipBoard->gameWork);
    StageTask__SetAnimatorPriority(&flipBoard->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetOAMPriority(&flipBoard->aniSnow.work, SPRITE_PRIORITY_1);
    flipBoard->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FLIP_BOARD);
}
