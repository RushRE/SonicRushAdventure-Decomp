#include <stage/objects/iceBlock.h>
#include <stage/effects/iceBlockDebris.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum IceBlockObjectFlags
{
    ICEBLOCK_OBJFLAG_NONE,

    ICEBLOCK_OBJFLAG_REMOVE_IN_VS_BATTLE = 1 << 0,
};

enum IceBlockAnimID
{
	ICEBLOCK_ANI_BLOCK,
	ICEBLOCK_ANI_DEBRIS_1,
	ICEBLOCK_ANI_DEBRIS_2,
	ICEBLOCK_ANI_DEBRIS_3,
	ICEBLOCK_ANI_DEBRIS_4,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void IceBlock_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

IceBlock *CreateIceBlock(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) && (mapObject->flags & ICEBLOCK_OBJFLAG_REMOVE_IN_VS_BATTLE) != 0)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, IceBlock);
    if (task == HeapNull)
        return NULL;

    IceBlock *work = TaskGetWork(task, IceBlock);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_ice_block.bac", GetObjectFileWork(OBJDATAWORK_175), gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetObjectSpriteRef(OBJDATAWORK_176));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, ICEBLOCK_ANI_BLOCK, 35);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_22);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, ICEBLOCK_ANI_BLOCK);

    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~2, 0);
    work->gameWork.colliders[0].onDefend = IceBlock_OnDefend;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 32;
    work->gameWork.collisionObject.work.height    = 32;
    work->gameWork.collisionObject.work.ofst_x    = -16;
    work->gameWork.collisionObject.work.ofst_y    = -32;

    return work;
}

NONMATCH_FUNC void IceBlock_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/qAxGt -> 96.90%
#ifdef NON_MATCHING
    IceBlock *iceBlock = (IceBlock *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (iceBlock == NULL || player == NULL)
        return;

    switch (player->objWork.objType)
    {
        case STAGE_OBJ_TYPE_EFFECT:
            player = (Player *)player->objWork.parentObj;

            if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

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

    iceBlock->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_2;
    iceBlock->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
    iceBlock->gameWork.collisionObject.work.flag |= 0x100;

    fx32 x = iceBlock->gameWork.objWork.position.x;
    fx32 y = iceBlock->gameWork.objWork.position.y;
    EffectIceBlockDebris__Create(0, x, y, -FLOAT_TO_FX32(3.1875), -FLOAT_TO_FX32(2.875));
    EffectIceBlockDebris__Create(1, x, y, -FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(2.5));
    EffectIceBlockDebris__Create(2, x, y, FLOAT_TO_FX32(3.0), -FLOAT_TO_FX32(2.0));
    EffectIceBlockDebris__Create(3, x, y, FLOAT_TO_FX32(2.25), -FLOAT_TO_FX32(3.125));

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ICE_BLOCK);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r0]
	cmp r1, #5
	bne _0216AEB0
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r1, #0x1c]
	bic r0, r0, #4
	str r0, [r1, #0x1c]
	b _0216AEDC
_0216AEB0:
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	moveq r1, #1
	movne r1, #0
	tst r1, #0x10
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	bl Player__Action_DestroyAttackRecoil
_0216AEDC:
	ldr r0, [r4, #0x18]
	mov ip, #0x2e00
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x230]
	mov r0, #0
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x2f4]
	rsb ip, ip, #0
	orr r1, r1, #0x100
	str r1, [r4, #0x2f4]
	ldr r5, [r4, #0x44]
	ldr r6, [r4, #0x48]
	mov r1, r5
	mov r2, r6
	sub r3, r0, #0x3300
	str ip, [sp]
	bl EffectIceBlockDebris__Create
	mov r4, #0x2800
	rsb r4, r4, #0
	mov r1, r5
	mov r2, r6
	add r3, r4, #0x800
	mov r0, #1
	str r4, [sp]
	bl EffectIceBlockDebris__Create
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [sp]
	mov r1, r5
	mov r0, #2
	mov r2, r6
	mov r3, #0x3000
	bl EffectIceBlockDebris__Create
	mov r0, #0x3200
	rsb r0, r0, #0
	str r0, [sp]
	mov r1, r5
	mov r2, r6
	mov r0, #3
	mov r3, #0x2400
	bl EffectIceBlockDebris__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x54
	str r1, [sp, #4]
	sub r1, r1, #0x55
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}
