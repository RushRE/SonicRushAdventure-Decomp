#include <stage/objects/spikes.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED u32 Spikes__AnimVRAMOffset[5];
NOT_DECOMPILED const char *aActAcGmkNeedle;

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used in Spikes
#define mapObjectParam_interval mapObject->left

// used in Spikes2
#define mapObjectParam_size mapObject->left

// --------------------
// ENUMS
// --------------------

enum SpikesAnimID
{
    SPIKES_ANI_VERTICAL_VISIBLE,
    SPIKES_ANI_VERTICAL_EXTEND,
    SPIKES_ANI_VERTICAL_RETRACT,
    SPIKES_ANI_VERTICAL_HIDDEN,
    SPIKES_ANI_HORIZONTAL,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SetSpikesAnimation(Spikes *work, u16 anim);

static void Spikes_Action_Idle(Spikes *work);
static void Spikes_State_Idle(Spikes *work);
static void Spikes_Action_Extend(Spikes *work);
static void Spikes_State_Extend(Spikes *work);
static void Spikes_Action_Retract(Spikes *work);
static void Spikes_State_Retract(Spikes *work);

static void Spikes2_State_Idle(Spikes *work);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC Spikes *CreateSpikes(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/1pyBn -> 95.38%
#ifdef NON_MATCHING
    OBS_SPRITE_REF *spriteRef;

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Spikes);
    if (task == HeapNull)
        return NULL;

    Spikes *work = TaskGetWork(task, Spikes);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_needle.bac", GetObjectFileWork(28), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 3);

    OBS_ACTION2D_BAC_WORK *aniWork = work->gameWork.objWork.obj_2d;
    switch (mapObject->id)
    {
        case MAPOBJECT_79:
        case MAPOBJECT_80:
            spriteRef = (OBS_SPRITE_REF *)GetObjectFileWork(31);
            ObjObjectActionAllocSprite(&work->gameWork.objWork, 40, spriteRef);
            if ((spriteRef->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            {
                SetSpikesAnimation(work, SPIKES_ANI_HORIZONTAL);
                aniWork->ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
                AnimatorSpriteDS__ProcessAnimationFast(&aniWork->ani);
            }
            break;

        default:
            spriteRef = (OBS_SPRITE_REF *)GetObjectFileWork(29);
            ObjObjectActionAllocSprite(&work->gameWork.objWork, 74, spriteRef);
            if ((spriteRef->engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            {
                for (u16 i = 0; i <= SPIKES_ANI_VERTICAL_HIDDEN; i++)
                {
                    SetSpikesAnimation(work, i);
                    aniWork->ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
                    AnimatorSpriteDS__ProcessAnimationFast(&aniWork->ani);
                }
            }
            break;
    }

    aniWork->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(work->gameWork.colliders, 2, 64);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0xFF);

    work->gameWork.objWork.collisionObj = NULL;

    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.flag |= 8;

    switch (mapObject->id)
    {
        case MAPOBJECT_79:
        case MAPOBJECT_80:
            work->gameWork.collisionObject.work.width  = 24;
            work->gameWork.collisionObject.work.height = 32;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -16;
            work->gameWork.field_358              = SPIKES_ANI_HORIZONTAL;
            break;

        default:
            work->gameWork.collisionObject.work.width  = 32;
            work->gameWork.collisionObject.work.height = 24;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -20;

            s32 anim = SPIKES_ANI_VERTICAL_VISIBLE;
            if (work->gameWork.mapObject->id >= MAPOBJECT_93)
                anim = SPIKES_ANI_VERTICAL_HIDDEN;
            work->gameWork.field_358 = anim;

            if (Player__UseUpsideDownGravity(x, y))
                work->gameWork.collisionObject.work.flag |= 8;
            break;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    switch (mapObject->id)
    {
        case MAPOBJECT_78:
        case MAPOBJECT_94:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_80:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;
    }

    Spikes_Action_Idle(work);

    if (mapObject->id >= MAPOBJECT_93)
    {
        work->gameWork.collisionObject.work.ofst_y = 4;
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_2;
        work->gameWork.objWork.userTimer = work->gameWork.mapObjectParam_interval;
    }

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r3, [sp]
	mov r7, #2
	str r7, [sp, #4]
	mov r7, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7
	bl GetTaskWork_
	mov r8, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r8
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	mov r0, #0x1c
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r8
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcGmkNeedle
	add r1, r8, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r8
	mov r1, #0
	mov r2, #3
	bl ObjActionAllocSpritePalette
	ldrh r0, [r6, #2]
	ldr r9, [r8, #0x128]
	cmp r0, #0x4f
	cmpne r0, #0x50
	bne _0215F55C
	mov r0, #0x1f
	bl GetObjectFileWork
	mov r7, r0
	mov r0, r8
	mov r2, r7
	mov r1, #0x28
	bl ObjObjectActionAllocSprite
	ldrh r0, [r7, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _0215F5D0
	mov r0, r8
	mov r1, #4
	bl SetSpikesAnimation
	ldr r0, [r9, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r9
	mov r2, r1
	str r3, [r9, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	b _0215F5D0
_0215F55C:
	mov r0, #0x1d
	bl GetObjectFileWork
	mov r7, r0
	mov r0, r8
	mov r2, r7
	mov r1, #0x4a
	bl ObjObjectActionAllocSprite
	ldrh r0, [r7, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _0215F5D0
	mov r10, #0
	mov r7, r10
	b _0215F5C8
_0215F594:
	mov r0, r8
	mov r1, r10
	bl SetSpikesAnimation
	ldr r1, [r9, #0x3c]
	mov r0, r9
	orr r3, r1, #0x60
	mov r1, r7
	mov r2, r7
	str r3, [r9, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
_0215F5C8:
	cmp r10, #3
	bls _0215F594
_0215F5D0:
	ldr r1, [r9, #0x3c]
	mov r0, r8
	orr r2, r1, #0x18
	mov r1, #0x17
	str r2, [r9, #0x3c]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r8
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r8, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFF
	add r0, r8, #0x218
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [r8, #0x13c]
	ldr r1, =StageTask__DefaultDiffData
	str r8, [r8, #0x2d8]
	str r1, [r8, #0x2fc]
	ldr r1, [r8, #0x2f4]
	orr r1, r1, #8
	str r1, [r8, #0x2f4]
	ldrh r1, [r6, #2]
	cmp r1, #0x4f
	cmpne r1, #0x50
	add r1, r8, #0x300
	bne _0215F674
	mov r2, #0x18
	mov r0, #0x20
	strh r2, [r1, #8]
	strh r0, [r1, #0xa]
	sub r2, r0, #0x30
	add r0, r8, #0x200
	strh r2, [r0, #0xf0]
	strh r2, [r0, #0xf2]
	mov r0, #4
	strh r0, [r1, #0x58]
	b _0215F6C8
_0215F674:
	mov r2, #0x20
	mov r7, #0x18
	strh r2, [r1, #8]
	strh r7, [r1, #0xa]
	sub r3, r7, #0x28
	add r2, r8, #0x200
	strh r3, [r2, #0xf0]
	sub r3, r7, #0x2c
	strh r3, [r2, #0xf2]
	ldr r2, [r8, #0x340]
	ldrh r2, [r2, #2]
	cmp r2, #0x5d
	movhs r0, #3
	strh r0, [r1, #0x58]
	mov r0, r5
	mov r1, r4
	bl Player__UseUpsideDownGravity
	cmp r0, #0
	ldrne r0, [r8, #0x2f4]
	orrne r0, r0, #8
	strne r0, [r8, #0x2f4]
_0215F6C8:
	ldr r0, [r8, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r8, #0x1c]
	ldrh r0, [r6, #2]
	cmp r0, #0x4e
	beq _0215F6F0
	cmp r0, #0x50
	beq _0215F700
	cmp r0, #0x5e
	bne _0215F70C
_0215F6F0:
	ldr r0, [r8, #0x20]
	orr r0, r0, #2
	str r0, [r8, #0x20]
	b _0215F70C
_0215F700:
	ldr r0, [r8, #0x20]
	orr r0, r0, #1
	str r0, [r8, #0x20]
_0215F70C:
	mov r0, r8
	bl Spikes_Action_Idle
	ldrh r0, [r6, #2]
	cmp r0, #0x5d
	blo _0215F744
	add r0, r8, #0x200
	mov r1, #4
	strh r1, [r0, #0xf2]
	ldr r0, [r8, #0x18]
	orr r0, r0, #2
	str r0, [r8, #0x18]
	ldr r0, [r8, #0x340]
	ldrsb r0, [r0, #6]
	str r0, [r8, #0x2c]
_0215F744:
	mov r0, r8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

Spikes *CreateSpikes2(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Spikes);
    if (task == HeapNull)
        return NULL;

    Spikes *work = TaskGetWork(task, Spikes);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    s8 size = MTM_MATH_CLIP_S8(mapObjectParam_size, 1, 5);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(work->gameWork.colliders, 2, 64);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~0, 0xFF);
    work->gameWork.objWork.collisionObj      = 0;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.flag |= 8;

    switch (mapObject->id)
    {
        case MAPOBJECT_274:
        case MAPOBJECT_275:
            ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -26, -12, -21, 32 * (size - 1) + 12);
            work->gameWork.collisionObject.work.width  = 24;
            work->gameWork.collisionObject.work.height = 32 * size;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -16;
            break;

        default:
            ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -16, -24, 32 * (size - 1) + 16, -21);
            work->gameWork.collisionObject.work.width  = 32 * size;
            work->gameWork.collisionObject.work.height = 24;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -20;

            if (Player__UseUpsideDownGravity(x, y))
                work->gameWork.collisionObject.work.flag |= 8;

            SetTaskState(&work->gameWork.objWork, Spikes2_State_Idle);
            break;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    switch (mapObject->id)
    {
        case MAPOBJECT_273:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_275:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;
    }

    return work;
}

NONMATCH_FUNC void SetSpikesAnimation(Spikes *work, u16 anim)
{
    // https://decomp.me/scratch/Lj4Zo -> 87.63%
#ifdef NON_MATCHING
    static u32 vramOffset[] = { 0x0000, 0x0A00, 0x0F00, 0x1200, 0x0000 };

    StageTask__SetAnimation(&work->gameWork.objWork, anim);
    
    work->gameWork.objWork.obj_2d->ani.vramPixels[0] = work->gameWork.objWork.obj_2d->spriteRef->engineRef[0].vramPixels + vramOffset[anim];
    work->gameWork.objWork.obj_2d->ani.vramPixels[1] = work->gameWork.objWork.obj_2d->spriteRef->engineRef[1].vramPixels + vramOffset[anim];
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl StageTask__SetAnimation
	ldr r3, [r5, #0x128]
	ldr r1, =Spikes__AnimVRAMOffset
	ldr r2, [r3, #0xa8]
	ldr r0, [r1, r4, lsl #2]
	ldr r2, [r2]
	add r0, r2, r0
	str r0, [r3, #0x78]
	ldr r2, [r5, #0x128]
	ldr r0, [r1, r4, lsl #2]
	ldr r1, [r2, #0xa8]
	ldr r1, [r1, #8]
	add r0, r1, r0
	str r0, [r2, #0x7c]
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

void Spikes_Action_Idle(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.field_358);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&work->gameWork.objWork, Spikes_State_Idle);
    work->gameWork.objWork.userTimer = 0;
}

void Spikes_State_Idle(Spikes *work)
{
    if (work->gameWork.mapObject->id >= MAPOBJECT_93)
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer > 120)
        {
            if (work->gameWork.field_358 == SPIKES_ANI_VERTICAL_HIDDEN)
            {
                work->gameWork.field_358 = SPIKES_ANI_VERTICAL_EXTEND;
                Spikes_Action_Extend(work);
            }
            else
            {
                work->gameWork.field_358 = SPIKES_ANI_VERTICAL_RETRACT;
                Spikes_Action_Retract(work);
            }
            return;
        }
    }

    if (work->gameWork.mapObject->id == MAPOBJECT_77 || work->gameWork.mapObject->id == MAPOBJECT_93)
    {
        Player *player = (Player *)work->gameWork.collisionObject.work.riderObj;
        if (player == NULL)
            return;

        Spikes *spikes = (Spikes *)player->objWork.rideObj;

        if (spikes != work || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
            return;

        if (ObjRect__FlagCheck(work->gameWork.colliders[0].hitFlag, player->colliders[0].defFlag, work->gameWork.colliders[0].hitPower, player->colliders[0].defPower))
        {
            Player__OnDefend_Regular(&work->gameWork.colliders[0], &player->colliders[0]);
        }
    }
}

void Spikes_Action_Extend(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.field_358);
    SetTaskState(&work->gameWork.objWork, Spikes_State_Extend);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_2;
    work->gameWork.objWork.userTimer = 24;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
}

void Spikes_State_Extend(Spikes *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        Spikes_Action_Retract(work);
}

void Spikes_Action_Retract(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.field_358);
    SetTaskState(&work->gameWork.objWork, Spikes_State_Retract);

    work->gameWork.objWork.userTimer = 0;
    work->gameWork.objWork.userWork  = 0;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_2;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;

    if (work->gameWork.field_358 == SPIKES_ANI_VERTICAL_EXTEND)
        work->gameWork.objWork.userWork = -3;
    else
        work->gameWork.objWork.userWork = 3;
}

void Spikes_State_Retract(Spikes *work)
{
    work->gameWork.objWork.userTimer++;

    work->gameWork.collisionObject.work.ofst_y += work->gameWork.objWork.userWork;
    if (work->gameWork.objWork.userTimer >= 8)
    {
        if (work->gameWork.field_358 == SPIKES_ANI_VERTICAL_RETRACT)
        {
            work->gameWork.field_358 = SPIKES_ANI_VERTICAL_HIDDEN;
        }
        else if (work->gameWork.field_358 == SPIKES_ANI_VERTICAL_EXTEND)
        {
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_2;
            work->gameWork.field_358 = SPIKES_ANI_VERTICAL_VISIBLE;
        }

        Spikes_Action_Idle(work);
    }
}

void Spikes2_State_Idle(Spikes *work)
{
    Player *player = (Player *)work->gameWork.collisionObject.work.riderObj;

    if (player == NULL)
        return;

    Spikes *spikes = (Spikes *)player->objWork.rideObj;

    if (spikes != work || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (ObjRect__FlagCheck(work->gameWork.colliders[0].hitFlag, player->colliders[0].defFlag, work->gameWork.colliders[0].hitPower, player->colliders[0].defPower))
    {
        Player__OnDefend_Regular(&work->gameWork.colliders[0], &player->colliders[0]);
    }
}
