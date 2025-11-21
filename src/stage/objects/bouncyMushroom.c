#include <stage/objects/bouncyMushroom.h>
#include <stage/effects/bouncyMushroomPuff.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum BouncyMushroomObjectFlags
{
    BOUNCYMUSHROOM_OBJFLAG_NONE,

    BOUNCYMUSHROOM_OBJFLAG_ALT_PALETTE = 1 << 0,
};

enum BouncyMushroomTypes
{
    BOUNCYMUSHROOM_TYPE_U,  // straight upwards
    BOUNCYMUSHROOM_TYPE_UL, // up-left
    BOUNCYMUSHROOM_TYPE_UR, // up-right

    BOUNCYMUSHROOM_TYPE_COUNT,
};

// --------------------
// STRUCTS
// --------------------

struct BouncyMushroomUnknown
{
    fx32 x;
    fx32 y;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    u16 field_20;
    u16 field_22;
};

// --------------------
// VARIABLES
// --------------------

static const Vec2Fx16 collisionOffsetTable[BOUNCYMUSHROOM_TYPE_COUNT] = {
    [BOUNCYMUSHROOM_TYPE_U]  = { -96, -14 },
    [BOUNCYMUSHROOM_TYPE_UL] = { -78, -80 },
    [BOUNCYMUSHROOM_TYPE_UR] = { -72, -80 },
};

static const Vec2U16 collisionSizeTable[BOUNCYMUSHROOM_TYPE_COUNT] = {
    [BOUNCYMUSHROOM_TYPE_U]  = { 192, 24 },
    [BOUNCYMUSHROOM_TYPE_UL] = { 152, 152 },
    [BOUNCYMUSHROOM_TYPE_UR] = { 152, 152 },
};

static const HitboxRect hitboxTable[BOUNCYMUSHROOM_TYPE_COUNT][4] ={
	[BOUNCYMUSHROOM_TYPE_U] = {
		{ -108, -24, 108, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
		{ 0, 0, 0, 0 },
	},

	[BOUNCYMUSHROOM_TYPE_UL] = {
		{ -84, 18, -50, 52 },
		{ -50, -16, -16, 18 },
		{ -16, -50, 18, -16 },
		{ 18, -84, 52, -50 },
	},

	[BOUNCYMUSHROOM_TYPE_UR] = {
		{ -52, -84, -18, -50 },
		{ -18, -50, 16, -16 },
		{ 16, -16, 50, 18 },
		{ 50, 18, 84, 52 },
	},
};

static const struct BouncyMushroomUnknown puffParticleConfig[BOUNCYMUSHROOM_TYPE_COUNT] =
{
	[BOUNCYMUSHROOM_TYPE_U] = {
    	.x = -0x54000,
    	.y = -0x20000,
    	.field_8 = 0x2A000,
    	.field_C = 0x00,
    	.field_10 = -0x1200,
    	.field_14 = 0x3000,
    	.field_18 = 0x600,
    	.field_1C = 0x00,
    	.field_20 = 0x1F,
    	.field_22 = 0x1F,
	},
	
	[BOUNCYMUSHROOM_TYPE_UL] = {
    	.x = -0x4B000,
    	.y = 0x2B000,
    	.field_8 = 0x1F800,
    	.field_C = -0x1F800,
    	.field_10 = -0xC9F,
    	.field_14 = 0x2200,
    	.field_18 = 0x435,
    	.field_1C = 0x00,
    	.field_20 = 0xF,
    	.field_22 = 0xF,
	},
	
	[BOUNCYMUSHROOM_TYPE_UR] = {
    	.x = 0x4B000,
    	.y = 0x2B000,
    	.field_8 = -0x1F800,
    	.field_C = -0x1F800,
    	.field_10 = 0xC9F,
    	.field_14 = 0x2200,
    	.field_18 = -0x435,
    	.field_1C = 0x00,
    	.field_20 = 0xF,
    	.field_22 = 0xF,
	},
};

// manually re-order strings to match
#ifndef NON_MATCHING
static const char *_MATCHING_FIX_00 = "/df/gmk_flipmush_u.df";
static const char *_MATCHING_FIX_02 = "/df/gmk_flipmush_ur.df";
static const char *_MATCHING_FIX_01 = "/df/gmk_flipmush_ul.df";
#endif

static const char *bounceMushCollisionList[BOUNCYMUSHROOM_TYPE_COUNT] = {
    [BOUNCYMUSHROOM_TYPE_U]  = "/df/gmk_flipmush_u.df",
    [BOUNCYMUSHROOM_TYPE_UL] = "/df/gmk_flipmush_ul.df",
    [BOUNCYMUSHROOM_TYPE_UR] = "/df/gmk_flipmush_ur.df",
};

// --------------------
// FUNCTION DECLS
// --------------------

static void BouncyMushroom_State_Idle(BouncyMushroom *work);
static void BouncyMushroom_Action_Bounce(BouncyMushroom *work);
static void BouncyMushroom_State_Used(BouncyMushroom *work);
static void BouncyMushroom_Draw(void);
static void BouncyMushroom_Collide(void);
static void BouncyMushroom_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

BouncyMushroom *CreateBouncyMushroom(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    s32 i;
    AnimatorFlags aniFlags;
    u16 displayFlag;

    u32 mushroomType = mapObject->id - MAPOBJECT_81;

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), BouncyMushroom);
    if (task == HeapNull)
        return NULL;

    BouncyMushroom *work = TaskGetWork(task, BouncyMushroom);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    switch (mapObject->id)
    {
        case MAPOBJECT_81:
            displayFlag = DISPLAY_FLAG_DISABLE_ROTATION;
            aniFlags    = ANIMATOR_FLAG_NONE;

            work->colliderCount = 1;
            break;

        default:
            aniFlags    = ANIMATOR_FLAG_ENABLE_SCALE;
            displayFlag = DISPLAY_FLAG_NONE;

            work->colliderCount = 4;

            if (mapObject->id == MAPOBJECT_82)
                work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(315.0);
            else
                work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(45.0);
            break;
    }

    ObjObjectCollisionDifSet(&work->gameWork.objWork, bounceMushCollisionList[mushroomType], GetObjectDataWork(mushroomType + OBJDATAWORK_173), gameArchiveStage);
    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.width  = collisionSizeTable[mushroomType].x;
    work->gameWork.collisionObject.work.height = collisionSizeTable[mushroomType].y;
    work->gameWork.collisionObject.work.ofst_x = collisionOffsetTable[mushroomType].x;
    work->gameWork.collisionObject.work.ofst_y = collisionOffsetTable[mushroomType].y;
    work->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_IGNORE_PARENT_ANGLE;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_flipmush.bac", GetObjectDataWork(OBJDATAWORK_166), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 48, GetObjectSpriteRef(OBJDATAWORK_167));
    StageTask__SetAnimation(&work->gameWork.objWork, BOUNCYMUSHROOM_ANI_MUSHROOM);
    work->gameWork.animator.ani.work.flags |= aniFlags;
    if ((mapObject->flags & BOUNCYMUSHROOM_OBJFLAG_ALT_PALETTE) != 0)
        ObjActionAllocSpritePalette(&work->gameWork.objWork, BOUNCYMUSHROOM_ANI_ALT_PALETTE, 29);
    else
        ObjActionAllocSpritePalette(&work->gameWork.objWork, BOUNCYMUSHROOM_ANI_MUSHROOM, 14);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    for (i = 0; i < work->colliderCount; i++)
    {
        ObjRect__SetAttackStat(&work->colliders[i], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->colliders[i], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
        ObjRect__SetBox2D(&work->colliders[i].rect, hitboxTable[mushroomType][i].left, hitboxTable[mushroomType][i].top, hitboxTable[mushroomType][i].right,
                          hitboxTable[mushroomType][i].bottom);
        ObjRect__SetGroupFlags(&work->colliders[i], 2, 1);
        work->colliders[i].parent = &work->gameWork.objWork;
        ObjRect__SetOnDefend(&work->colliders[i], BouncyMushroom_OnDefend);
        work->colliders[i].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= displayFlag | DISPLAY_FLAG_PAUSED;

    SetTaskState(&work->gameWork.objWork, BouncyMushroom_State_Idle);
    SetTaskOutFunc(&work->gameWork.objWork, BouncyMushroom_Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, BouncyMushroom_Collide);

    return work;
}

void BouncyMushroom_State_Idle(BouncyMushroom *work)
{
    // Do nothing
}

void BouncyMushroom_Action_Bounce(BouncyMushroom *work)
{
    SetTaskState(&work->gameWork.objWork, BouncyMushroom_State_Used);

    work->percent      = FLOAT_TO_FX32(0.0);
    work->lerpSpeed    = FLOAT_TO_FX32(0.2);
    work->targetOffset = FLOAT_TO_FX32(16.0);
}

void BouncyMushroom_State_Used(BouncyMushroom *work)
{
    work->percent += work->lerpSpeed;

    if (work->lerpSpeed >= FLOAT_TO_FX32(0.0))
    {
        if (work->percent >= FLOAT_TO_FX32(1.0))
        {
            work->percent   = FLOAT_TO_FX32(1.0);
            work->lerpSpeed = -work->lerpSpeed;
        }
    }
    else
    {
        if (work->percent <= 0)
        {
            work->percent   = FLOAT_TO_FX32(0.0);
            work->lerpSpeed = -work->lerpSpeed;
            work->targetOffset >>= 1;
            if (work->targetOffset < FLOAT_TO_FX32(1.0))
            {
                SetTaskState(&work->gameWork.objWork, BouncyMushroom_State_Idle);
                work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
                return;
            }
        }
    }

    fx32 offset = mtLerp(work->percent, FLOAT_TO_FX32(0.0), work->targetOffset);

    work->gameWork.objWork.offset.y = offset;

    if (work->gameWork.mapObject->id == MAPOBJECT_82)
    {
        work->gameWork.objWork.offset.x = offset;
    }
    else if (work->gameWork.mapObject->id == MAPOBJECT_83)
    {
        work->gameWork.objWork.offset.x = -offset;
    }
}

void BouncyMushroom_Draw(void)
{
    BouncyMushroom *work = TaskGetWorkCurrent(BouncyMushroom);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);
}

void BouncyMushroom_Collide(void)
{
    BouncyMushroom *work = TaskGetWorkCurrent(BouncyMushroom);

    OBS_RECT_WORK *colliderList = work->colliders;
    if (!IsStageTaskDestroyedAny(&work->gameWork.objWork) && (g_obj.flag & OBJECTMANAGER_FLAG_ALLOW_RECT_COLLISIONS) != 0)
    {
        if (work->gameWork.collisionObject.work.parent && !StageTask__ViewOutCheck(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, 32, 0, 0, 0, 0))
        {
            ObjCollisionObjectRegist(&work->gameWork.collisionObject.work);
        }

        if ((work->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
        {
            for (s32 i = 0; i < work->colliderCount; i++)
            {
                ObjRect__Register(&colliderList[i]);
            }
        }
    }
}

NONMATCH_FUNC void BouncyMushroom_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/pWlO7 -> 73.70%
#ifdef NON_MATCHING
    BouncyMushroom *mushroom = (BouncyMushroom *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (mushroom == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    mushroom->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    BouncyMushroom_Action_Bounce(mushroom);

    MapObject *mapObject = mushroom->gameWork.mapObject;
    fx32 bounceX         = FLOAT_TO_FX32(5.5);
    switch (mapObject->id)
    {
        case MAPOBJECT_81:
            bounceX = FLOAT_TO_FX32(0.0);
            break;

        case MAPOBJECT_82:
            bounceX = -FLOAT_TO_FX32(5.5);
            break;
    }
    Player__Action_MushroomBounce(player, bounceX, -FLOAT_TO_FX32(5.5), mapObject->left);
    Player__Action_AllowTrickCombos(player, &mushroom->gameWork);

    u32 type = mapObject->id - MAPOBJECT_81;

    fx32 spawnX   = mushroom->gameWork.objWork.position.x + puffParticleConfig[type].x;
    fx32 spawnY   = mushroom->gameWork.objWork.position.y + puffParticleConfig[type].y;
    fx32 velX     = puffParticleConfig[type].field_10;
    fx32 velY     = puffParticleConfig[type].field_14;
    fx32 field_20 = puffParticleConfig[type].field_20;
    fx32 field_22 = puffParticleConfig[type].field_22;

    for (s32 i = 0; i < 5; i++)
    {
        u16 rand = mtMathRand();
        EffectBouncyMushroomPuff__Create(spawnX + FX32_FROM_WHOLE((field_20 & rand) - (field_20 >> 1)), spawnY + FX32_FROM_WHOLE((field_22 & rand) - (field_22 >> 1)), velX, velY);

        spawnX += puffParticleConfig[type].field_8;
        velX += puffParticleConfig[type].field_18;
        spawnY += puffParticleConfig[type].field_C;
        velY += puffParticleConfig[type].field_1C;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r6, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r6, #0
	cmpne r4, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r4, #0]
	cmp r0, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r6, #0x18]
	ldr r5, [r6, #0x340]
	orr r1, r0, #2
	mov r0, r6
	str r1, [r6, #0x18]
	bl BouncyMushroom_Action_Bounce
	ldrh r0, [r5, #2]
	mov r1, #0x5800
	cmp r0, #0x51
	beq _021633C0
	cmp r0, #0x52
	subeq r1, r1, #0xb000
	b _021633C4
_021633C0:
	mov r1, #0
_021633C4:
	ldrsb r3, [r5, #6]
	mov r2, #0x5800
	mov r0, r4
	rsb r2, r2, #0
	bl Player__Action_MushroomBounce
	mov r0, r4
	mov r1, r6
	bl Player__Action_AllowTrickCombos
	ldr r1, [r6, #0x340]
	mov r0, #0x24
	ldrh r3, [r1, #2]
	ldr r2, =puffParticleConfig
	ldr r1, =puffParticleConfig+4
	sub r3, r3, #0x51
	mul r5, r3, r0
	ldr r7, =puffParticleConfig+0x20
	ldr r8, =puffParticleConfig+0x22
	ldr r11, =puffParticleConfig+0x10
	ldrh r9, [r7, r5]
	ldr r10, =puffParticleConfig+0x14
	add r0, r2, r5
	ldr r3, [r2, r5]
	ldr r7, [r11, r5]
	ldr r4, [r6, #0x44]
	ldr r2, [r6, #0x48]
	ldrh r6, [r8, r5]
	ldr r8, [r10, r5]
	ldr r1, [r1, r5]
	ldr r5, [r0, #8]
	str r6, [sp, #8]
	str r5, [sp, #4]
	ldr r5, [r0, #0xc]
	ldr r11, [r0, #0x18]
	str r5, [sp]
	add r5, r4, r3
	ldr r10, [r0, #0x1c]
	add r6, r2, r1
	mov r4, #0
_0216345C:
	ldr r0, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r3, [r0, #0]
	ldr r0, =0x3C6EF35F
	ldr ip, =0x00196225
	mla r1, r3, r1, r0
	ldr r3, =0x3C6EF35F
	mov r0, r1, lsr #0x10
	mla r3, r1, ip, r3
	ldr r1, [sp, #8]
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	sub r0, r0, r9, asr #1
	add r1, r6, r0, lsl #12
	ldr r0, =_mt_math_rand
	mov r2, r7
	str r3, [r0]
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r9, r0, lsr #16
	sub r0, r0, r9, asr #1
	add r0, r5, r0, lsl #12
	mov r3, r8
	bl EffectBouncyMushroomPuff__Create
	ldr r0, [sp, #4]
	add r4, r4, #1
	add r5, r5, r0
	ldr r0, [sp]
	add r7, r7, r11
	add r6, r6, r0
	add r8, r8, r10
	cmp r4, #5
	blt _0216345C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
