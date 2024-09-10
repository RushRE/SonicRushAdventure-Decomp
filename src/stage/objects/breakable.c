#include <stage/objects/breakable.h>
#include <stage/effects/breakableObjDebris.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/graphics/screenShake.h>

// --------------------
// VARIABLES
// --------------------

static u16 brokeInstance;
static u16 activeCount;

// --------------------
// FUNCTIONS
// --------------------

Breakable *Breakable__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Breakable);
    if (task == HeapNull)
        return NULL;

    Breakable *work = TaskGetWork(task, Breakable);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_break_obj.bac", GetObjectDataWork(OBJDATAWORK_54), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, OBJ_DATA_GFX_AUTO, GetObjectSpriteRef(OBJDATAWORK_55));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 6);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_22);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, 1, 0);

    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Breakable__OnDefend);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.collisionObj           = 0;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;

    if (GetCurrentZoneID() == ZONE_HAUNTED_SHIP)
    {
        work->gameWork.collisionObject.work.width  = 32;
        work->gameWork.collisionObject.work.height = 32;
        work->gameWork.collisionObject.work.ofst_x = -16;
        work->gameWork.collisionObject.work.ofst_y = -16;
    }
    else if (gameState.stageID == STAGE_TUTORIAL || GetCurrentZoneID() == ZONE_HIDDEN_ISLAND)
    {
        work->gameWork.collisionObject.work.width  = 40;
        work->gameWork.collisionObject.work.height = 32;
        work->gameWork.collisionObject.work.ofst_x = -20;
        work->gameWork.collisionObject.work.ofst_y = -32;

        activeCount++;
        SetTaskDestructorEvent(task, Breakable__Destructor);
    }
    else
    {
        work->gameWork.collisionObject.work.width  = 48;
        work->gameWork.collisionObject.work.height = 32;
        work->gameWork.collisionObject.work.ofst_x = -24;
        work->gameWork.collisionObject.work.ofst_y = -16;
    }

    StageTask__SetAnimation(&work->gameWork.objWork, 0);

    if (gameState.stageID == STAGE_TUTORIAL)
        SetTaskState(&work->gameWork.objWork, Breakable__State_Tutorial);

    return work;
}

void Breakable__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Breakable *breakable = (Breakable *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (breakable == NULL || player == NULL)
        return;

    switch (player->objWork.objType)
    {
        case STAGE_OBJ_TYPE_EFFECT:
            player = (Player *)player->objWork.parentObj;

            if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            player->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
            breakable->gameWork.collisionObject.work.flag |= 0x100;
            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;
            break;

        default:
            if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            if (((player->objWork.moveFlag == STAGE_TASK_MOVE_FLAG_NONE) & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
                return;

            Player__Action_DestroyAttackRecoil(player);
            break;
    }

    ShakeScreen(SCREENSHAKE_C_SHORT);
    breakable->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    breakable->gameWork.flags |= 0x10000;
    breakable->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
    breakable->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
    breakable->gameWork.collisionObject.work.flag |= 0x100;

    fx32 x = breakable->gameWork.objWork.position.x;
    fx32 y = breakable->gameWork.objWork.position.y;
    EffectBreakableObjDebris__Create(x, y, FLOAT_TO_FX32(3.0), -FLOAT_TO_FX32(2.0), 0);
    EffectBreakableObjDebris__Create(x, y, -FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(2.5), 0);
    EffectBreakableObjDebris__Create(x, y, -FLOAT_TO_FX32(3.1875), -FLOAT_TO_FX32(2.875), 1);
    EffectBreakableObjDebris__Create(x, y, FLOAT_TO_FX32(2.25), -FLOAT_TO_FX32(3.125), 1);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEST_OBJ);

    if (gameState.stageID == STAGE_TUTORIAL)
        brokeInstance = TRUE;
}

void Breakable__Destructor(Task *task)
{
    if (activeCount != 0)
        activeCount--;

    if (activeCount == 0)
        brokeInstance = FALSE;

    GameObject__Destructor(task);
}

NONMATCH_FUNC void Breakable__State_Tutorial(Breakable *work)
{
    // https://decomp.me/scratch/7nK2A -> 89.72%
#ifdef NON_MATCHING
    if (brokeInstance)
    {
        ShakeScreen(SCREENSHAKE_C_SHORT);

        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROYED | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->gameWork.flags |= 0x10000;
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
        work->gameWork.collisionObject.work.flag |= 0x100;

        fx32 x = work->gameWork.objWork.position.x;
        fx32 y = work->gameWork.objWork.position.y;
        EffectBreakableObjDebris__Create(x, y, (mtMathRand() + FLOAT_TO_FX32(3.0)) & 0x7FF, (-FLOAT_TO_FX32(2.0) - mtMathRand()) & 0x7FF, 0);
        EffectBreakableObjDebris__Create(x, y, (-FLOAT_TO_FX32(2.0) - mtMathRand()) & 0x7FF, -FLOAT_TO_FX32(2.5), mtMathRand() & 1);
        EffectBreakableObjDebris__Create(x, y, -FLOAT_TO_FX32(3.1875), -FLOAT_TO_FX32(2.875), mtMathRand() & 1);
        EffectBreakableObjDebris__Create(x, y, FLOAT_TO_FX32(2.25), (-FLOAT_TO_FX32(3.125) - mtMathRand()) & 0x7FF, 1);

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEST_OBJ);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, =activeCount
	mov r5, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #3
	bl ShakeScreen
	ldr r0, [r5, #0x18]
	ldr r3, =_mt_math_rand
	orr r0, r0, #6
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x354]
	mov ip, #0
	orr r0, r0, #0x10000
	str r0, [r5, #0x354]
	ldr r1, [r5, #0x230]
	ldr r0, =0x00196225
	orr r1, r1, #0x800
	str r1, [r5, #0x230]
	ldr r2, [r5, #0x270]
	ldr r1, =0x3C6EF35F
	orr r2, r2, #0x800
	str r2, [r5, #0x270]
	ldr r4, [r5, #0x2f4]
	sub r2, ip, #0x2000
	orr r4, r4, #0x100
	str r4, [r5, #0x2f4]
	ldr lr, [r3]
	ldr r4, [r5, #0x44]
	mla r6, lr, r0, r1
	mla r0, r6, r0, r1
	ldr r5, [r5, #0x48]
	str r0, [r3]
	str ip, [sp]
	ldr r0, [r3]
	mov r3, r6, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r1, r1, lsr #0x10
	add lr, r1, #0x3000
	sub ip, r2, r0, lsr #16
	ldr r3, =0x000007FF
	mov r0, r4
	and r2, lr, r3
	mov r1, r5
	and r3, ip, r3
	bl EffectBreakableObjDebris__Create
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr ip, [r3]
	ldr r2, =0x3C6EF35F
	mov r0, r4
	mla lr, ip, r1, r2
	mla r1, lr, r1, r2
	str r1, [r3]
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	str r1, [sp]
	ldr r1, [r3]
	mov r3, #0x2000
	mov r1, r1, lsr #0x10
	rsb r3, r3, #0
	mov r1, r1, lsl #0x10
	sub r1, r3, r1, lsr #16
	and r2, r1, r3, lsr #21
	sub r3, r3, #0x800
	mov r1, r5
	bl EffectBreakableObjDebris__Create
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr ip, [r3]
	ldr r2, =0x3C6EF35F
	mov r0, r4
	mla r1, ip, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, #0x3300
	and r1, r1, #1
	rsb r2, r2, #0
	str r1, [sp]
	mov r1, r5
	add r3, r2, #0x500
	bl EffectBreakableObjDebris__Create
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr ip, [r3]
	ldr r1, =0x3C6EF35F
	mov lr, #1
	mla r0, ip, r0, r1
	str r0, [r3]
	str lr, [sp]
	ldr r0, [r3]
	mov r2, #0x2400
	mov r0, r0, lsr #0x10
	sub r1, r2, #0x5600
	mov r0, r0, lsl #0x10
	sub ip, r1, r0, lsr #16
	rsb r3, lr, #0x800
	mov r0, r4
	mov r1, r5
	and r3, ip, r3
	bl EffectBreakableObjDebris__Create
	mov r4, #0x43
	sub r1, r4, #0x44
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}
