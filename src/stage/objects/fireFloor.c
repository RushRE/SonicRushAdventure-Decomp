#include <stage/objects/fireFloor.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum FireFloorAnimID
{
    FIREFLOOR_ANI_ACTIVE_V,
    FIREFLOOR_ANI_FLAREUP_V,
    FIREFLOOR_ANI_EMBER,
    FIREFLOOR_ANI_ACTIVE_H,
    FIREFLOOR_ANI_FLAREUP_H,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void FireFloor_State_Active(FireFloor *work);
static void FireFloor_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void FireFloor_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

FireFloor *CreateFireFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, FireFloor);
    if (task == HeapNull)
        return NULL;

    FireFloor *work = TaskGetWork(task, FireFloor);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_firefloor.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 83);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);

    if (mapObject->id == MAPOBJECT_224 || mapObject->id == MAPOBJECT_225)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_V);
        if (mapObject->id == MAPOBJECT_225)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
    }
    else
    {
        StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_H);
        if (mapObject->id == MAPOBJECT_226)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    ObjRect__SetOnAttack(&work->gameWork.colliders[1], FireFloor_OnHit);
    SetTaskState(&work->gameWork.objWork, FireFloor_State_Active);

    return work;
}

NONMATCH_FUNC void FireFloor_State_Active(FireFloor *work)
{
#ifdef NON_MATCHING
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_FLAREUP_V)
        {
            StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_V);
        }
        else if (work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_FLAREUP_H)
        {
            StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_H);
        }

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    BOOL checkRange = FALSE;
    BOOL flag       = FALSE;
    u16 id          = work->gameWork.mapObject->id;

    if (gPlayer->characterID == CHARACTER_BLAZE || (gPlayer->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        checkRange = TRUE;
    }
    else
    {
        checkRange = flag;
    }

    if (checkRange)
    {
        if (work->gameWork.objWork.position.x - FLOAT_TO_FX32(64.0) <= gPlayer->objWork.position.x
            && gPlayer->objWork.position.x <= work->gameWork.objWork.position.x + FLOAT_TO_FX32(64.0))
        {
            if (work->gameWork.objWork.position.y - FLOAT_TO_FX32(64.0) <= gPlayer->objWork.position.y
                && gPlayer->objWork.position.y <= work->gameWork.objWork.position.y + FLOAT_TO_FX32(64.0))
                flag = TRUE;
        }
    }

    fx32 *scale;
    if (id == MAPOBJECT_224 || id == MAPOBJECT_225)
        scale = &work->gameWork.objWork.scale.y;
    else
        scale = &work->gameWork.objWork.scale.x;

    if (flag && (work->gameWork.objWork.obj_2d->ani.work.animID == 0 || work->gameWork.objWork.obj_2d->ani.work.animID == 3))
    {
        if (*scale > FLOAT_TO_FX32(0.25))
        {
            *scale -= FLOAT_TO_FX32(0.125);
            if (*scale < FLOAT_TO_FX32(0.25))
                *scale = FLOAT_TO_FX32(0.25);
        }

        ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[1], FireFloor_OnDefend);
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;
    }
    else
    {
        if (*scale < FLOAT_TO_FX32(1.0))
        {
            *scale += FLOAT_TO_FX32(0.125);
            if (*scale > FLOAT_TO_FX32(1.0))
                *scale = FLOAT_TO_FX32(1.0);
        }
        work->gameWork.colliders[1].hitFlag  = 2;
        work->gameWork.colliders[1].hitPower = 0x40;
        work->gameWork.colliders[1].defFlag  = -1;
        work->gameWork.colliders[1].defPower = 0xFF;
        ObjRect__SetOnDefend(&work->gameWork.colliders[1], FireFloor_OnHit);
        work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_400;
    }

    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.colliders[1].flag &= ~(OBS_RECT_WORK_FLAG_40000 | OBS_RECT_WORK_FLAG_200 | OBS_RECT_WORK_FLAG_100);
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	beq _02182498
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #1
	bne _0218247C
	mov r1, #0
	bl StageTask__SetAnimation
	b _0218248C
_0218247C:
	cmp r1, #4
	bne _0218248C
	mov r1, #3
	bl StageTask__SetAnimation
_0218248C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02182498:
	ldr r0, =gPlayer
	ldr r1, [r4, #0x340]
	ldr lr, [r0]
	ldrh r1, [r1, #2]
	ldrb r2, [lr, #0x5d0]
	mov r0, #0
	cmp r2, #1
	beq _021824C4
	ldr r2, [lr, #0x5d8]
	tst r2, #0x80
	beq _021824CC
_021824C4:
	mov r2, #1
	b _021824D0
_021824CC:
	mov r2, r0
_021824D0:
	cmp r2, #0
	beq _02182510
	ldr ip, [r4, #0x44]
	ldr r3, [lr, #0x44]
	sub r2, ip, #0x40000
	cmp r2, r3
	addle r2, ip, #0x40000
	cmple r3, r2
	bgt _02182510
	ldr ip, [r4, #0x48]
	ldr r3, [lr, #0x48]
	sub r2, ip, #0x40000
	cmp r2, r3
	addle r2, ip, #0x40000
	cmple r3, r2
	movle r0, #1
_02182510:
	add r1, r1, #0xf20
	add r1, r1, #0xf000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	addls r1, r4, #0x3c
	addhi r1, r4, #0x38
	cmp r0, #0
	beq _021825A0
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	cmpne r0, #3
	bne _021825A0
	ldr r0, [r1]
	cmp r0, #0x400
	ble _02182568
	sub r0, r0, #0x200
	str r0, [r1]
	cmp r0, #0x400
	movlt r0, #0x400
	strlt r0, [r1]
_02182568:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =FireFloor_OnDefend
	str r0, [r4, #0x27c]
	ldr r0, [r4, #0x270]
	orr r0, r0, #0x400
	str r0, [r4, #0x270]
	b _021825F8
_021825A0:
	ldr r0, [r1]
	cmp r0, #0x1000
	bge _021825C0
	add r0, r0, #0x200
	str r0, [r1]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r1]
_021825C0:
	add r0, r4, #0x200
	mov r1, #2
	strh r1, [r0, #0x88]
	mov r2, #0x40
	ldr r1, =0x0000FFFF
	strh r2, [r0, #0x84]
	strh r1, [r0, #0x8a]
	mov r2, #0xff
	ldr r1, =FireFloor_OnHit
	strh r2, [r0, #0x86]
	str r1, [r4, #0x27c]
	ldr r0, [r4, #0x270]
	bic r0, r0, #0x400
	str r0, [r4, #0x270]
_021825F8:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x270]
	ldr r0, =0xFFFBFCFF
	and r0, r1, r0
	str r0, [r4, #0x270]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void FireFloor_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FireFloor *fireFloor = (FireFloor *)rect1->parent;
    Player *player       = (Player *)rect2->parent;

    if (fireFloor == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (fireFloor->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_V)
    {
        StageTask__SetAnimation(&fireFloor->gameWork.objWork, FIREFLOOR_ANI_FLAREUP_V);
    }
    else if (fireFloor->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_H)
    {
        StageTask__SetAnimation(&fireFloor->gameWork.objWork, FIREFLOOR_ANI_FLAREUP_H);
    }
}

void FireFloor_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FireFloor *fireFloor = (FireFloor *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (fireFloor == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (player->objWork.move.x == 0 && player->objWork.move.y == 0)
        ObjRect__FuncNoHit(rect1, rect2);
    else
        fireFloor->gameWork.objWork.userTimer = 5;
}
