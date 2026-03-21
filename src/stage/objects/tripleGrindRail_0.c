#include <stage/objects/tripleGrindRail.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapFarSys.h>
#include <stage/core/ringManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_railSize mapObject->left
#define mapObjectParam_railID   mapObject->left

// --------------------
// VARIABLES
// --------------------

TripleGrindRail *sTripleGrindRailSingleton;

NOT_DECOMPILED const char aModGmkGrd3line[];
NOT_DECOMPILED const char aModGmkGrd3line_0[];
NOT_DECOMPILED const char aActAcEffGrd3lL_0[];
NOT_DECOMPILED const char aActAcItmRing3d[];

// --------------------
// FUNCTIONS
// --------------------

TripleGrindRailSpring *TripleGrindRailSpring__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRailSpring);
    if (task == HeapNull)
        return NULL;

    TripleGrindRailSpring *work = TaskGetWork(task, TripleGrindRailSpring);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_grd3l_spring.bac", GetObjectDataWork(OBJDATAWORK_176), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 86);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = TripleGrindRailSpring__OnDefend;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskState(&work->gameWork.objWork, TripleGrindRailSpring__State_Active);
    StageTask__SetAnimation(&work->gameWork.objWork, 0);

    return work;
}

NONMATCH_FUNC TripleGrindRail *TripleGrindRail__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/vDReX => 97.90% at -O2,p, 92.11% at -O4,p
#ifdef NON_MATCHING
    UNUSED(type);
    TripleGrindRail *work;
    s32 i1;
    Task *task;

    task = CreateStageTask(TripleGrindRail__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRail);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, TripleGrindRail);
    TaskInitWork8(work);
    sTripleGrindRailSingleton = work;
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    s32 railSize                                     = MATH_MAX(mapObjectParam_railSize, 8);
    fx32 railTailEndX                                = x + FX32_FROM_WHOLE((railSize - 4) * 64);
    work->railStartExitX                             = railTailEndX - FX32_FROM_WHOLE(0x22C);
    work->gameWork.objWork.viewOutOffsetBoundsLeft   = -0x200;
    work->gameWork.objWork.viewOutOffsetBoundsBottom = 0x200;
    work->flags |= TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START;

    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniTripleGrindRail, aModGmkGrd3line, 0, NULL, gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniTripleGrindRail, aModGmkGrd3line_0, NULL, gameArchiveStage);
    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_TEX_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_TEX_ANIM], 0, NULL);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->aniTripleGrindRail.ani.speedMultiplier = 0;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    VEC_Set(&work->aniTripleGrindRail.ani.work.scale, FLOAT_TO_FX32(3.2998046875), FLOAT_TO_FX32(3.2998046875), FLOAT_TO_FX32(3.2998046875));
    work->gameWork.objWork.offset.x = TRIPLEGRINDRAIL_X_OFFSET;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    void *leaf3dLoad                    = ObjDataLoad(NULL, aActAcEffGrd3lL_0, gameArchiveStage);
    AnimatorSprite3D *currentDecoration = &work->aniDecorations[0];
    for (i1 = 0; i1 < TRIPLEGRINDRAIL_PARTICLE_COUNT; currentDecoration++, i1++)
    {
        u32 size            = Sprite__GetTextureSizeFromAnim(leaf3dLoad, i1);
        VRAMPixelKey tkey   = VRAMSystem__AllocTexture(size, FALSE);
        size                = Sprite__GetPaletteSizeFromAnim(leaf3dLoad, i1);
        VRAMPaletteKey pkey = VRAMSystem__AllocPalette(size, FALSE);
        AnimatorSprite3D__Init(currentDecoration, 0, leaf3dLoad, i1,
                               ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS, tkey, pkey);
        currentDecoration->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
        currentDecoration->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
        AnimatorSprite3D__ProcessAnimation(currentDecoration, NULL, NULL);
        currentDecoration->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    }
    for (i1 = 0; i1 < TRIPLEGRINDRAIL_LEAF_COUNT; i1++)
    {
        work->leafList[i1].y = TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE;
    }
    for (i1 = 0; i1 < TRIPLEGRINDRAIL_MUSHROOM_COUNT; i1++)
    {
        work->mushroomList[i1].y = TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE;
    }

    void *ring3dLoad          = ObjDataLoad(NULL, aActAcItmRing3d, gameArchiveStage);
    AnimatorSprite3D *aniRing = &work->aniRing;
    VRAMPixelKey tkeyRing     = VRAMSystem__AllocTexture(0x80, FALSE);
    VRAMPaletteKey pkeyRing   = VRAMSystem__AllocPalette(0x10, FALSE);
    AnimatorSprite3D__Init(aniRing, 0, ring3dLoad, 0, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING, tkeyRing,
                           pkeyRing);
    aniRing->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    aniRing->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    AnimatorSprite3D__ProcessAnimation(aniRing, NULL, NULL);
    aniRing->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    VRAMPixelKey tkeyRingSparkle   = VRAMSystem__AllocTexture(0x300, FALSE);
    VRAMPaletteKey pkeyRingSparkle = VRAMSystem__AllocPalette(0x10, FALSE);
    AnimatorSprite3D__Init(&work->aniRingSparkle, 0, ring3dLoad, 1,
                           ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS, tkeyRingSparkle, pkeyRingSparkle);
    work->aniRingSparkle.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->aniRingSparkle.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    AnimatorSprite3D__ProcessAnimation(&work->aniRingSparkle, NULL, NULL);
    work->aniRingSparkle.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 0x200;
    work->gameWork.collisionObject.work.height    = 8;
    work->gameWork.collisionObject.work.ofst_x    = -0xC0;
    work->gameWork.collisionObject.work.ofst_y    = 0;
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -0x80, -0xC0, 0x80, 0);

    ObjRect__SetGroupFlags(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 2, 1);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent   = &work->gameWork.objWork;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = TripleGrindRail__OnDefend_StartTrigger;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, =0x0000117C
	ldr r0, =StageTask_Main
	ldr r1, =TripleGrindRail__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, =0x0000117C
	mov r1, #0
	mov r7, r0
	bl MI_CpuFill8
	ldr r2, =sTripleGrindRailSingleton
	mov r0, r7
	str r7, [r2]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldrsb r0, [r6, #6]
	mov r3, #0
	ldr r2, =aModGmkGrd3line
	cmp r0, #8
	movlt r0, #8
	sub r0, r0, #4
	add r0, r5, r0, lsl #18
	sub r1, r0, #0x22c000
	mov r0, #0x200
	str r1, [r7, #0xe08]
	rsb r0, r0, #0
	strh r0, [r7, #0xe]
	mov r0, #0x200
	strh r0, [r7, #0x14]
	ldr r0, [r7, #0xe04]
	add r1, r7, #0x364
	orr r0, r0, #1
	str r0, [r7, #0xe04]
	ldr r0, =gameArchiveStage
	str r3, [sp]
	ldr r4, [r0, #0]
	mov r0, r7
	str r4, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, =gameArchiveStage
	ldr r2, =aModGmkGrd3line_0
	ldr r4, [r0, #0]
	mov r0, r7
	add r1, r7, #0x364
	mov r3, #0
	str r4, [sp]
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r7, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r7, #0x20]
	str r0, [r7, #0x47c]
	ldr r2, [r7, #0x20]
	ldr r1, =0x000034CC
	orr r2, r2, #0x100
	str r2, [r7, #0x20]
	str r1, [r7, #0x37c]
	str r1, [r7, #0x380]
	str r1, [r7, #0x384]
	ldr r2, =0x00141BB2
	ldr r1, =aActAcEffGrd3lL_0
	str r2, [r7, #0x50]
	ldr r3, [r7, #0x20]
	ldr r2, =gameArchiveStage
	orr r3, r3, #0x20
	str r3, [r7, #0x20]
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r9, r0
	add r10, r7, #0x4e0
	mov r8, #0
	mov r5, #0x860
	mov r4, #0x1d
	mov r11, #7
	b _02163884
_02163804:
	mov r1, r8, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r1, r8, lsl #0x10
	mov r6, r0
	mov r0, r9
	mov r1, r1, lsr #0x10
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	stmia sp, {r5, r6}
	mov r3, r8, lsl #0x10
	str r0, [sp, #8]
	mov r0, r10
	mov r1, #0
	mov r2, r9
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	strb r4, [r10, #0xa]
	mov r1, #0
	strb r11, [r10, #0xb]
	mov r0, r10
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r10, #0xcc]
	add r8, r8, #1
	orr r0, r0, #0x18
	str r0, [r10, #0xcc]
	add r10, r10, #0x104
_02163884:
	cmp r8, #7
	blt _02163804
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638A8
_0216389C:
	mla r1, r8, r0, r7
	str r2, [r1, #0xe1c]
	add r8, r8, #1
_021638A8:
	cmp r8, #0x40
	blt _0216389C
	mov r8, #0
	mov r2, #0x100000
	mov r0, #0xc
	b _021638D0
_021638C0:
	mla r1, r8, r0, r7
	add r1, r1, #0x1000
	str r2, [r1, #0x120]
	add r8, r8, #1
_021638D0:
	cmp r8, #8
	blt _021638C0
	ldr r0, =gameArchiveStage
	ldr r1, =aActAcItmRing3d
	ldr r2, [r0, #0]
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x80
	mov r1, #0
	add r5, r7, #0x3fc
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	ldr r2, =0x00000844
	mov r1, #0
	stmia sp, {r2, r6}
	str r0, [sp, #8]
	add r0, r5, #0x800
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0x80a]
	mov r0, #7
	mov r1, #0
	strb r0, [r5, #0x80b]
	add r0, r5, #0x800
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r5, #0x8cc]
	mov r0, #0x300
	orr r1, r1, #0x10
	str r1, [r5, #0x8cc]
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x860
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	mov r2, r4
	add r0, r7, #0xd00
	mov r1, #0
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r7, #0xd0a]
	mov r0, #7
	mov r1, #0
	strb r0, [r7, #0xd0b]
	add r0, r7, #0xd00
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r7, #0xdcc]
	mov r1, #0
	orr r0, r0, #0x18
	str r0, [r7, #0xdcc]
	ldr r0, =StageTask__DefaultDiffData
	str r1, [r7, #0x13c]
	str r0, [r7, #0x2fc]
	mov r2, #0x200
	add r0, r7, #0x300
	strh r2, [r0, #8]
	mov r2, #8
	strh r2, [r0, #0xa]
	sub r0, r2, #0xc8
	add r3, r7, #0x200
	strh r0, [r3, #0xf0]
	mov r2, r1
	add r0, r7, #0x218
	strh r1, [r3, #0xf2]
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r4, #0
	add r0, r7, #0x218
	sub r1, r4, #0x80
	sub r2, r4, #0xc0
	mov r3, #0x80
	str r4, [sp]
	bl ObjRect__SetBox2D
	ldr r1, =0x00000102
	add r0, r7, #0x200
	strh r1, [r0, #0x4c]
	ldr r0, =TripleGrindRail__OnDefend_StartTrigger
	str r7, [r7, #0x234]
	str r0, [r7, #0x23c]
	ldr r1, [r7, #0x230]
	mov r0, r7
	orr r1, r1, #0x400
	str r1, [r7, #0x230]
	ldr r1, [r7, #0x1c]
	orr r1, r1, #0x100
	str r1, [r7, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
