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

NOT_DECOMPILED const char aActAcGmkPipeFl_0[];
NOT_DECOMPILED const char aActAcGmkPipeSt[];

// --------------------
// FUNCTIONS
// --------------------

FlowerPipe *FlowerPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FlowerPipe);
    if (task == HeapNull)
        return NULL;

    FlowerPipe *work = TaskGetWork(task, FlowerPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, aActAcGmkPipeFl_0, GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].rect, -2, -2, 2, 2);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], FlowerPipe__OnDefend_216188C);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FlowerPipe__OnDefend_2161854);

    u16 anim;
    s16 paletteSlot;
    switch (mapObject->id)
    {
        case MAPOBJECT_115:
        default:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], FlowerPipe__OnDefend_216174C);

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
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj                      = NULL;
            work->gameWork.collisionObject.work.parent               = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data            = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width                = 56;
            work->gameWork.collisionObject.work.height               = 24;
            work->gameWork.collisionObject.work.ofst_x               = -28;
            work->gameWork.collisionObject.work.ofst_y               = 0;
            work->gameWork.objWork.userWork                          = 6;
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 1;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, 14, 2, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;

        case MAPOBJECT_117:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -32;
            work->gameWork.collisionObject.work.ofst_y    = -44;

            work->gameWork.objWork.userWork                          = 7;
            work->gameWork.objWork.dir.z                             = FLOAT_DEG_TO_IDX(90.0);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 2;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -18, 14, -14, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;
    }

    work->gameWork.objWork.userFlag = 0;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, paletteSlot);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161728);

    return work;
}

SteamPipe *SteamPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SteamPipe);
    if (task == HeapNull)
        return NULL;

    SteamPipe *work = TaskGetWork(task, SteamPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, aActAcGmkPipeSt, GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.objWork.userFlag = 1;
    u16 const *id                   = &mapObject->id;

    u16 anim;
    if (*id >= MAPOBJECT_127 && *id <= MAPOBJECT_130)
    {
        ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_2161DA0);

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
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, -2, 2, 2);
            ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], SteamPipe__OnDefend_2161DE0);
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

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

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
