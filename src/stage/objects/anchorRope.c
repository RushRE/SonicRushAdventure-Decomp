#include <stage/objects/anchorRope.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <game/math/akMath.h>

// --------------------
// ENUMS
// --------------------

enum AnchorRopeAnimatorID
{
    ANCHORROPE_ANIMATOR_ANCHOR,
    ANCHORROPE_ANIMATOR_ROPE,

    ANCHORROPE_ANIMATOR_COUNT,
};

enum AnchorRopeFlags
{
    ANCHORROPE_FLAG_NONE,

    ANCHORROPE_FLAG_FLIPPED = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static u16 modelIdxTable[ANCHORROPE_ANIMATOR_COUNT]    = { [ANCHORROPE_ANIMATOR_ANCHOR] = 0, [ANCHORROPE_ANIMATOR_ROPE] = 2 };
static u16 spriteSizeTable[ANCHORROPE_ANIMATOR_COUNT]  = { [ANCHORROPE_ANIMATOR_ANCHOR] = 28, [ANCHORROPE_ANIMATOR_ROPE] = 16 };
static u16 paletteFlagTable[ANCHORROPE_ANIMATOR_COUNT] = { [ANCHORROPE_ANIMATOR_ANCHOR] = 0, [ANCHORROPE_ANIMATOR_ROPE] = 72 };

// --------------------
// FUNCTION DECLS
// --------------------

static void AnchorRope_Destructor(Task *task);
static void AnchorRope_State_PlayerSpin(AnchorRope *work);
static void AnchorRope_State_ReleasedPlayer(AnchorRope *work);
static void AnchorRope_Draw(void);
static void AnchorRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void AnchorRope_HandleRopePos(AnchorRope *work);

// --------------------
// FUNCTIONS
// --------------------

AnchorRope *CreateAnchorRope(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(AnchorRope_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), AnchorRope);
    if (task == HeapNull)
        return NULL;

    AnchorRope *work = TaskGetWork(task, AnchorRope);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_DISABLE_ROTATION;

    work->resAnchorRope = ObjDataLoad(GetObjectDataWork(OBJDATAWORK_159), "/mod/gmk_anchor_rope.nsbmd", gameArchiveStage);

    for (s32 i = 0; i < ANCHORROPE_ANIMATOR_COUNT; i++)
    {
		// Init 3D graphics, these are the main graphics the devs want you to see
        AnimatorMDL *aniRope3D = &work->aniRope3D[i];
        AnimatorMDL__Init(aniRope3D, ANIMATOR_FLAG_NONE);
        AnimatorMDL__SetResource(aniRope3D, work->resAnchorRope, modelIdxTable[i], FALSE, FALSE);
        aniRope3D->work.scale.x = FLOAT_TO_FX32(3.3);
        aniRope3D->work.scale.y = FLOAT_TO_FX32(3.3);
        aniRope3D->work.scale.z = FLOAT_TO_FX32(3.3);

		// Init 2D graphics, these are fallback graphics in the event this gets rendered on the screen without 3D support
        AnimatorSpriteDS *aniRope2D = &work->aniRope2D[i];
        ObjAction2dBACLoad(aniRope2D, "/act/ac_gmk_anchor_rope.bac", spriteSizeTable[i], GetObjectDataWork(OBJDATAWORK_160), gameArchiveStage);
        aniRope2D->work.cParam.palette = ObjDrawAllocSpritePalette(GetObjectDataWork(OBJDATAWORK_160)->fileData, i, paletteFlagTable[i]);
        aniRope2D->cParam[0].palette = aniRope2D->cParam[1].palette = aniRope2D->work.cParam.palette;
        aniRope2D->flags |= ANIMATORSPRITEDS_FLAG_DISABLE_A;
        AnimatorSpriteDS__SetAnimation(aniRope2D, i);
        StageTask__SetOAMOrder(&aniRope2D->work, SPRITE_ORDER_23);
        StageTask__SetOAMPriority(&aniRope2D->work, SPRITE_PRIORITY_2);
    }

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], AnchorRope_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    if (mapObject->id == MAPOBJECT_197)
    {
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -192, 32, -152, 72);

        work->anchorAngle.x = -FLOAT_DEG_TO_IDX(45.0);
        work->anchorAngle.y = -FLOAT_DEG_TO_IDX(90.0);

        work->ropeAngle.x = FLOAT_DEG_TO_IDX(11.25);
        work->ropeAngle.y = -FLOAT_DEG_TO_IDX(90.0);
    }
    else
    {
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, 152, 32, 192, 72);

        work->anchorAngle.x = -FLOAT_DEG_TO_IDX(45.0);
        work->anchorAngle.y = FLOAT_DEG_TO_IDX(90.0);

        work->ropeAngle.x = FLOAT_DEG_TO_IDX(11.25);
        work->ropeAngle.y = FLOAT_DEG_TO_IDX(90.0);
    }

    work->anchorPos           = FLOAT_TO_FX32(144.0);
    work->targetAnchorAngle.x = work->anchorAngle.x;
    work->targetAnchorAngle.y = work->anchorAngle.y;
    work->targetRopeAngle.x   = work->ropeAngle.x;
    work->targetRopeAngle.y   = work->ropeAngle.y;

    if ((mapObject->flags & ANCHORROPE_FLAG_FLIPPED) != 0)
        work->angleDistanceThreshold = FLOAT_TO_FX32(32.0);
    else
        work->angleDistanceThreshold = FLOAT_TO_FX32(40.0);

    AnchorRope_HandleRopePos(work);

    SetTaskOutFunc(&work->gameWork.objWork, AnchorRope_Draw);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

void AnchorRope_Destructor(Task *task)
{
    AnchorRope *work = TaskGetWork(task, AnchorRope);

    for (s32 i = 0; i < ANCHORROPE_ANIMATOR_COUNT; i++)
    {
        AnimatorMDL__Release(&work->aniRope3D[i]);
        ObjDrawReleaseSpritePalette(work->aniRope2D[i].work.cParam.palette);
        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_160), &work->aniRope2D[i]);
    }

    ObjDataRelease(GetObjectDataWork(OBJDATAWORK_159));

    GameObject__Destructor(task);
}

NONMATCH_FUNC void AnchorRope_State_PlayerSpin(AnchorRope *work)
{
	// https://decomp.me/scratch/Or12p -> 96.12%
#ifdef NON_MATCHING
    Player *player = (Player *)work->gameWork.parent;

    if (player == NULL || !CheckPlayerGimmickObj(player, work))
    {
        work->gameWork.parent = NULL;
        SetTaskState(&work->gameWork.objWork, AnchorRope_State_ReleasedPlayer);
        AnchorRope_State_ReleasedPlayer(work);
    }
    else
    {
        work->angleSpeed = ObjSpdUpSet(work->angleSpeed, -FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(0.46875));
        work->angleDistance += MATH_ABS(work->angleSpeed);
        work->anchorAngle.x = ObjRoopMove16(work->anchorAngle.x, FLOAT_DEG_TO_IDX(270.0), FLOAT_DEG_TO_IDX(1.40625));
        work->ropeAngle.x   = ObjRoopMove16(work->ropeAngle.x, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(0.3515625));
        work->anchorAngle.y += work->angleSpeed;
        work->ropeAngle.y += work->angleSpeed;

        work->anchorPos -= FLOAT_TO_FX32(1.3125);
        if (work->anchorPos < FLOAT_TO_FX32(42.0))
            work->anchorPos = FLOAT_TO_FX32(42.0);

        if (work->angleDistance >= work->angleDistanceThreshold)
        {
            work->gameWork.parent = NULL;
            work->gameWork.objWork.userFlag |= 1;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(4.0);

            if (work->gameWork.mapObject->id == MAPOBJECT_208)
                work->gameWork.objWork.velocity.x = -work->gameWork.objWork.velocity.x;

            if ((work->gameWork.mapObject->flags & ANCHORROPE_FLAG_FLIPPED) != 0)
                work->gameWork.objWork.velocity.x = -work->gameWork.objWork.velocity.x;

            work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(4.0);
            SetTaskState(&work->gameWork.objWork, AnchorRope_State_ReleasedPlayer);
        }

        AnchorRope_HandleRopePos(work);
        work->aniRopeString3D.work.scale.z = MultiplyFX(FLOAT_TO_FX32(3.3), FX_Div(work->anchorPos, FLOAT_TO_FX32(144.0)));
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02176CA0
	ldrne r0, [r0, #0x6d8]
	cmpne r0, r4
	beq _02176CBC
_02176CA0:
	mov r0, #0
	str r0, [r4, #0x35c]
	ldr r1, =AnchorRope_State_ReleasedPlayer
	mov r0, r4
	str r1, [r4, #0xf4]
	bl AnchorRope_State_ReleasedPlayer
	ldmia sp!, {r4, pc}
_02176CBC:
	add r0, r4, #0x700
	ldrsh r0, [r0, #0x54]
	mov r1, #0x400
	rsb r1, r1, #0
	mov r2, #0x780
	bl ObjSpdUpSet
	add r1, r4, #0x700
	strh r0, [r1, #0x54]
	ldrsh r2, [r1, #0x54]
	ldr r1, [r4, #0x758]
	add r0, r4, #0x700
	cmp r2, #0
	rsblt r2, r2, #0
	add r1, r1, r2
	str r1, [r4, #0x758]
	ldrh r0, [r0, #0x44]
	mov r1, #0xc000
	mov r2, #0x100
	bl ObjRoopMove16
	add r1, r4, #0x700
	strh r0, [r1, #0x44]
	ldrh r0, [r1, #0x4a]
	mov r1, #0
	mov r2, #0x40
	bl ObjRoopMove16
	add r1, r4, #0x700
	strh r0, [r1, #0x4a]
	ldrh r2, [r1, #0x46]
	ldrsh r0, [r1, #0x54]
	add r0, r2, r0
	strh r0, [r1, #0x46]
	ldrh r2, [r1, #0x4c]
	ldrsh r0, [r1, #0x54]
	add r0, r2, r0
	strh r0, [r1, #0x4c]
	ldr r0, [r4, #0x750]
	sub r0, r0, #0x1500
	str r0, [r4, #0x750]
	cmp r0, #0x2a000
	movlt r0, #0x2a000
	strlt r0, [r4, #0x750]
	ldr r1, [r4, #0x758]
	ldr r0, [r4, #0x768]
	cmp r1, r0
	blo _02176DD0
	mov r0, #0
	str r0, [r4, #0x35c]
	ldr r1, [r4, #0x24]
	mov r0, #0x4000
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x340]
	mov r1, #0x4000
	ldrh r0, [r0, #2]
	rsb r1, r1, #0
	cmp r0, #0xd0
	ldreq r0, [r4, #0x98]
	rsbeq r0, r0, #0
	streq r0, [r4, #0x98]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #4]
	tst r0, #1
	ldrne r0, [r4, #0x98]
	rsbne r0, r0, #0
	strne r0, [r4, #0x98]
	ldr r0, =AnchorRope_State_ReleasedPlayer
	str r1, [r4, #0x9c]
	str r0, [r4, #0xf4]
_02176DD0:
	mov r0, r4
	bl AnchorRope_HandleRopePos
	ldr r0, [r4, #0x750]
	mov r1, #0x90000
	bl FX_Div
	ldr r1, =0x000034CC
	mov r2, #0
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x4cc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void AnchorRope_State_ReleasedPlayer(AnchorRope *work)
{
    work->anchorAngle.x = ObjRoopMove16(work->anchorAngle.x, work->targetAnchorAngle.x, FLOAT_DEG_TO_IDX(1.40625));
    work->ropeAngle.x   = ObjRoopMove16(work->ropeAngle.x, work->targetRopeAngle.x, FLOAT_DEG_TO_IDX(0.3515625));
    work->anchorAngle.y = AkMath__Func_2002D28(work->anchorAngle.y, work->targetAnchorAngle.y, work->angleSpeed);
    work->ropeAngle.y   = AkMath__Func_2002D28(work->ropeAngle.y, work->targetRopeAngle.y, work->angleSpeed);

    work->anchorPos += FLOAT_TO_FX32(2.625);
    if (work->anchorPos > FLOAT_TO_FX32(144.0))
        work->anchorPos = FLOAT_TO_FX32(144.0);

    work->aniRopeString3D.work.scale.z = MultiplyFX(FLOAT_TO_FX32(3.3), FX_Div(work->anchorPos, FLOAT_TO_FX32(144.0)));

    if ((work->anchorAngle.x == work->targetAnchorAngle.x && work->ropeAngle.x == work->targetRopeAngle.x)
        && (work->anchorAngle.y == work->targetAnchorAngle.y && work->ropeAngle.y == work->targetRopeAngle.y))
    {
        work->anchorPos = FLOAT_TO_FX32(144.0);
        SetTaskState(&work->gameWork.objWork, NULL);
        work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        AnimatorMDL__SetResource(&work->aniRopeString3D, work->resAnchorRope, 2, FALSE, FALSE);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        work->aniRopeString3D.work.scale.z = FLOAT_TO_FX32(3.3);
    }

    AnchorRope_HandleRopePos(work);
}

void AnchorRope_Draw(void)
{
    AnchorRope *work = TaskGetWorkCurrent(AnchorRope);

    MtxFx33 mtxRotation;
    VecFx32 position;

    u32 displayFlag3D;
    u32 displayFlag2D;

    displayFlag3D = displayFlag2D = work->gameWork.objWork.displayFlag;

    if (work->gameWork.mapObject->id == MAPOBJECT_208)
        displayFlag2D |= DISPLAY_FLAG_FLIP_X;

    // Draw Anchor
    AnimatorMDL *aniAnchor3D      = &work->aniAnchor3D;
    AnimatorSpriteDS *aniAnchor2D = &work->aniAnchor2D;
    position                      = work->ropePos;
    MTX_Identity33(&aniAnchor3D->work.rotation);
    MTX_RotX33(&mtxRotation, SinFX((s32)(u16)-work->anchorAngle.x), CosFX((s32)(u16)-work->anchorAngle.x));
    MTX_Concat33(&aniAnchor3D->work.rotation, &mtxRotation, &aniAnchor3D->work.rotation);
    MTX_RotY33(&mtxRotation, SinFX((s32)(u16)-work->anchorAngle.y), CosFX((s32)(u16)-work->anchorAngle.y));
    MTX_Concat33(&aniAnchor3D->work.rotation, &mtxRotation, &aniAnchor3D->work.rotation);
    StageTask__Draw3DEx(&aniAnchor3D->work, &position, &work->anchorAngle, NULL, &displayFlag3D, NULL, NULL, NULL);
    StageTask__Draw2DEx(aniAnchor2D, &position, NULL, NULL, &displayFlag2D, NULL, NULL);

    // Draw Rope
    AnimatorMDL *aniRope3D      = &work->aniRopeString3D;
    AnimatorSpriteDS *aniRope2D = &work->aniRopeString2D;
    position                    = work->gameWork.objWork.position;
    MTX_Identity33(&aniRope3D->work.rotation);
    MTX_RotX33(&mtxRotation, SinFX((s32)(u16)-work->ropeAngle.x), CosFX((s32)(u16)-work->ropeAngle.x));
    MTX_Concat33(&aniRope3D->work.rotation, &mtxRotation, &aniRope3D->work.rotation);
    MTX_RotY33(&mtxRotation, SinFX((s32)(u16)-work->ropeAngle.y), CosFX((s32)(u16)-work->ropeAngle.y));
    MTX_Concat33(&aniRope3D->work.rotation, &mtxRotation, &aniRope3D->work.rotation);
    StageTask__Draw3DEx(&aniRope3D->work, &position, &work->ropeAngle, NULL, &displayFlag3D, NULL, NULL, NULL);
    StageTask__Draw2DEx(aniRope2D, &position, NULL, NULL, &displayFlag2D, NULL, NULL);
}

void AnchorRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    AnchorRope *anchorRope = (AnchorRope *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (anchorRope == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((Player *)anchorRope->gameWork.parent != player)
    {
        anchorRope->gameWork.parent = &player->objWork;
        anchorRope->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

        anchorRope->anchorPos                 = FLOAT_TO_FX32(144.0);
        anchorRope->angleSpeed                = -FLOAT_TO_FX32(0.25);
        anchorRope->angleDistance             = FLOAT_TO_FX32(0.0);
        anchorRope->gameWork.objWork.userFlag = 0;

        AnimatorMDL__SetResource(&anchorRope->aniRopeString3D, anchorRope->resAnchorRope, 1, FALSE, FALSE);
        anchorRope->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;

        AnchorRope_HandleRopePos(anchorRope);

        SetTaskState(&anchorRope->gameWork.objWork, AnchorRope_State_PlayerSpin);
        Player__Action_AnchorRope(player, &anchorRope->gameWork);
    }
}

void AnchorRope_HandleRopePos(AnchorRope *work)
{
    MtxFx33 mtx;
    MtxFx33 mtxRot;
    VecFx32 offset;

    // Rotate Rope
    MTX_Identity33(&mtx);
    MTX_RotX33(&mtxRot, SinFX(work->ropeAngle.x), CosFX(work->ropeAngle.x));
    MTX_Concat33(&mtx, &mtxRot, &mtx);
    MTX_RotY33(&mtxRot, SinFX((s32)(u16)-work->ropeAngle.y), CosFX((s32)(u16)-work->ropeAngle.y));
    MTX_Concat33(&mtx, &mtxRot, &mtx);
    VEC_Set(&offset, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -work->anchorPos);
    MTX_MultVec33(&offset, &mtx, &offset);
    VEC_Set(&work->ropePos, work->gameWork.objWork.position.x + offset.x, work->gameWork.objWork.position.y + offset.y, work->gameWork.objWork.position.z + offset.z);

    // Rotate Anchor
    MTX_Identity33(&mtx);
    MTX_RotX33(&mtxRot, SinFX(work->anchorAngle.x), CosFX(work->anchorAngle.x));
    MTX_Concat33(&mtx, &mtxRot, &mtx);
    MTX_RotY33(&mtxRot, SinFX((s32)(u16)-work->anchorAngle.y), CosFX((s32)(u16)-work->anchorAngle.y));
    MTX_Concat33(&mtx, &mtxRot, &mtx);
    VEC_Set(&offset, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(60.0), FLOAT_TO_FX32(0.0));
    MTX_MultVec33(&offset, &mtx, &offset);
    VEC_Set(&work->gameWork.objWork.prevPosition, work->ropePos.x + offset.x, work->ropePos.y + offset.y, work->ropePos.z + offset.z);

    work->gameWork.objWork.dir.x = -FLOAT_DEG_TO_IDX(90.0);
    work->gameWork.objWork.dir.y = work->anchorAngle.y - FLOAT_DEG_TO_IDX(90.0);
}