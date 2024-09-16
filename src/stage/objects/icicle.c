#include <stage/objects/icicle.h>
#include <stage/effects/iceSparkles.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_size mapObject->left

// --------------------
// ENUMS
// --------------------

enum IcicleAnimID
{
    ICICLE_ANI_ICICLE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Icicle_State_Active(Icicle *work);
static void Icicle_Draw(void);
static void Icicle_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

Icicle *CreateIcicle(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Icicle);
    if (task == HeapNull)
        return NULL;

    Icicle *work = TaskGetWork(task, Icicle);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_icicle.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 64, GetObjectSpriteRef(OBJDATAWORK_160));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, ICICLE_ANI_ICICLE, 35);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjObjectAction3dBACLoad(&work->gameWork.objWork, &work->animator, "/act/ac_gmk_icicle3d.bac", OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_162),
                             gameArchiveStage);
    ObjObjectActionAllocTexture(&work->gameWork.objWork, 4096, 16, GetObjectTextureRef(OBJDATAWORK_163));

    if ((GetObjectTextureRef(OBJDATAWORK_163)->texture.referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) <= 1)
    {
        work->animator.ani.animatorSprite.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
        AnimatorSprite3D__ProcessAnimation(&work->animator.ani, work->gameWork.objWork.ppSpriteCallback, work);
        work->animator.ani.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    }

    StageTask__SetAnimation(&work->gameWork.objWork, ICICLE_ANI_ICICLE);
    s32 size = MTM_MATH_CLIP(mapObjectParam_size, 0, 3);

    if (size != 0)
        work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    work->gameWork.objWork.scale.y  = (size << 11) + FLOAT_TO_FX32(1.0);
    work->gameWork.objWork.userFlag = FX_Div(4096, FX32_FROM_WHOLE((work->gameWork.mapObjectParam_size << 7) + 256));

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET;
    ObjRect__SetBox3D(&work->gameWork.colliders[0].rect, -32, -240, -32, 32, size << 7, 32);
    work->gameWork.colliders[0].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[0].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
    work->gameWork.colliders[0].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Icicle_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    SetTaskOutFunc(&work->gameWork.objWork, Icicle_Draw);
    SetTaskState(&work->gameWork.objWork, Icicle_State_Active);

    return work;
}

NONMATCH_FUNC void Icicle_State_Active(Icicle *work)
{
    // https://decomp.me/scratch/fEA0p -> 70.66%
#ifdef NON_MATCHING
    Player *player = (Player *)work->gameWork.parent;
    if (player != NULL)
    {
        if (!CheckPlayerGimmickObj(player, work))
        {
            work->gameWork.parent            = NULL;
            work->gameWork.objWork.userTimer = 60;
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

    if (work->gameWork.objWork.userWork == 0)
    {
        fx32 width   = (work->gameWork.mapObjectParam_size << 7) + 256;
        fx32 offsetY = (width - 1) & mtMathRand();

        fx32 offsetX = MultiplyFX(22 * (FX32_FROM_WHOLE(width) - FX32_FROM_WHOLE(offsetY)), work->gameWork.objWork.userFlag);
        if ((mtMathRand() & 1) != 0)
            offsetX = -offsetX;

        EffectIceSparkles__Create(work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y + FX32_FROM_WHOLE(offsetY) - FLOAT_TO_FX32(256.0), 0, 0, 0);

        work->gameWork.objWork.userWork = (mtMathRand() & 0xF) + 8;
    }
    work->gameWork.objWork.userWork--;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02168F74
	ldr r0, [r0, #0x6d8]
	cmp r0, r4
	beq _02168F94
	mov r0, #0
	str r0, [r4, #0x35c]
	mov r0, #0x3c
	str r0, [r4, #0x2c]
	b _02168F94
_02168F74:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _02168F94
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldreq r0, [r4, #0x18]
	biceq r0, r0, #2
	streq r0, [r4, #0x18]
_02168F94:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _02169070
	ldr r3, =_mt_math_rand
	ldr r5, [r4, #0x340]
	ldr r0, [r3]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	ldrsb r5, [r5, #6]
	mla lr, r0, r1, r2
	mov r0, r5, lsl #7
	add ip, r0, #0x100
	mov r0, lr, lsr #0x10
	sub r5, ip, #1
	mov r0, r0, lsl #0x10
	and r0, r5, r0, lsr #16
	mov r5, ip, lsl #0xc
	mla ip, lr, r1, r2
	mov r1, ip, lsr #0x10
	mov r2, r1, lsl #0x10
	str lr, [r3]
	ldr lr, [r4, #0x24]
	sub r5, r5, r0, lsl #12
	mov r1, #0x16
	mul r1, r5, r1
	smull lr, r5, r1, lr
	adds r1, lr, #0x800
	mov lr, r1, lsr #0xc
	mov r1, r2, lsr #0x10
	adc r5, r5, #0
	str ip, [r3]
	mov r2, #0
	str r2, [sp]
	tst r1, #1
	ldr r1, [r4, #0x48]
	orr lr, lr, r5, lsl #20
	add r1, r1, r0, lsl #12
	ldr ip, [r4, #0x44]
	rsbne lr, lr, #0
	mov r3, r2
	add r0, ip, lr
	sub r1, r1, #0x100000
	bl EffectIceSparkles__Create
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	str r1, [r2]
	add r0, r0, #8
	str r0, [r4, #0x28]
_02169070:
	ldr r0, [r4, #0x28]
	sub r0, r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Icicle_Draw(void)
{
    Icicle *work = TaskGetWorkCurrent(Icicle);

    work->gameWork.objWork.offset.y = -FLOAT_TO_FX32(256.0);
    StageTask__Draw3D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2dIn3d->ani.work);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    StageTask__Draw3D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2dIn3d->ani.work);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
}

void Icicle_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Icicle *icicle = (Icicle *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (icicle == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    s32 width    = (icicle->gameWork.mapObjectParam_size << 7) + 256;
    fx32 width32 = FX32_FROM_WHOLE(width);
    fx32 icicleY = icicle->gameWork.objWork.position.y - FLOAT_TO_FX32(256.0);

    fx32 size;
    if (player->objWork.position.y > icicleY)
        size = FX_Div(68 * (width32 - (player->objWork.position.y - icicleY)), FX32_FROM_WHOLE(width));
    else
        size = FLOAT_TO_FX32(68.0);

    fx32 radius = size >> 1;
    if (MATH_ABS(player->objWork.position.x - icicle->gameWork.objWork.position.x) > radius + FLOAT_TO_FX32(6.0))
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        icicle->gameWork.parent = &player->objWork;
        icicle->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        Player__Action_IcicleGrab(player, &icicle->gameWork, width32);
    }
}
