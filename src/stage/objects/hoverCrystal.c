#include <stage/objects/hoverCrystal.h>
#include <stage/effects/hoverCrystalSparkle.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_left   mapObject->left
#define mapObjectParam_top    mapObject->top
#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// ENUMS
// --------------------

enum HoverCrystalAnimID
{
    HOVERCRYSTAL_ANI_CRYSTAL
};

// --------------------
// FUNCTION DECLS
// --------------------

static void HoverCrystal_State_Active(HoverCrystal *work);
static void HoverCrystal_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

HoverCrystal *CreateHoverCrystal(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), HoverCrystal);
    if (task == HeapNull)
        return NULL;

    HoverCrystal *work = TaskGetWork(task, HoverCrystal);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_air.bac", GetObjectFileWork(OBJDATAWORK_160), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, HOVERCRYSTAL_ANI_CRYSTAL, 97);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, HOVERCRYSTAL_ANI_CRYSTAL);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, mapObjectParam_left, mapObjectParam_top - 96, mapObjectParam_left + mapObjectParam_width,
                      mapObjectParam_top + mapObjectParam_height);
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], HoverCrystal_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y) != FALSE)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    SetTaskState(&work->gameWork.objWork, HoverCrystal_State_Active);

    return work;
}

NONMATCH_FUNC void HoverCrystal_State_Active(HoverCrystal *work)
{
    // https://decomp.me/scratch/TV9jq -> 73.29%
#ifdef NON_MATCHING
    if (work->gameWork.objWork.userTimer-- <= 0)
    {
        fx32 offsetX = work->gameWork.objWork.position.x - FLOAT_TO_FX32(16.0) + FX32_FROM_WHOLE(mtMathRandRepeat(48));

        fx32 y    = work->gameWork.objWork.position.y;
        fx32 posY = y + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_top);

        if ((work->gameWork.objWork.userWork & 1) != 0)
            y = work->gameWork.mapObjectParam_height;

        if ((work->gameWork.objWork.userWork & 1) != 0)
            posY += FX32_TO_WHOLE(y - 15);

        fx32 offsetY = posY + (u16)FX32_FROM_WHOLE(mtMathRand());

        EffectHoverCrystalSparkle__Create(offsetX, offsetY, (work->gameWork.objWork.position.x - offsetX) >> 10, (work->gameWork.objWork.position.y - offsetY) >> 10,
                                          (work->gameWork.objWork.position.x - offsetX) >> 10, (work->gameWork.objWork.position.y - offsetY) >> 10);

        work->gameWork.objWork.userTimer = mtMathRandRepeat(4) + 4;
        work->gameWork.objWork.userWork++;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #8
	str r0, [r4, #0x2c]
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r5, [r3, #0]
	ldr r1, =0x3C6EF35F
	mla r2, r5, r0, r1
	str r2, [r3]
	ldr ip, [r4, #0x340]
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	ldr r0, [r4, #0x28]
	ldrsb r1, [ip, #7]
	ldr r3, [r4, #0x48]
	tst r0, #1
	add r1, r3, r1, lsl #12
	ldrneb r3, [ip, #9]
	ldr ip, =0x3C6EF35F
	ldr r5, [r4, #0x44]
	subne r3, r3, #0xf
	addne r1, r1, r3, lsl #12
	ldr r3, =0x00196225
	sub r5, r5, #0x10000
	mla r3, r2, r3, ip
	and lr, lr, #0x2f
	add r0, r5, lr, lsl #12
	ldr lr, =_mt_math_rand
	mov r2, r3, lsr #0x10
	str r3, [lr]
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	mov ip, r3, lsl #0x1c
	ldr r2, [r4, #0x44]
	ldr r3, [r4, #0x48]
	sub r2, r2, r0
	add r1, r1, ip, lsr #16
	mov r2, r2, asr #0xa
	sub r3, r3, r1
	str r2, [sp]
	mov r3, r3, asr #0xa
	str r3, [sp, #4]
	bl EffectHoverCrystalSparkle__Create
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	str r1, [r2]
	add r0, r0, #4
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void HoverCrystal_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    HoverCrystal *hoverCrystal = (HoverCrystal *)rect2->parent;
    Player *player             = (Player *)rect1->parent;

    if (hoverCrystal == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    OBS_RECT playerRect;
    ObjRect__SetBox2D(&playerRect, -6, -16, 6, 16);
    playerRect.pos.x = FX32_TO_WHOLE(player->objWork.position.x);
    playerRect.pos.y = FX32_TO_WHOLE(player->objWork.position.y);
    playerRect.pos.z = FX32_TO_WHOLE(player->objWork.position.z);

    OBS_RECT crystalRect = rect2->rect;
    crystalRect.pos.x    = FX32_TO_WHOLE(hoverCrystal->gameWork.objWork.position.x);
    crystalRect.pos.y    = FX32_TO_WHOLE(hoverCrystal->gameWork.objWork.position.y);
    crystalRect.pos.z    = FX32_TO_WHOLE(hoverCrystal->gameWork.objWork.position.z);

    if (ObjRect__RectCheck(&playerRect, &crystalRect))
    {
        MapObject *mapObject = hoverCrystal->gameWork.mapObject;

        fx32 top = FX32_FROM_WHOLE(mapObjectParam_top);
        if ((hoverCrystal->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            top = -top;

        Player__Action_HoverCrystal(player, &hoverCrystal->gameWork, hoverCrystal->gameWork.objWork.position.x + FX32_FROM_WHOLE(mapObjectParam_left - 6),
                                    hoverCrystal->gameWork.objWork.position.y + top,
                                    hoverCrystal->gameWork.objWork.position.x + FX32_FROM_WHOLE(mapObjectParam_left + mapObjectParam_width + 6));
    }
}
