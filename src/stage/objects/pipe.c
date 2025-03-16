#include <stage/objects/pipe.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/pipeFlowSeed.h>
#include <stage/effects/pipeFlowPetal.h>
#include <stage/effects/steam.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SteamPipeCollisionRect_
{
    s16 width;
    s16 height;
    s16 offsetX;
    s16 offsetY;
} SteamPipeCollisionRect;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED const fx32 SteamPipe__dword_2188390[];
NOT_DECOMPILED const fx32 SteamPipe__dword_2188398[];
NOT_DECOMPILED const fx32 FlowerPipe__dword_21883A0[];
NOT_DECOMPILED const fx32 FlowerPipe__dword_21883A8[];
static const SteamPipeCollisionRect SteamPipe__stru_21883B0[] = {
    { 24, 48, -24, -24 }, { 48, 24, -24, 0 }, { 24, 48, -24, -24 }, { 48, 24, -24, 0 }, { 40, 48, -24, -24 }, { 48, 40, -24, -16 }, { 40, 48, -24, -24 }, { 48, 40, -24, -16 },
};

NOT_DECOMPILED fx32 FlowerPipe__dword_2188F2C[];
NOT_DECOMPILED fx32 FlowerPipe__dword_2188F40[];
NOT_DECOMPILED fx32 FlowerPipe__dword_2188F54[];
NOT_DECOMPILED fx32 FlowerPipe__dword_2188F68[];

NOT_DECOMPILED void *aActAcGmkPipeFl_0;
NOT_DECOMPILED void *aActAcGmkPipeSt;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC FlowerPipe *FlowerPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
	// https://decomp.me/scratch/bbNIP -> 98.67%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FlowerPipe);
    if (task == HeapNull)
        return NULL;

    FlowerPipe *work = TaskGetWork(task, FlowerPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pipe_flw.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    ObjRect__SetBox2D(&work->gameWork.colliders[2].rect, -2, -2, 2, 2);
    ObjRect__SetAttackStat(&work->gameWork.colliders[2], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[2], ~1, 0);
    work->gameWork.colliders[2].flag |= OBS_RECT_WORK_FLAG_400;
    ObjRect__SetOnDefend(&work->gameWork.colliders[2], FlowerPipe__OnDefend_216188C);

    ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], FlowerPipe__OnDefend_2161854);

	u16 anim;
	u16 paletteSlot;
    switch (mapObject->id)
    {
        case MAPOBJECT_115:
            ObjRect__SetOnDefend(&work->gameWork.colliders[0], FlowerPipe__OnDefend_216174C);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -16;
            work->gameWork.collisionObject.work.ofst_y    = -28;
            work->gameWork.objWork.userWork               = 4;

            anim        = 0;
            paletteSlot = 9;
            break;

        case MAPOBJECT_116:
            ObjRect__SetOnDefend(&work->gameWork.colliders[0], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 56;
            work->gameWork.collisionObject.work.height    = 24;
            work->gameWork.collisionObject.work.ofst_x    = -28;
            work->gameWork.collisionObject.work.ofst_y    = 0;
            work->gameWork.objWork.userWork               = 6;
            work->gameWork.colliders[1].parent            = &work->gameWork.objWork;

            anim        = 1;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -2, 14, 2, 18);

            work->gameWork.colliders[2].parent = &work->gameWork.objWork;
            break;

        case MAPOBJECT_117:
            ObjRect__SetOnDefend(&work->gameWork.colliders[0], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -32;
            work->gameWork.collisionObject.work.ofst_y    = -44;

            work->gameWork.objWork.userWork    = 7;
            work->gameWork.objWork.dir.z       = 0x4000;
            work->gameWork.colliders[1].parent = &work->gameWork.objWork;

            anim        = 2;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -18, 14, -14, 18);

            work->gameWork.colliders[2].parent = &work->gameWork.objWork;
            break;
    }

    work->gameWork.objWork.userFlag = 0;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, paletteSlot);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161728);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
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
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0x9f
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkPipeFl_0
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x230]
	mov r3, #2
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	str r3, [sp]
	add r0, r4, #0x298
	sub r1, r3, #4
	mov r2, r1
	bl ObjRect__SetBox2D
	add r0, r4, #0x298
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x298
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x2b0]
	ldr r0, =FlowerPipe__OnDefend_216188C
	orr r1, r1, #0x400
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x2bc]
	add r0, r4, #0x258
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	ldr r0, =FlowerPipe__OnDefend_2161854
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	str r0, [r4, #0x27c]
	ldrh r0, [r7, #2]
	cmp r0, #0x73
	beq _02161264
	cmp r0, #0x74
	beq _021612B8
	cmp r0, #0x75
	beq _02161330
_02161264:
	ldr r0, =FlowerPipe__OnDefend_216174C
	mov r2, #0x58
	str r0, [r4, #0x23c]
	mov r5, #0
	str r5, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x10
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x68
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x74
	strh r1, [r0, #0xf2]
	mov r0, #4
	str r0, [r4, #0x28]
	mov r6, #9
	b _021613B0
_021612B8:
	ldr r0, =SteamPipe__OnDefend_21617B0
	mov r2, #0x18
	str r0, [r4, #0x23c]
	mov r3, #0
	str r3, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x38
	strh r1, [r0, #8]
	mov r1, #0x12
	strh r2, [r0, #0xa]
	sub r2, r2, #0x34
	add r0, r4, #0x200
	strh r2, [r0, #0xf0]
	strh r3, [r0, #0xf2]
	mov r0, #6
	str r0, [r4, #0x28]
	str r4, [r4, #0x274]
	str r1, [sp]
	add r0, r4, #0x258
	sub r1, r1, #0x14
	mov r2, #0xe
	mov r3, #2
	mov r5, #1
	mov r6, #0xa
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
	b _021613B0
_02161330:
	ldr r0, =SteamPipe__OnDefend_21617B0
	mov r3, #0x58
	str r0, [r4, #0x23c]
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	add r0, r4, #0x300
	mov r1, #0x10
	strh r1, [r0, #8]
	mov r5, #0x12
	mov r2, #0xe
	strh r3, [r0, #0xa]
	sub r1, r3, #0x78
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r3, #0x84
	strh r1, [r0, #0xf2]
	mov r0, #7
	str r0, [r4, #0x28]
	mov r0, #0x4000
	strh r0, [r4, #0x34]
	str r4, [r4, #0x274]
	add r0, r4, #0x258
	sub r1, r5, #0x24
	sub r3, r2, #0x1c
	str r5, [sp]
	mov r5, #2
	mov r6, #0xa
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
_021613B0:
	mov r0, #0
	str r0, [r4, #0x24]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r3, r1, #0x2100
	mov r1, r5
	mov r2, r6
	str r3, [r4, #0x1c]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	ldr r1, =SteamPipe__State_2161728
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC SteamPipe *SteamPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/dHDuk -> 99.07%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SteamPipe);
    if (task == HeapNull)
        return NULL;

    SteamPipe *work = TaskGetWork(task, SteamPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pipe_steam.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;
    work->gameWork.objWork.userFlag = 1;

    u16 anim;
    if (mapObject->id >= MAPOBJECT_127 && mapObject->id <= MAPOBJECT_130)
    {
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], SteamPipe__OnDefend_2161DA0);

        work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_127);
        switch (mapObject->id)
        {
            case MAPOBJECT_127:
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                // fallthrough

            case MAPOBJECT_129:
                anim = 0;
                break;

            case MAPOBJECT_130:
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                // fallthrough

            case MAPOBJECT_128:
                anim = 1;
                break;
        }

        SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161728);
    }
    else
    {
        if (mapObject->id >= MAPOBJECT_131 && mapObject->id <= MAPOBJECT_134)
        {
            ObjRect__SetOnDefend(&work->gameWork.colliders[0], SteamPipe__OnDefend_21617B0);

            work->gameWork.colliders[1].parent = &work->gameWork.objWork;
            ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -2, -2, 2, 2);
            ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
            work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;
            ObjRect__SetOnDefend(&work->gameWork.colliders[1], SteamPipe__OnDefend_2161DE0);
            work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_131);

            switch (mapObject->id)
            {
                case MAPOBJECT_131:
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                    // fallthrough

                case MAPOBJECT_133:
                    anim = 2;
                    break;

                case MAPOBJECT_134:
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                    // fallthrough

                case MAPOBJECT_132:
                    anim = 3;
                    break;
            }
        }
    }

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;

    const SteamPipeCollisionRect *config       = &SteamPipe__stru_21883B0[mapObject->id - MAPOBJECT_127];
    work->gameWork.collisionObject.work.width  = config->width;
    work->gameWork.collisionObject.work.height = config->height;
    work->gameWork.collisionObject.work.ofst_x = config->offsetX;
    work->gameWork.collisionObject.work.ofst_y = config->offsetY;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 32);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	mov r0, #0x9f
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkPipeSt
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	mov r0, #1
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x24]
	ldrh r0, [r8, #2]
	cmp r0, #0x7f
	blo _021615A8
	cmp r0, #0x82
	bhi _021615A8
	ldr r0, =SteamPipe__OnDefend_2161DA0
	str r0, [r4, #0x23c]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x7f
	mov r0, r0, lsl #1
	str r0, [r4, #0x28]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x7f
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216159C
_02161568: // jump table
	b _02161578 // case 0
	b _02161598 // case 1
	b _02161584 // case 2
	b _0216158C // case 3
_02161578:
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
_02161584:
	mov r5, #0
	b _0216159C
_0216158C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
_02161598:
	mov r5, #1
_0216159C:
	ldr r0, =SteamPipe__State_2161728
	str r0, [r4, #0xf4]
	b _0216166C
_021615A8:
	ldrh r0, [r8, #2]
	cmp r0, #0x83
	blo _0216166C
	cmp r0, #0x86
	bhi _0216166C
	ldr r0, =SteamPipe__OnDefend_21617B0
	mov r3, #2
	str r0, [r4, #0x23c]
	sub r1, r3, #4
	str r4, [r4, #0x274]
	mov r2, r1
	add r0, r4, #0x258
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	ldr r0, =SteamPipe__OnDefend_2161DE0
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	str r0, [r4, #0x27c]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x83
	mov r0, r0, lsl #1
	str r0, [r4, #0x28]
	ldrh r0, [r8, #2]
	sub r0, r0, #0x83
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216166C
_02161638: // jump table
	b _02161648 // case 0
	b _02161668 // case 1
	b _02161654 // case 2
	b _0216165C // case 3
_02161648:
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
_02161654:
	mov r5, #2
	b _0216166C
_0216165C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
_02161668:
	mov r5, #3
_0216166C:
	mov r1, #0
	str r1, [r4, #0x13c]
	ldr r0, =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	ldrh r0, [r8, #2]
	ldr r6, =SteamPipe__stru_21883B0
	add r3, r4, #0x300
	sub r2, r0, #0x7f
	mov r0, r2, lsl #3
	ldrsh r0, [r6, r0]
	add r8, r6, r2, lsl #3
	add r6, r4, #0x200
	strh r0, [r3, #8]
	ldrsh r7, [r8, #2]
	mov r0, r4
	mov r2, #0x20
	strh r7, [r3, #0xa]
	ldrsh r3, [r8, #4]
	strh r3, [r6, #0xf0]
	ldrsh r3, [r8, #6]
	strh r3, [r6, #0xf2]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	ldr r3, [r4, #0x20]
	orr r3, r3, #0x100
	str r3, [r4, #0x20]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void SteamPipe__State_2161728(SteamPipe *work)
{
    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

void FlowerPipe__OnDefend_216174C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 angle = pipe->gameWork.objWork.userWork * FLOAT_DEG_TO_IDX(45.0);

    pipe->gameWork.objWork.userTimer = 96;
    pipe->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    Player__Action_PipeEnter(player, &pipe->gameWork, angle + FLOAT_DEG_TO_IDX(180.0), FlowerPipe__dword_21883A0[pipe->gameWork.objWork.userFlag]);
}

NONMATCH_FUNC void SteamPipe__OnDefend_21617B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x6d8]
	cmp r0, r4
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	mov r2, #0
	ldrsb ip, [r0, #6]
	ldr lr, [r4, #0x24]
	ldr r0, =SteamPipe__dword_2188390
	cmp ip, #0
	ldr r1, [r0, lr, lsl #2]
	ldrgt r0, =SteamPipe__dword_2188398
	mov r3, r2
	ldrgt r0, [r0, lr, lsl #2]
	mlagt r1, ip, r0, r1
	cmp lr, #1
	movls r2, #1
	cmp lr, #0
	moveq r3, #0
	beq _02161834
	cmp lr, #1
	moveq r3, #1
_02161834:
	mov r0, r5
	bl Player__Action_PipeExit
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void FlowerPipe__OnDefend_2161854(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = FlowerPipe__dword_21883A8[pipe->gameWork.objWork.userFlag];
}

NONMATCH_FUNC void FlowerPipe__OnDefend_216188C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r2, #0
	cmpne r1, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r1, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r1, #0x6d8]
	cmp r0, r2
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r1, #0x1c]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r2, #0x28]
	mov r5, #0
	cmp r0, #6
	sub r10, r5, #0x4000
	ldr r6, [r2, #0x44]
	ldr r7, [r2, #0x48]
	bne _02161A14
	ldr r8, =FlowerPipe__dword_2188F54
	ldr r9, =FlowerPipe__dword_2188F2C
	ldr r11, =_mt_math_rand
	mov r4, r5
_021618F4:
	ldr r3, [r11, #0]
	ldr r2, =0x00196225
	ldr r0, =0x3C6EF35F
	mov r1, r7
	mla r0, r3, r2, r0
	mov r3, r2
	ldr r2, =0x3C6EF35F
	mla r2, r0, r3, r2
	str r2, [r11]
	str r5, [sp]
	ldr r2, [r11, #0]
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r2, lsr #0x10
	and r2, r0, #3
	and r0, r3, #3
	ldr r3, [r8], #4
	sub r2, r2, #1
	add r2, r3, r2, lsl #10
	ldr r3, [r9], #4
	sub r0, r0, #1
	add r3, r3, r0, lsl #11
	add r0, r6, r10
	bl EffectFlowerPipePetal__Create
	eor r0, r5, #1
	add r4, r4, #1
	mov r0, r0, lsl #0x10
	cmp r4, #5
	add r10, r10, #0x2000
	mov r5, r0, lsr #0x10
	blt _021618F4
	mov r10, #0
	mov r4, #0x4000
	ldr r8, =_mt_math_rand
	ldr r11, =0x3C6EF35F
	sub r9, r10, #0x2400
	rsb r4, r4, #0
_02161994:
	ldr r2, [r8, #0]
	ldr r0, =0x00196225
	mov r1, r7
	mla r0, r2, r0, r11
	ldr r2, =0x00196225
	mov r3, r0, lsr #0x10
	mla r2, r0, r2, r11
	str r2, [r8]
	str r5, [sp]
	ldr r2, [r8, #0]
	mov r0, r2, lsr #0x10
	mov r2, r0, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r2, #7
	sub r2, r0, #3
	mov r3, r3, lsl #0x1d
	add r0, r6, r9
	mov r2, r2, lsl #0xc
	sub r3, r4, r3, lsr #18
	bl EffectFlowerPipeSeed__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	add r10, r10, #1
	movhs r5, #0
	cmp r10, #0xa
	add r9, r9, #0x800
	blt _02161994
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02161A14:
	ldr r4, =FlowerPipe__dword_2188F40
	ldr r8, =FlowerPipe__dword_2188F68
	ldr r11, =_mt_math_rand
	mov r9, r5
_02161A24:
	ldr r3, [r11, #0]
	ldr r2, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r0, r6
	mla r1, r3, r2, r1
	mov r3, r2
	ldr r2, =0x3C6EF35F
	mla r2, r1, r3, r2
	str r2, [r11]
	str r5, [sp]
	ldr r2, [r11, #0]
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, r2, lsr #0x10
	and r2, r1, #3
	and r1, r3, #3
	ldr r3, [r4], #4
	sub r2, r2, #1
	add r2, r3, r2, lsl #10
	ldr r3, [r8], #4
	sub r1, r1, #1
	add r3, r3, r1, lsl #11
	add r1, r7, r10
	bl EffectFlowerPipePetal__Create
	eor r0, r5, #1
	add r9, r9, #1
	mov r0, r0, lsl #0x10
	cmp r9, #5
	add r10, r10, #0x2000
	mov r5, r0, lsr #0x10
	blt _02161A24
	mov r10, #0
	mov r4, #0x3000
	ldr r8, =_mt_math_rand
	ldr r11, =0x3C6EF35F
	sub r9, r10, #0x2400
	rsb r4, r4, #0
_02161AC4:
	ldr r2, [r8, #0]
	ldr r0, =0x00196225
	mov r1, r7
	mla r0, r2, r0, r11
	ldr r2, =0x00196225
	mla r2, r0, r2, r11
	str r2, [r8]
	str r5, [sp]
	ldr r2, [r8, #0]
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	and r2, r2, #7
	sub r0, r2, #3
	mov r2, r0, lsl #0xb
	mov r3, r3, lsl #0x1d
	add r0, r6, r9
	add r2, r2, #0x3000
	sub r3, r4, r3, lsr #18
	bl EffectFlowerPipeSeed__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	add r10, r10, #1
	movhs r5, #0
	cmp r10, #0xa
	add r9, r9, #0x800
	blt _02161AC4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SteamPipe__State_2161B64(SteamPipe *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 0)
            StageTask__SetAnimation(&work->gameWork.objWork, 4);
        else
            StageTask__SetAnimation(&work->gameWork.objWork, 7);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void SteamPipe__State_2161BB0(SteamPipe *work)
{
    work->gameWork.objWork.userTimer = StageTask__DecrementBySpeed(work->gameWork.objWork.userTimer);

    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 5)
            StageTask__SetAnimation(&work->gameWork.objWork, 6);
        else
            StageTask__SetAnimation(&work->gameWork.objWork, 9);
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

        ObjDrawReleaseSprite(32);
        ObjActionAllocSpritePalette(&work->gameWork.objWork, 6, 34);

        SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161D20);

        fx32 dustX = work->gameWork.objWork.position.x;
        fx32 dustY = work->gameWork.objWork.position.y;

        fx32 dustVelX;
        fx32 dustVelY;

        switch (work->gameWork.mapObject->id)
        {
            case MAPOBJECT_131:
            default:
                dustVelX = FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_132:
                dustVelX = FLOAT_TO_FX32(0.0);
                dustVelY = FLOAT_TO_FX32(4.0);

                dustY += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_133:
                dustVelX = -FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX -= FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_134:
                dustVelX = FLOAT_TO_FX32(0.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustY -= FLOAT_TO_FX32(16.0);
                break;
        }

        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX + FLOAT_TO_FX32(0.0), dustVelY - FLOAT_TO_FX32(1.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX + FLOAT_TO_FX32(1.5), dustVelY + FLOAT_TO_FX32(2.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_SMALL, dustX, dustY, dustVelX + FLOAT_TO_FX32(2.5), dustVelY + FLOAT_TO_FX32(0.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX - FLOAT_TO_FX32(1.5), dustVelY + FLOAT_TO_FX32(1.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_SMALL, dustX, dustY, dustVelX - FLOAT_TO_FX32(2.5), dustVelY - FLOAT_TO_FX32(2.0));
    }
}

void SteamPipe__State_2161D20(SteamPipe *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        SetTaskState(&work->gameWork.objWork, NULL);

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

        switch (work->gameWork.mapObject->id)
        {
            case MAPOBJECT_127:
            case MAPOBJECT_128:
            case MAPOBJECT_129:
            case MAPOBJECT_130:
                break;

            case MAPOBJECT_131:
            case MAPOBJECT_133:
                work->gameWork.collisionObject.work.ofst_x += 7;
                break;

            case MAPOBJECT_132:
            case MAPOBJECT_134:
                work->gameWork.collisionObject.work.ofst_y -= 7;
                break;
        }
    }
}

void SteamPipe__OnDefend_2161DA0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    FlowerPipe__OnDefend_216174C(rect1, rect2);
    pipe->gameWork.objWork.userTimer = 8;

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_2161B64);
}

void SteamPipe__OnDefend_2161DE0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = FlowerPipe__dword_21883A8[pipe->gameWork.objWork.userFlag];

    if (pipe->gameWork.objWork.obj_2d->ani.work.animID == 2)
        StageTask__SetAnimation(&pipe->gameWork.objWork, 5);
    else
        StageTask__SetAnimation(&pipe->gameWork.objWork, 8);

    pipe->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    pipe->gameWork.objWork.userTimer = player->objWork.hitstopTimer;

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_2161BB0);
}