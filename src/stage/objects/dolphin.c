#include <stage/objects/dolphin.h>
#include <game/stage/gameSystem.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void *aModGmkDolphinN_0;
NOT_DECOMPILED void *aModGmkDolphinN;
NOT_DECOMPILED void *aActAcGmkDolphi;

// --------------------
// CONSTANTS
// --------------------

#define DOLPHINHOOP_ANI_NONE 0xFFFF

// --------------------
// ENUMS
// --------------------

enum DolphinObjectFlags
{
    DOLPHIN_OBJFLAG_NONE,

    DOLPHIN_OBJFLAG_FLIP_X = (1 << 0),
};

enum DolphinFlags
{
    DOLPHIN_FLAG_NONE,

    DOLPHIN_FLAG_PLAYING_BEGIN_ANIM = (1 << 0),
};

enum DolphinAnimIDs
{
    DOLPHIN_ANI_IDLE,
    DOLPHIN_ANI_BEGIN_RIDE,
    DOLPHIN_ANI_RIDDEN,
};

enum DolphinHoopType
{
    DOLPHINHOOP_TYPE_LEFT_MID,
    DOLPHINHOOP_TYPE_LEFT_NEAR,
    DOLPHINHOOP_TYPE_RIGHT_MID,
    DOLPHINHOOP_TYPE_RIGHT_FAR,
    DOLPHINHOOP_TYPE_CENTER_MID,
    DOLPHINHOOP_TYPE_END_MID,
    DOLPHINHOOP_TYPE_CENTER_CLOSE,
    DOLPHINHOOP_TYPE_CENTER_FAR,

    DOLPHINHOOP_TYPE_COUNT,
};

enum DolphinHoopAnimIDs
{
    DOLPHINHOOP_ANI_CENTER_MID,
    DOLPHINHOOP_ANI_END_MID,
    DOLPHINHOOP_ANI_LEFT_MID_FRONT,
    DOLPHINHOOP_ANI_LEFT_MID_BACK,
    DOLPHINHOOP_ANI_RIGHT_MID_FRONT,
    DOLPHINHOOP_ANI_RIGHT_MID_BACK,
    DOLPHINHOOP_ANI_RIGHT_FAR_FRONT,
    DOLPHINHOOP_ANI_RIGHT_FAR_BACK,
    DOLPHINHOOP_ANI_LEFT_NEAR_FRONT,
    DOLPHINHOOP_ANI_LEFT_NEAR_BACK,
    DOLPHINHOOP_ANI_CENTER_FAR,
    DOLPHINHOOP_ANI_CENTER_CLOSE,
};

// --------------------
// VARIABLES
// --------------------

static u8 hoopPriorityConfig[DOLPHINHOOP_TYPE_COUNT][2] = {
    [DOLPHINHOOP_TYPE_LEFT_MID] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_2 },     [DOLPHINHOOP_TYPE_LEFT_NEAR] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_1 },
    [DOLPHINHOOP_TYPE_RIGHT_MID] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_2 },    [DOLPHINHOOP_TYPE_RIGHT_FAR] = { SPRITE_PRIORITY_2, SPRITE_PRIORITY_2 },
    [DOLPHINHOOP_TYPE_CENTER_MID] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_1 },   [DOLPHINHOOP_TYPE_END_MID] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_1 },
    [DOLPHINHOOP_TYPE_CENTER_CLOSE] = { SPRITE_PRIORITY_1, SPRITE_PRIORITY_1 }, [DOLPHINHOOP_TYPE_CENTER_FAR] = { SPRITE_PRIORITY_2, SPRITE_PRIORITY_2 },
};

static u16 hoopAnimConfig[DOLPHINHOOP_TYPE_COUNT][2] = {
    [DOLPHINHOOP_TYPE_LEFT_MID]     = { DOLPHINHOOP_ANI_LEFT_MID_FRONT, DOLPHINHOOP_ANI_LEFT_MID_BACK },
    [DOLPHINHOOP_TYPE_LEFT_NEAR]    = { DOLPHINHOOP_ANI_LEFT_NEAR_FRONT, DOLPHINHOOP_ANI_LEFT_NEAR_BACK },
    [DOLPHINHOOP_TYPE_RIGHT_MID]    = { DOLPHINHOOP_ANI_RIGHT_MID_FRONT, DOLPHINHOOP_ANI_RIGHT_MID_BACK },
    [DOLPHINHOOP_TYPE_RIGHT_FAR]    = { DOLPHINHOOP_ANI_RIGHT_FAR_FRONT, DOLPHINHOOP_ANI_RIGHT_FAR_BACK },
    [DOLPHINHOOP_TYPE_CENTER_MID]   = { DOLPHINHOOP_ANI_CENTER_MID, DOLPHINHOOP_ANI_NONE },
    [DOLPHINHOOP_TYPE_END_MID]      = { DOLPHINHOOP_ANI_END_MID, DOLPHINHOOP_ANI_NONE },
    [DOLPHINHOOP_TYPE_CENTER_CLOSE] = { DOLPHINHOOP_ANI_CENTER_CLOSE, DOLPHINHOOP_ANI_NONE },
    [DOLPHINHOOP_TYPE_CENTER_FAR]   = { DOLPHINHOOP_ANI_CENTER_FAR, DOLPHINHOOP_ANI_NONE },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Dolphin_Action_BeginRide(Dolphin *work);
static void Dolphin_State_RideActive(Dolphin *work);
static void Dolphin_State_RideEnded(Dolphin *work);
static void Dolphin_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

static void DolphinHoop_Destructor(Task *task);
static void DolphinHoop_State_Active(DolphinHoop *work);
static void DolphinHoop_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void DolphinHoop_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC Dolphin *CreateDolphin(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/tTszU -> 88.58%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Dolphin);
    if (task == HeapNull)
        return NULL;

    Dolphin *work = TaskGetWork(task, Dolphin);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_80000;

    OBS_ACTION3D_NN_WORK *aniDolphin = &work->aniDolphin;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniDolphin, "/mod/gmk_dolphin.nsbmd", 0, GetObjectDataWork(OBJDATAWORK_169), gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, aniDolphin, "/mod/gmk_dolphin.nsbca", GetObjectDataWork(OBJDATAWORK_170), gameArchiveStage);

    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], DOLPHIN_ANI_IDLE, NULL);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_APPLY_CAMERA_CONFIG | DISPLAY_FLAG_DISABLE_LOOPING;
    VEC_Set(&aniDolphin->ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -12, -16, 16, 12);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Dolphin_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    if ((mapObject->flags & DOLPHIN_OBJFLAG_FLIP_X) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

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
	mov r4, #0x4e0
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
	mov r2, #0x4e0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa9
	orr r1, r1, #0x2140
	orr r1, r1, #0x80000
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, =aModGmkDolphinN
	mov r3, #0
	bl ObjAction3dNNModelLoad
	mov r0, #0xaa
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp]
	ldr r2, =aModGmkDolphinN_0
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =0x000034CC
	orr r1, r1, #0x204
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	str r4, [r4, #0x234]
	mov r2, #0xc
	str r2, [sp]
	add r0, r4, #0x218
	sub r1, r2, #0x18
	sub r2, r2, #0x1c
	mov r3, #0x10
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =Dolphin_OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	ldrh r0, [r7, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC DolphinHoop *CreateDolphinHoop(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // should match when 'aActAcGmkDolphi' and other strings are decompiled
#ifdef NON_MATCHING
    Task *task = CreateStageTask(DolphinHoop_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DolphinHoop);
    if (task == HeapNull)
        return NULL;

    DolphinHoop *work = TaskGetWork(task, DolphinHoop);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->type = mapObject->id - MAPOBJECT_216;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dolphin_hoop.bac", GetObjectDataWork(OBJDATAWORK_171), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);

    s32 paletteFlags;
    if (mapObject->id == MAPOBJECT_221)
        paletteFlags = 98;
    else
        paletteFlags = 99;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, hoopAnimConfig[work->type][0], paletteFlags);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, hoopPriorityConfig[work->type][0]);
    StageTask__SetAnimation(&work->gameWork.objWork, hoopAnimConfig[work->type][0]);

    if (hoopAnimConfig[work->type][1] != DOLPHINHOOP_ANI_NONE)
    {
        AnimatorSpriteDS *aniRingBack = &work->aniRingBack;
        ObjAction2dBACLoad(aniRingBack, "/act/ac_gmk_dolphin_hoop.bac", OBJ_DATA_GFX_AUTO, GetObjectDataWork(OBJDATAWORK_171), gameArchiveStage);

        aniRingBack->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
        aniRingBack->cParam[0].palette = aniRingBack->cParam[1].palette = aniRingBack->work.cParam.palette;

        aniRingBack->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
        AnimatorSpriteDS__SetAnimation(&work->aniRingBack, hoopAnimConfig[work->type][1]);
        StageTask__SetOAMOrder(&aniRingBack->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&aniRingBack->work, hoopPriorityConfig[work->type][1]);
    }

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox3D(&work->gameWork.colliders[0].rect, -16, -28, -16, 16, 28, 16);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    work->gameWork.colliders[0].onDefend = DolphinHoop_OnDefend;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    switch (work->type)
    {
        case DOLPHINHOOP_TYPE_LEFT_NEAR:
        case DOLPHINHOOP_TYPE_CENTER_CLOSE:
            work->gameWork.objWork.position.z = FLOAT_TO_FX32(90.0);
            break;

        case DOLPHINHOOP_TYPE_RIGHT_FAR:
        case DOLPHINHOOP_TYPE_CENTER_FAR:
            work->gameWork.objWork.position.z = -FLOAT_TO_FX32(90.0);
            break;
    }

    if ((mapObject->flags & DOLPHIN_OBJFLAG_FLIP_X) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    SetTaskOutFunc(&work->gameWork.objWork, DolphinHoop_Draw);
    SetTaskState(&work->gameWork.objWork, DolphinHoop_State_Active);

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
	ldr r4, =0x0000040C
	ldr r0, =StageTask_Main
	ldr r1, =DolphinHoop_Destructor
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
	ldrh r2, [r7, #2]
	add r1, r4, #0x400
	mov r0, #0xab
	sub r2, r2, #0xd8
	strh r2, [r1, #8]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcGmkDolphi
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldrh r0, [r7, #2]
	cmp r0, #0xdd
	add r0, r4, #0x400
	ldrh r1, [r0, #8]
	moveq r2, #0x62
	movne r2, #0x63
	mov r2, r2, lsl #0x10
	ldr r0, =hoopAnimConfig
	mov r1, r1, lsl #2
	ldrh r1, [r0, r1]
	mov r0, r4
	mov r2, r2, asr #0x10
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, =hoopPriorityConfig
	mov r0, r4
	ldrb r1, [r1, r2, lsl #1]
	bl StageTask__SetAnimatorPriority
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, =hoopAnimConfig
	mov r0, r4
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	bl StageTask__SetAnimation
	add r0, r4, #0x400
	ldrh r2, [r0, #8]
	ldr r1, =0x02189BF2
	ldr r0, =0x0000FFFF
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	cmp r1, r0
	beq _02181B94
	mov r0, #0xab
	add r5, r4, #0x364
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r6, [r1, #0]
	ldr r1, =aActAcGmkDolphi
	ldr r2, =0x0000FFFF
	mov r0, r5
	str r6, [sp]
	bl ObjAction2dBACLoad
	ldr r0, [r4, #0x128]
	add r1, r4, #0x400
	ldrh r3, [r0, #0x50]
	ldr r2, =0x02189BF2
	mov r0, r5
	strh r3, [r5, #0x50]
	strh r3, [r5, #0x92]
	strh r3, [r5, #0x90]
	ldr r3, [r5, #0x3c]
	orr r3, r3, #0x10
	str r3, [r5, #0x3c]
	ldrh r1, [r1, #8]
	mov r1, r1, lsl #2
	ldrh r1, [r2, r1]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	add r1, r4, #0x400
	ldrh r2, [r1, #8]
	ldr r1, =0x02189BE1
	mov r0, r5
	ldrb r1, [r1, r2, lsl #1]
	bl StageTask__SetOAMPriority
_02181B94:
	mov r2, #0x1c
	sub r1, r2, #0x2c
	str r4, [r4, #0x234]
	mov r5, #0x10
	str r5, [sp]
	str r2, [sp, #4]
	mov r3, r1
	add r0, r4, #0x218
	sub r2, r2, #0x38
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =DolphinHoop_OnDefend
	add r0, r4, #0x400
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldrh r0, [r0, #8]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02181C40
_02181C08: // jump table
	b _02181C40 // case 0
	b _02181C28 // case 1
	b _02181C40 // case 2
	b _02181C34 // case 3
	b _02181C40 // case 4
	b _02181C40 // case 5
	b _02181C28 // case 6
	b _02181C34 // case 7
_02181C28:
	mov r0, #0x5a000
	str r0, [r4, #0x4c]
	b _02181C40
_02181C34:
	mov r0, #0x5a000
	rsb r0, r0, #0
	str r0, [r4, #0x4c]
_02181C40:
	ldrh r0, [r7, #4]
	ldr r1, =DolphinHoop_State_Active
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, =DolphinHoop_Draw
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Dolphin_Action_BeginRide(Dolphin *work)
{
    work->gameWork.objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);

    StageTask__SetHitbox(&work->gameWork.objWork, 10, -20, 16, 8);

    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM], DOLPHIN_ANI_BEGIN_RIDE,
                              NULL);
    work->gameWork.objWork.displayFlag &= ~(DISPLAY_FLAG_APPLY_CAMERA_CONFIG | DISPLAY_FLAG_DISABLE_LOOPING);
    work->gameWork.flags |= DOLPHIN_FLAG_PLAYING_BEGIN_ANIM;

    SetTaskState(&work->gameWork.objWork, Dolphin_State_RideActive);
}

void Dolphin_State_RideActive(Dolphin *work)
{
    Player *player = (Player *)work->gameWork.parent;
    if (player == NULL || !CheckPlayerGimmickObj(player, work) || (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

        SetTaskState(&work->gameWork.objWork, Dolphin_State_RideEnded);
        Dolphin_State_RideEnded(work);
    }
    else
    {
        if ((work->gameWork.flags & DOLPHIN_FLAG_PLAYING_BEGIN_ANIM) != 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_JOINT_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_JOINT_ANIM],
                                      DOLPHIN_ANI_RIDDEN, NULL);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            work->gameWork.flags &= ~DOLPHIN_FLAG_PLAYING_BEGIN_ANIM;
        }

        MtxFx33 mtx;
        MtxFx33 mtxTemp;

        work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
        work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;
        work->gameWork.objWork.prevPosition.z = work->gameWork.objWork.position.z;

        MTX_Identity33(&mtx);

        MTX_RotY33(&mtx, SinFX((s32)(u16)-player->objWork.dir.y), CosFX((s32)(u16)-player->objWork.dir.y));
        work->gameWork.objWork.dir.y = player->objWork.dir.y;

        MTX_RotZ33(&mtxTemp, SinFX(player->objWork.dir.z), CosFX(player->objWork.dir.z));
        work->gameWork.objWork.dir.z = player->objWork.dir.z;

        MTX_Concat33(&mtx, &mtxTemp, &mtx);

        VecFx32 playerOffset;
        playerOffset.x = FLOAT_TO_FX32(0.0);
        playerOffset.z = FLOAT_TO_FX32(0.0);
        playerOffset.y = FLOAT_TO_FX32(8.0);
        MTX_MultVec33(&playerOffset, &mtx, &playerOffset);

        work->gameWork.objWork.position.x = player->objWork.position.x + playerOffset.x;
        work->gameWork.objWork.position.y = player->objWork.position.y + playerOffset.y;
        work->gameWork.objWork.position.z = player->objWork.position.z + playerOffset.z;

        work->gameWork.objWork.move.x = work->gameWork.objWork.position.x - work->gameWork.objWork.prevPosition.x;
        work->gameWork.objWork.move.y = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;
        work->gameWork.objWork.move.z = work->gameWork.objWork.position.z - work->gameWork.objWork.prevPosition.z;
    }
}

void Dolphin_State_RideEnded(Dolphin *work)
{
    fx32 accel;
    fx32 angleAccel;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        accel      = -FLOAT_TO_FX32(0.1875);
        angleAccel = accel + FLOAT_TO_FX32(0.0625);
    }
    else
    {
        accel      = FLOAT_TO_FX32(0.1875);
        angleAccel = accel - FLOAT_TO_FX32(0.0625);
    }

    if (mapCamera.camera[0].waterLevel + 32 >= FX32_TO_WHOLE(work->gameWork.objWork.position.y))
    {
        work->gameWork.objWork.dir.z = ObjSpdUpSet((s16)work->gameWork.objWork.dir.z, angleAccel, FLOAT_DEG_TO_IDX(67.5));
    }
    else
    {
        work->gameWork.objWork.dir.z      = ObjRoopMove16(work->gameWork.objWork.dir.z, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(1.40625));
        work->gameWork.objWork.dir.y      = ObjSpdUpSet((s16)work->gameWork.objWork.dir.y, accel, FLOAT_DEG_TO_IDX(45.0));
        work->gameWork.objWork.velocity.z = ObjSpdUpSet(work->gameWork.objWork.velocity.z, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(4.0));
    }

    work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, accel, FLOAT_TO_FX32(12.0));
}

void Dolphin_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Dolphin *dolphin = (Dolphin *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (dolphin == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    dolphin->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    Player__Action_RideDolphin(player, &dolphin->gameWork);

    dolphin->gameWork.parent = &player->objWork;
    Dolphin_Action_BeginRide(dolphin);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DOLPHIN);
}

void DolphinHoop_Destructor(Task *task)
{
    DolphinHoop *work = TaskGetWork(task, DolphinHoop);

    if (hoopAnimConfig[work->type][1] != DOLPHINHOOP_ANI_NONE)
        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_171), &work->aniRingBack);

    GameObject__Destructor(task);
}

void DolphinHoop_State_Active(DolphinHoop *work)
{
    fx32 playerZ = gPlayer->objWork.position.z;
    switch (work->gameWork.mapObject->id)
    {
        case MAPOBJECT_217:
            if (playerZ >= FLOAT_TO_FX32(10.0))
                StageTask__SetOAMPriority(&work->aniRingBack.work, SPRITE_PRIORITY_2);
            else
                StageTask__SetOAMPriority(&work->aniRingBack.work, SPRITE_PRIORITY_1);
            break;

        case MAPOBJECT_219:
        case MAPOBJECT_223:
            if (playerZ <= -FLOAT_TO_FX32(30.0))
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
            else
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
            break;

        case MAPOBJECT_216:
        case MAPOBJECT_218:
            if (playerZ >= FLOAT_TO_FX32(10.0))
            {
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
                StageTask__SetOAMPriority(&work->aniRingBack.work, SPRITE_PRIORITY_2);
            }

            if (playerZ <= -FLOAT_TO_FX32(30.0))
            {
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
                StageTask__SetOAMPriority(&work->aniRingBack.work, SPRITE_PRIORITY_1);
            }
            else
            {
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
                StageTask__SetOAMPriority(&work->aniRingBack.work, SPRITE_PRIORITY_2);
            }
            break;

        case MAPOBJECT_220:
        case MAPOBJECT_221:
            if (playerZ >= FLOAT_TO_FX32(10.0))
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
            else
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
            break;
    }
}

void DolphinHoop_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    DolphinHoop *hoop = (DolphinHoop *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if (hoop == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (StageTaskStateMatches(&player->objWork, Player__State_DolphinRide))
    {
        Player__Action_AllowTrickCombos(player, &hoop->gameWork);
        Player__Action_DolphinHoop(player, &hoop->gameWork);

        if (hoop->gameWork.mapObject->id == MAPOBJECT_221)
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRICK_DASH);
        else
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DASH_CIRCLE);
    }
}

void DolphinHoop_Draw(void)
{
    DolphinHoop *work = TaskGetWorkCurrent(DolphinHoop);

    // Draw front sprite
    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL,
                        NULL);

    // Draw back sprite (if it exists!)
    if (hoopAnimConfig[work->type][1] != DOLPHINHOOP_ANI_NONE)
        StageTask__Draw2DEx(&work->aniRingBack, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL, NULL);
}