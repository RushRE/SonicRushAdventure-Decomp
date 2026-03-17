#include <stage/objects/tripleGrindRail.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapFarSys.h>
#include <stage/core/ringManager.h>

// --------------------
// VARIABLES
// --------------------

extern RingManager *ringManagerWork;

static TripleGrindRail *TripleGrindRail__Singleton;

NOT_DECOMPILED void *TripleGrindRail__LeafParticleDefaultScale;
NOT_DECOMPILED void *TripleGrindRail__MushroomDefaultScale;
NOT_DECOMPILED u16 TripleGrindRail__ParticleIDs[8];

NOT_DECOMPILED const char aActAcGmkGrd3lS[];
NOT_DECOMPILED const char aModGmkGrd3line[];
NOT_DECOMPILED const char aModGmkGrd3line_0[];
NOT_DECOMPILED const char aActAcEffGrd3lL_0[];
NOT_DECOMPILED const char aActAcItmRing3d[];
NOT_DECOMPILED const char aActAcGmkBallSi[];

// --------------------
// FUNCTIONS
// --------------------

TripleGrindRailSpring *TripleGrindRailSpring__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRailSpring);
    if (task == HeapNull)
        return NULL;

    TripleGrindRailSpring *work = TaskGetWork(task, TripleGrindRailSpring);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, aActAcGmkGrd3lS, GetObjectDataWork(OBJDATAWORK_176), gameArchiveStage, OBJ_DATA_GFX_AUTO);
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
    TripleGrindRail *work;
    s32 i1;
    Task *task;

    task = CreateStageTask(TripleGrindRail__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRail);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, TripleGrindRail);
    TaskInitWork8(work);
    TripleGrindRail__Singleton = work;
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    s32 d                                            = MATH_MAX(mapObject->left, 8);
    fx32 d2                                          = x + FX32_FROM_WHOLE((d - 4) << 6);
    work->dwordE08                                   = d2 - FX32_FROM_WHOLE(0x22C);
    work->gameWork.objWork.viewOutOffsetBoundsLeft   = -0x200;
    work->gameWork.objWork.viewOutOffsetBoundsBottom = 0x200;
    work->flags |= TRIPLEGRINDRAIL_FLAG_1;

    ObjAction3dNNModelLoad(&work->gameWork.objWork, &work->aniTripleGrindRail, aModGmkGrd3line, 0, NULL, gameArchiveStage);
    ObjAction3dNNMotionLoad(&work->gameWork.objWork, &work->aniTripleGrindRail, aModGmkGrd3line_0, NULL, gameArchiveStage);
    AnimatorMDL__SetAnimation(&work->gameWork.objWork.obj_3d->ani, B3D_ANIM_TEX_ANIM, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_TEX_ANIM], 0, NULL);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->aniTripleGrindRail.ani.speedMultiplier = 0;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    VEC_Set(&work->aniTripleGrindRail.ani.work.scale, FLOAT_TO_FX32(3.2998046875), FLOAT_TO_FX32(3.2998046875), FLOAT_TO_FX32(3.2998046875));
    work->gameWork.objWork.offset.x = FLOAT_TO_FX32(321.73095703125);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    void *leaf3dLoad                    = ObjDataLoad(NULL, aActAcEffGrd3lL_0, gameArchiveStage);
    AnimatorSprite3D *currentDecoration = &work->aniDecorations[0];
    for (i1 = 0; i1 < TRIPLEGRINDRAIL_ANI_COUNT; currentDecoration++, i1++)
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
        work->leafList[i1].y = FLOAT_TO_FX32(256.0);
    }
    for (i1 = 0; i1 < TRIPLEGRINDRAIL_MUSHROOM_COUNT; i1++)
    {
        work->mushroomList[i1].y = FLOAT_TO_FX32(256.0);
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
	ldr r2, =TripleGrindRail__Singleton
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

TripleGrindRailEntity *TripleGrindRailEntity__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (TripleGrindRail__Singleton == NULL)
        return NULL;
    if (x <= TripleGrindRail__Singleton->gameWork.objWork.position.x)
        return NULL;

    if ((TripleGrindRail__Singleton->flags & TRIPLEGRINDRAIL_FLAG_1) != 0)
        return NULL;

    TripleGrindRailEntity *work;
    // Sic: we're allocating a TripleGrindRailEntity by asking for the (much greater) size of a TripleGrindRail
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRail);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, TripleGrindRailEntity);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    s32 val      = ClampS32(mapObject->left, 0, 2);
    work->radius = val * FLOAT_TO_FX32(89.0947265625) + FLOAT_TO_FX32(232.63623046875);
    if ((mapObject->id == MAPOBJECT_122) || (mapObject->id != MAPOBJECT_123))
    {
        ObjObjectAction3dBACLoad(&work->gameWork.objWork, &work->aniSprite, aActAcGmkBallSi, OBJ_DATA_GFX_NONE, OBJ_DATA_GFX_NONE, GetObjectFileWork(OBJDATAWORK_177),
                                 gameArchiveStage);
        ObjObjectActionAllocTexture(&work->gameWork.objWork, 0x800, 16, GetObjectFileWork(OBJDATAWORK_178));
        OBS_DATA_WORK *work178 = GetObjectFileWork(OBJDATAWORK_178);
        if ((work178->referenceCount & ~0x8000) == 1)
        {
            work->aniSprite.ani.animatorSprite.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_UNCOMPRESSED_PALETTES;
            AnimatorSprite3D__ProcessAnimation(&work->aniSprite.ani, work->gameWork.objWork.ppSpriteCallback, work);
            work->aniSprite.ani.animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS | ANIMATOR_FLAG_DISABLE_PALETTES;
        }
        ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_INVINCIBLE);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->gameWork.objWork.scale.x = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.y = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.z = FLOAT_TO_FX32(2.5);
    }
    else
    {
        MI_CpuCopy8(&TripleGrindRail__Singleton->aniRingSparkle, &work->aniSprite.ani, sizeof(work->aniSprite.ani));
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
        ObjRect__SetBox3D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -8, -16, -4, 8, 0, 4);
        ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = TripleGrindRailEntity__OnDefend;
        work->gameWork.objWork.scale.x                              = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.y                              = FLOAT_TO_FX32(2.5);
        work->gameWork.objWork.scale.z                              = FLOAT_TO_FX32(2.5);
    }
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    SetTaskState(&work->gameWork.objWork, TripleGrindRailEntity__State_Inactive);

    return work;
}

NONMATCH_FUNC void TripleGrindRailRingLoss__Create(Player *player)
{
    // https://decomp.me/scratch/fV24Q => 91.97%
#ifdef NON_MATCHING
    VecFx32 position;
    s32 shift;
    fx32 ringAngle;
    s32 ringCount;
    fx32 *currentRingVelocityX;
    fx32 *currentRingVelocityY;
    VecFx32 *currentRingPosition;
    s32 i;

    ringAngle = FLOAT_DEG_TO_IDX(6.375);

    if (TripleGrindRail__Singleton == NULL)
        return;
    if ((TripleGrindRail__Singleton->flags & TRIPLEGRINDRAIL_FLAG_1) != 0)
        return;

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), TripleGrindRailRingLoss);
    if (task == HeapNull)
        return;

    TripleGrindRailRingLoss *work = TaskGetWork(task, TripleGrindRailRingLoss);
    TaskInitWork8(work);

    work->objWork.objType = STAGE_OBJ_TYPE_OBJECT;
    fx32 scale            = GetStageRingScale();
    work->objWork.scale.x = scale;
    work->objWork.scale.y = scale;
    work->objWork.scale.z = scale;
    ringCount             = MATH_MIN(player->rings, RINGMANAGER_RING_SPILL_MAX);
    player->rings         = 0;
    work->ringCount       = ringCount;
    position              = work->objWork.position;
    ringAngle += (ringManagerWork->ringPenaltyCount[player->controlID] << 8);

    currentRingVelocityX = &work->ringVelocityX[0];
    currentRingVelocityY = &work->ringVelocityY[0];
    currentRingPosition  = &work->ringPosition[0];

    fx32 velocityX;
    fx32 velocityY;
    for (i = 0; i < ringCount; i++, currentRingPosition++)
    {
        *currentRingPosition = position;
        if (ringAngle >= 0)
        {
            u16 index16   = ringAngle << 8;
            s32 ang8      = ringAngle >> 8;
            s32 shift     = (ang8 >= 6) ? (9 - ang8) : ang8;
            fx32 sin      = SinFX((s32)(u16)(s32)index16);
            fx32 cos      = CosFX((s32)(u16)(s32)index16);
            fx32 tempVelX = (sin << 4) >> shift;
            fx32 tempVelY = (cos << 4) >> shift;
            velocityX     = tempVelX - (tempVelX >> 2);
            velocityY     = tempVelY - (tempVelY >> 2);
            ringAngle     = (ringAngle + 0x10) | 0x80;
        }
        *(currentRingVelocityX++) = velocityX;
        *(currentRingVelocityY++) = velocityY;
        ringAngle                 = -ringAngle;
        velocityX                 = -velocityX;
    }
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskOutFunc(&work->objWork, TripleGrindRailRingLoss__Draw);
    SetTaskState(&work->objWork, TripleGrindRailRingLoss__State_Active);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r1, =TripleGrindRail__Singleton
	mov r8, r0
	ldr r0, [r1, #0]
	ldr r4, =0x00000488
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r0, #0xe04]
	tst r0, #1
	addne sp, sp, #0x18
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	add r5, r4, #0x1e4
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl GetTaskWork_
	add r2, r4, #0x1e4
	mov r1, #0
	mov r5, r0
	bl MI_CpuFill8
	mov r0, #3
	strh r0, [r5]
	bl GetStageRingScale
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	add r0, r8, #0x600
	ldrsh r10, [r0, #0x7e]
	mov r1, #0
	add lr, r5, #0x16c
	strh r1, [r0, #0x7e]
	cmp r10, #0x40
	movgt r10, #0x40
	add ip, sp, #0xc
	str r10, [r5, #0x168]
	add r0, r8, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, =ringManagerWork
	ldrb r1, [r8, #0x5d1]
	ldr r0, [r0, #0]
	cmp r10, #0
	add r0, r0, r1
	ldrb r1, [r0, #0x364]
	add r0, r5, #0x6c
	add r8, r0, #0x400
	add r9, lr, #0x400
	add r4, r4, r1, lsl #8
	mov r11, #0
	ble _02163F14
	ldr r3, =FX_SinCosTable_
_02163E88:
	ldmia ip, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	cmp r4, #0
	blt _02163EF4
	mov r1, r4, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	mov r2, r1, lsl #1
	add r1, r3, r1, lsl #1
	ldrsh r6, [r3, r2]
	ldrsh r2, [r1, #2]
	mov r0, r4, asr #8
	cmp r0, #6
	add r1, r4, #0x10
	rsbge r0, r0, #9
	mov r4, r6, lsl #4
	mov r4, r4, asr r0
	mov r2, r2, lsl #4
	mov r0, r2, asr r0
	sub r6, r4, r4, asr #2
	sub r7, r0, r0, asr #2
	orr r4, r1, #0x80
_02163EF4:
	str r6, [r8], #4
	add r11, r11, #1
	cmp r11, r10
	str r7, [r9], #4
	rsb r4, r4, #0
	rsb r6, r6, #0
	add lr, lr, #0xc
	blt _02163E88
_02163F14:
	ldr r0, [r5, #0x18]
	ldr r1, =TripleGrindRailRingLoss__Draw
	orr r0, r0, #0x10
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	ldr r0, =TripleGrindRailRingLoss__State_Active
	orr r2, r2, #0x2100
	str r2, [r5, #0x1c]
	str r1, [r5, #0xfc]
	str r0, [r5, #0xf4]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void TripleGrindRailSpring__State_Active(TripleGrindRailSpring *work)
{
    if (work->gameWork.animator.ani.work.animID != 1)
        return;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
        return;

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~(OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME);
    StageTask__SetAnimation(&work->gameWork.objWork, 0);
}

void TripleGrindRailSpring__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    TripleGrindRailSpring *railSpring = (TripleGrindRailSpring *)rect2->parent;
    Player *player                    = (Player *)rect1->parent;
    if (railSpring == NULL)
        return;
    if ((player == NULL) || (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER))
        return;

    player->objWork.position.x = railSpring->gameWork.objWork.position.x;
    player->objWork.position.y = railSpring->gameWork.objWork.position.y;
    StageTask__SetAnimation(&railSpring->gameWork.objWork, 1);
    s32 leftClamped = MTM_MATH_CLIP_3(railSpring->gameWork.mapObject->left, 0x30, 0x40);
    fx32 velocityX  = FX32_FROM_WHOLE(leftClamped << 0x3) / 90;
    fx32 velocityY  = FLOAT_TO_FX32(-17.06640625);
    Player__Action_TripleGrindRailStartSpring(player, &railSpring->gameWork, velocityX, velocityY);
    player->overSpeedLimitTimer     = 90;
    player->objWork.gravityStrength = FLOAT_TO_FX32(0.379150390625);
    Player__Action_AllowTrickCombos(player, &railSpring->gameWork);
}

void TripleGrindRail__Destructor(Task *task)
{
    for (s32 i = 0; i < TRIPLEGRINDRAIL_ANI_COUNT; i++)
    {
        AnimatorSprite3D__Release(&TripleGrindRail__Singleton->aniDecorations[i]);
    }
    AnimatorSprite3D__Release(&TripleGrindRail__Singleton->aniRing);
    AnimatorSprite3D__Release(&TripleGrindRail__Singleton->aniRingSparkle);
    TripleGrindRail__Singleton = NULL;
    g_obj.scroll.x             = 0;
    SetStageRingScale(FX32_ONE);
    GameObject__Destructor(task);
}

void TripleGrindRail__State_21640DC(TripleGrindRail *work)
{
    work->gameWork.objWork.offset.x = FLOAT_TO_FX32(321.73095703125);
    if (work->gameWork.objWork.dir.x != 0)
    {
        work->gameWork.objWork.dir.x = work->gameWork.objWork.dir.x - FLOAT_TO_FX32(0.20703125);
        if ((work->gameWork.objWork.dir.x == 0) || (work->gameWork.objWork.dir.x > FLOAT_TO_FX32(8.0)))
            work->gameWork.objWork.dir.x = 0;
        MTX_Identity33(&work->aniTripleGrindRail.ani.work.rotation.nnMtx[0]);
        s32 index = (u16)(-work->gameWork.objWork.dir.x);
        MTX_RotX33(&work->aniTripleGrindRail.ani.work.rotation.nnMtx[0], SinFX(index), CosFX(index));
    }
    Player *player = (Player *)work->gameWork.parent;
    if (!CheckPlayerGimmickObj(work->gameWork.parent, work) || (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.parent = NULL;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_216497C);
        work->gameWork.objWork.userWork = 600;
        return;
    }
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
        return;

    Player__Gimmick_TripleGrindRail(player);
    player->gimmickFlag |= PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X | PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y;
    SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_21641E0);
    work->field_E0C = 0x400;
}

RUSH_INLINE fx32 FX32_AddSignBit(fx32 val)
{
    s32 signBit = (u32)(val >> (FX32_DEC_SIZE - 1)) >> (FX32_INT_SIZE + 1);
    return val + signBit;
}

NONMATCH_FUNC void TripleGrindRail__State_21641E0(TripleGrindRail *work)
{
    // https://decomp.me/scratch/OjJOV => 99.92%, bad regalloc
#ifdef NON_MATCHING
    VecFx32 positionLeaf;
    VecFx32 scaleLeaf;
    VecFx32 positionMushroom;
    VecFx32 scaleMushroom;
    StageDisplayFlags displayFlagsLeaf;
    StageDisplayFlags displayFlagsMushroom;
    TripleGrindRailParticle *currentLeafParticle;
    TripleGrindRailParticle *currentMushroomParticle;
    Player *player;
    s32 listIndex;
    s32 i;

    work->gameWork.objWork.offset.x = FLOAT_TO_FX32(321.73095703125);
    player                          = (Player *)work->gameWork.parent;
    if (!CheckPlayerGimmickObj(player, work) || (player->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.parent = NULL;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_216497C);
        work->gameWork.objWork.userWork = 600;
        return;
    }
    if (work->dwordE08 <= work->gameWork.objWork.position.x)
    {
        Player__Func_201DD24(player);
        player->gimmickFlag &= ~(PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_X | PLAYER_GIMMICK_LIMIT_BOUNDS_TO_GIMMICK_POS_Y);
        g_obj.scroll.x                               = 0;
        work->aniTripleGrindRail.ani.speedMultiplier = 0;
        work->flags |= TRIPLEGRINDRAIL_FLAG_2;
        SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_216492C);
        return;
    }
    if ((work->dwordE08 - FLOAT_TO_FX32(9.375)) <= work->gameWork.objWork.position.x)
    {
        work->flags |= TRIPLEGRINDRAIL_FLAG_1;
        player->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ;
    }
    else if ((work->dwordE08 - FLOAT_TO_FX32(31.875)) <= work->gameWork.objWork.position.x)
        work->flags |= TRIPLEGRINDRAIL_FLAG_1;
    work->field_E0C += FLOAT_TO_FX32(0.00390625);
    if (work->field_E0C > FX_ONE)
        work->field_E0C = FX_ONE;
    fx32 val       = FX32_AddSignBit(work->field_E0C * FLOAT_TO_FX32(0.375));
    g_obj.scroll.x = val >> FX32_SHIFT;

    s32 move = (work->field_E0C << 2) + (work->field_E0C << 1);
    if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
    {
        MapFarSys__AdvanceScrollSpeed(GRAPHICS_ENGINE_A, move);
        MapFarSys__AdvanceScrollSpeed(GRAPHICS_ENGINE_B, move);
    }
    else
        MapFarSys__AdvanceScrollSpeed(player->cameraID, move);

    fx32 v3                                      = FX32_AddSignBit(FX32_FROM_WHOLE(work->field_E0C));
    work->aniTripleGrindRail.ani.speedMultiplier = (v3 >> FX32_SHIFT) << 2;
    s32 v64                                      = (work->aniTripleGrindRail.ani.speedMultiplier << 14) / 60;
    work->field_E14                              = v64 >> 14;
    AnimatorSprite3D__ProcessAnimation(&work->aniRing, NULL, NULL);

    scaleLeaf           = TripleGrindRail__LeafParticleDefaultScale;
    displayFlagsLeaf    = DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
    currentLeafParticle = &work->leafList[0];
    listIndex           = -1;
    for (int i = 0; i < TRIPLEGRINDRAIL_LEAF_COUNT; i++, currentLeafParticle++)
    {
        if (currentLeafParticle->y == FLOAT_TO_FX32(256.0))
            listIndex = i;
        else
        {
            currentLeafParticle->angle -= TripleGrindRail__Singleton->field_E14 + (TripleGrindRail__Singleton->field_E14 >> 2);
            if ((currentLeafParticle->angle <= FLOAT_TO_FX32(6.6669921875)) || ((s32)currentLeafParticle->y < FLOAT_TO_FX32(-400.0)))
            {
                currentLeafParticle->y = FLOAT_TO_FX32(256.0);
                listIndex              = i;
            }
            else
            {
                currentLeafParticle->y = -(TripleGrindRail__Singleton->field_E14 << 4) + currentLeafParticle->y;
                s32 particleID         = currentLeafParticle->id;

                fx32 cos       = CosFX(currentLeafParticle->angle);
                fx32 cosRad    = FX_MulInline(cos, currentLeafParticle->radius);
                positionLeaf.x = TripleGrindRail__Singleton->gameWork.objWork.position.x + cosRad + FLOAT_TO_FX32(321.73095703125);
                positionLeaf.y = currentLeafParticle->y + TripleGrindRail__Singleton->gameWork.objWork.position.y;
                fx32 sin       = SinFX(currentLeafParticle->angle);
                positionLeaf.z = FX_MulInline(sin, currentLeafParticle->radius);
                StageTask__Draw3DEx(&work->aniDecorations[particleID].work, &positionLeaf, NULL, &scaleLeaf, &displayFlagsLeaf, NULL, NULL, NULL);
            }
        }
    }
    if ((work->flags & (TRIPLEGRINDRAIL_FLAG_1 | TRIPLEGRINDRAIL_FLAG_2)) == 0)
    {
        work->field_E16--;
        if ((work->field_E16 <= 0) && (listIndex != -1))
        {
            s32 r4 = 256 - TripleGrindRail__Singleton->field_E14;
            TripleGrindRail__CreateLeafParticle(&work->leafList[listIndex]);
            s32 r1          = (r4 >> 3) + (r4 >> 5);
            work->field_E16 = MTM_MATH_CLIP_3(r1, 3, 0x30);
        }
    }

    displayFlagsMushroom    = DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_UPDATE;
    scaleMushroom           = TripleGrindRail__MushroomDefaultScale;
    listIndex               = -1;
    currentMushroomParticle = &work->mushroomList[0];
    for (int i = 0; i < TRIPLEGRINDRAIL_MUSHROOM_COUNT; i++, currentMushroomParticle++)
    {
        if (currentMushroomParticle->y == FLOAT_TO_FX32(256))
            listIndex = i;
        else
        {
            currentMushroomParticle->angle = currentMushroomParticle->angle - TripleGrindRail__Singleton->field_E14;
            if (currentMushroomParticle->angle <= FLOAT_TO_FX32(6.6669921875))
            {
                currentMushroomParticle->y = FLOAT_TO_FX32(256);
                listIndex                  = i;
            }
            else
            {
                fx32 cos           = CosFX((s32)currentMushroomParticle->angle);
                fx32 cosRad        = FX_MulInline(cos, currentMushroomParticle->radius);
                positionMushroom.x = TripleGrindRail__Singleton->gameWork.objWork.position.x + cosRad + FLOAT_TO_FX32(321.73095703125);
                positionMushroom.y = currentMushroomParticle->y + TripleGrindRail__Singleton->gameWork.objWork.position.y;
                fx32 sin           = SinFX(currentMushroomParticle->angle);
                fx32 sinRad        = FX_MulInline(sin, currentMushroomParticle->radius);
                positionMushroom.z = sinRad;
                StageTask__Draw3DEx(&work->aniDecorations[6].work, &positionMushroom, NULL, &scaleMushroom, &displayFlagsMushroom, NULL, NULL, NULL);
            }
        }
    }
    if ((work->flags & (TRIPLEGRINDRAIL_FLAG_1 | TRIPLEGRINDRAIL_FLAG_2)) != 0)
        return;
    work->field_1118--;
    if ((work->field_1118 > 0) || (listIndex == -1))
        return;
    s32 r4 = 256 - TripleGrindRail__Singleton->field_E14;
    TripleGrindRail__CreateMushroomParticle(&work->mushroomList[listIndex]);
    s32 r42          = MTM_MATH_CLIP_3(r4, 20, 165);
    s32 randVal      = mtMathRandRepeat(0x20);
    work->field_1118 = randVal + r42;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r1, =0x00141BB2
	mov r6, r0
	str r1, [r6, #0x50]
	ldr r4, [r6, #0x35c]
	ldr r0, [r4, #0x6d8]
	cmp r0, r6
	bne _02164210
	ldr r0, [r4, #0x5d8]
	tst r0, #0x400
	beq _02164230
_02164210:
	mov r1, #0
	ldr r0, =TripleGrindRail__State_216497C
	str r1, [r6, #0x35c]
	str r0, [r6, #0xf4]
	mov r0, #0x258
	add sp, sp, #0x50
	str r0, [r6, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164230:
	ldr r2, [r6, #0x44]
	ldr r1, [r6, #0xe08]
	cmp r1, r2
	bgt _02164280
	mov r0, r4
	bl Player__Func_201DD24
	ldr r1, [r4, #0x5dc]
	ldr r0, =g_obj
	bic r1, r1, #0x600
	str r1, [r4, #0x5dc]
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r6, #0x47c]
	ldr r1, [r6, #0xe04]
	ldr r0, =TripleGrindRail__State_216492C
	orr r1, r1, #2
	str r1, [r6, #0xe04]
	add sp, sp, #0x50
	str r0, [r6, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164280:
	sub r0, r1, #0x9600
	cmp r0, r2
	bgt _021642A8
	ldr r0, [r6, #0xe04]
	orr r0, r0, #1
	str r0, [r6, #0xe04]
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #0x200000
	str r0, [r4, #0x5d8]
	b _021642C0
_021642A8:
	ldr r0, =0xFFFE0200
	add r0, r1, r0
	cmp r0, r2
	ldrle r0, [r6, #0xe04]
	orrle r0, r0, #1
	strle r0, [r6, #0xe04]
_021642C0:
	ldr r0, [r6, #0xe0c]
	add r0, r0, #0x10
	str r0, [r6, #0xe0c]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r6, #0xe0c]
	ldr r1, [r6, #0xe0c]
	mov r0, #0x600
	mul r2, r1, r0
	mov r0, r2, asr #0xb
	add r0, r2, r0, lsr #20
	ldr r1, =g_obj
	mov r0, r0, asr #0xc
	str r0, [r1, #0x14]
	ldr r0, =mapCamera
	ldr r2, [r6, #0xe0c]
	ldr r0, [r0, #0xe0]
	mov r1, r2, lsl #1
	tst r0, #1
	add r5, r1, r2, lsl #2
	beq _02164330
	mov r1, r5
	mov r0, #0
	bl MapFarSys__AdvanceScrollSpeed
	mov r1, r5
	mov r0, #1
	bl MapFarSys__AdvanceScrollSpeed
	b _0216433C
_02164330:
	ldrb r0, [r4, #0x5d3]
	mov r1, r5
	bl MapFarSys__AdvanceScrollSpeed
_0216433C:
	ldr r0, [r6, #0xe0c]
	ldr r2, =0x88888889
	mov r1, r0, lsl #0xc
	mov r0, r1, asr #0xb
	add r0, r1, r0, lsr #20
	mov r0, r0, asr #0xc
	mov r7, r0, lsl #2
	mov r3, r7, lsl #0xe
	smull r0, r5, r2, r3
	mov r0, r3, lsr #0x1f
	add r5, r5, r7, lsl #14
	mov r1, #0
	add r5, r0, r5, asr #5
	add r4, r6, #0x3fc
	mov r2, r1
	str r7, [r6, #0x47c]
	mov r5, r5, asr #0xe
	add r3, r6, #0xe00
	add r0, r4, #0x800
	strh r5, [r3, #0x14]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, =TripleGrindRail__LeafParticleDefaultScale
	add r4, r6, #0x218
	mov r5, #0x1100
	str r5, [sp, #0x1c]
	add r3, sp, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x190000
	str r0, [sp, #0x14]
	add r0, r6, #0x4e0
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r7, =TripleGrindRail__Singleton
	rsb r0, r0, #0
	add r4, r4, #0xc00
	mvn r11, #0
	mov r5, #0
	str r0, [sp, #0x14]
_021643D8:
	ldr r0, [r4, #4]
	cmp r0, #0x100000
	moveq r11, r5
	beq _02164514
	ldr r0, [r7, #0]
	ldrh r1, [r4, #8]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	add r0, r0, r0, asr #2
	sub r0, r1, r0
	strh r0, [r4, #8]
	ldrh r1, [r4, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bls _02164424
	ldr r0, [r4, #4]
	ldr r1, [sp, #0x14]
	cmp r0, r1
	bge _02164434
_02164424:
	mov r0, #0x100000
	str r0, [r4, #4]
	mov r11, r5
	b _02164514
_02164434:
	ldr r2, [r7, #0]
	add r1, sp, #0x44
	add r2, r2, #0xe00
	ldrh r8, [r2, #0x14]
	mov r2, #0
	add r3, sp, #0x38
	mov r8, r8, lsl #4
	rsb r8, r8, #0
	add r0, r0, r8
	str r0, [r4, #4]
	ldrh r0, [r4, #0xa]
	ldrh r10, [r4, #8]
	ldr ip, [r4]
	add r8, r0, r0, lsl #6
	ldr r0, [sp, #0x10]
	mov r10, r10, asr #4
	add r0, r0, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldr r9, [r7, #0]
	add r8, r8, r10, lsl #2
	ldrsh r10, [r8, #2]
	ldr r8, [r9, #0x44]
	smull lr, ip, r10, ip
	adds lr, lr, #0x800
	mov r10, r2
	adc r10, ip, r10
	mov ip, lr, lsr #0xc
	orr ip, ip, r10, lsl #20
	add r10, r8, ip
	ldr r8, =0x00141BB2
	add r8, r10, r8
	str r8, [sp, #0x44]
	ldr r8, [r9, #0x48]
	ldr r9, [r4, #4]
	add r8, r9, r8
	str r8, [sp, #0x48]
	ldrh r8, [r4, #8]
	ldr r9, [r4, #0]
	mov r8, r8, asr #4
	mov r10, r8, lsl #2
	ldr r8, =FX_SinCosTable_
	ldrsh r8, [r8, r10]
	smull r10, r9, r8, r9
	adds r10, r10, #0x800
	mov r8, r2
	adc r8, r9, r8
	mov r9, r10, lsr #0xc
	orr r9, r9, r8, lsl #20
	str r9, [sp, #0x4c]
	add r8, sp, #0x1c
	str r8, [sp]
	mov r8, r2
	str r8, [sp, #4]
	str r8, [sp, #8]
	str r8, [sp, #0xc]
	bl StageTask__Draw3DEx
_02164514:
	add r5, r5, #1
	cmp r5, #0x40
	add r4, r4, #0xc
	blt _021643D8
	ldr r0, [r6, #0xe04]
	tst r0, #3
	bne _021645A4
	add r0, r6, #0xe00
	ldrsh r1, [r0, #0x16]
	sub r1, r1, #1
	strh r1, [r0, #0x16]
	ldrsh r0, [r0, #0x16]
	cmp r0, #0
	bgt _021645A4
	mvn r0, #0
	cmp r11, r0
	beq _021645A4
	ldr r1, =TripleGrindRail__Singleton
	add r0, r6, #0x218
	ldr r3, [r1, #0]
	add r2, r0, #0xc00
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r11, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateLeafParticle
	mov r0, r4, asr #5
	add r1, r0, r4, asr #3
	cmp r1, #3
	movlt r1, #3
	blt _0216459C
	cmp r1, #0x30
	movgt r1, #0x30
_0216459C:
	add r0, r6, #0xe00
	strh r1, [r0, #0x16]
_021645A4:
	ldr r0, =TripleGrindRail__MushroomDefaultScale
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	mov r5, #0x1100
	add r4, r6, #0x11c
	str r5, [sp, #0x18]
	add r5, r4, #0x1000
	stmia r3, {r0, r1, r2}
	ldr r4, =FX_SinCosTable_
	mvn r8, #0
	mov r7, #0
	add r9, r6, #0x2f8
_021645D4:
	ldr r0, [r5, #4]
	cmp r0, #0x100000
	moveq r8, r7
	beq _021646D4
	ldr r0, =TripleGrindRail__Singleton
	ldrh r1, [r5, #8]
	ldr r0, [r0, #0]
	add r0, r0, #0xe00
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	strh r0, [r5, #8]
	ldrh r1, [r5, #8]
	ldr r0, =0x00006AAC
	cmp r1, r0
	bhi _02164620
	mov r0, #0x100000
	str r0, [r5, #4]
	mov r8, r7
	b _021646D4
_02164620:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	add r0, r4, r0, lsl #2
	ldrsh r3, [r0, #2]
	ldr r2, [r5, #0]
	ldr r0, =TripleGrindRail__Singleton
	smull r11, r10, r3, r2
	adds r3, r11, #0x800
	ldr r1, [r0, #0]
	adc r2, r10, #0
	mov r3, r3, lsr #0xc
	ldr r0, [r1, #0x44]
	orr r3, r3, r2, lsl #20
	add r2, r0, r3
	ldr r0, =0x00141BB2
	add r3, sp, #0x20
	add r0, r2, r0
	str r0, [sp, #0x2c]
	ldr r1, [r1, #0x48]
	ldr r2, [r5, #4]
	add r0, r9, #0x800
	add r1, r2, r1
	str r1, [sp, #0x30]
	ldrh r2, [r5, #8]
	ldr r11, [r5, #0]
	add r1, sp, #0x2c
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r10, [r4, r2]
	mov r2, #0
	smull ip, r11, r10, r11
	adds r10, ip, #0x800
	mov ip, r2
	adc r11, r11, ip
	mov r10, r10, lsr #0xc
	orr r10, r10, r11, lsl #20
	str r10, [sp, #0x34]
	add r10, sp, #0x18
	str r10, [sp]
	mov r10, r2
	str r10, [sp, #4]
	str r10, [sp, #8]
	str r10, [sp, #0xc]
	bl StageTask__Draw3DEx
_021646D4:
	add r7, r7, #1
	cmp r7, #8
	add r5, r5, #0xc
	blt _021645D4
	ldr r0, [r6, #0xe04]
	tst r0, #3
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r6, #0x1100
	ldrsh r1, [r0, #0x18]
	sub r1, r1, #1
	strh r1, [r0, #0x18]
	ldrsh r0, [r0, #0x18]
	cmp r0, #0
	addgt sp, sp, #0x50
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r0, #0
	cmp r8, r0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, =TripleGrindRail__Singleton
	add r0, r6, #0x11c
	ldr r3, [r1, #0]
	add r2, r0, #0x1000
	add r0, r3, #0xe00
	ldrh r3, [r0, #0x14]
	mov r1, #0xc
	mla r0, r8, r1, r2
	rsb r4, r3, #0x100
	bl TripleGrindRail__CreateMushroomParticle
	cmp r4, #0x14
	movlt r4, #0x14
	blt _02164760
	cmp r4, #0xa5
	movgt r4, #0xa5
_02164760:
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r5, [r3, #0]
	ldr r1, =0x3C6EF35F
	add r2, r6, #0x1100
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, r4
	strh r0, [r2, #0x18]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void TripleGrindRail__CreateLeafParticle(TripleGrindRailParticle *particle)
{
    u16 particleIDsArray[8];
    ARRAY_COPY(particleIDsArray, TripleGrindRail__ParticleIDs);
    s32 newY                    = 0x80 - mtMathRandRepeat(0x200);
    particle->y                 = FX32_FROM_WHOLE(newY);
    s32 randVal                 = mtMathRandRepeat(0x40) - 0x1F;
    particle->radius            = randVal * FLOAT_TO_FX32(3.2998046875) + FLOAT_TO_FX32(321.73095703125);
    particle->angle             = FLOAT_TO_FX32(13.3330078125);
    int bitShiftKeep3LowestBits = sizeof(s32) * 8 - 3; // Keep only 3 bits (8-element array)
    u32 randIndex               = (u32)(((s32)mtMathRand()) << bitShiftKeep3LowestBits) >> bitShiftKeep3LowestBits;
    particle->id                = particleIDsArray[randIndex];
}

void TripleGrindRail__CreateMushroomParticle(TripleGrindRailParticle *particle)
{
    particle->y      = FX32_FROM_WHOLE(mtMathRandRepeat(0x20) + 8);
    particle->radius = FLOAT_TO_FX32(463.62255859375);
    particle->angle  = FLOAT_TO_FX32(13.55517578125);
}

void TripleGrindRail__State_216492C(TripleGrindRail *work)
{
    if (work->gameWork.parent->userTimer != 0)
        work->field_E10 = work->gameWork.parent->userTimer;
    work->gameWork.objWork.offset.x = FLOAT_TO_FX32(321.73095703125);
    work->gameWork.objWork.offset.z = work->field_E10;
    if (work->gameWork.parent->userWork == 0)
        return;
    SetTaskState(&work->gameWork.objWork, TripleGrindRail__State_216497C);
    work->gameWork.objWork.userWork = work->gameWork.parent->userWork;
}

void TripleGrindRail__State_216497C(TripleGrindRail *work)
{
    work->gameWork.objWork.userWork--;
    if (work->gameWork.objWork.userWork == 0)
        DestroyStageTask(&work->gameWork.objWork);
    work->gameWork.objWork.offset.x = FLOAT_TO_FX32(321.73095703125);
    work->gameWork.objWork.offset.z = work->field_E10;
}

NONMATCH_FUNC void TripleGrindRail__OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	ldmneia sp!, {r4, pc}
	ldr r2, [r0, #0xf4]
	ldr r1, =Player__State_TripleGrindRailStartSpring
	cmp r2, r1
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0xe04]
	mov r1, r4
	bic r2, r2, #1
	str r2, [r4, #0xe04]
	ldr r2, [r4, #0x230]
	bic r2, r2, #4
	str r2, [r4, #0x230]
	str r0, [r4, #0x35c]
	bl Player__Action_TripleGrindRailEndSpring
	mov r0, #0x2000
	bl SetStageRingScale
	ldr r1, =TripleGrindRail__State_21640DC
	mov r0, #0x3000
	str r1, [r4, #0xf4]
	strh r0, [r4, #0x30]
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0x47c]
	str r4, [r4, #0x2d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__State_Inactive(TripleGrindRailEntity *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =TripleGrindRail__Singleton
	mov r4, r0
	ldr r2, [r1, #0]
	cmp r2, #0
	beq _02164A64
	ldr r1, [r2, #0xe04]
	tst r1, #3
	beq _02164A74
_02164A64:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_02164A74:
	ldr r1, [r2, #0x44]
	ldr r2, [r4, #0x44]
	add r1, r1, #0xa0000
	cmp r2, r1
	ldmgtia sp!, {r4, pc}
	ldr r2, =0x0000CE38
	add r1, r4, #0x400
	strh r2, [r1, #0x7c]
	ldr r2, [r4, #0x20]
	ldr r1, =TripleGrindRailEntity__State_Active
	bic r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	bl TripleGrindRailEntity__State_Active
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x7b
	ldreq r0, =TripleGrindRailEntity__Draw
	streq r0, [r4, #0xfc]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__State_Active(TripleGrindRailEntity *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r3, =TripleGrindRail__Singleton
	ldr r4, [r3, #0]
	cmp r4, #0
	ldrne r1, =g_obj
	ldrne r1, [r1, #0x14]
	cmpne r1, #0
	beq _02164B00
	ldr r1, [r4, #0xe04]
	tst r1, #2
	beq _02164B10
_02164B00:
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B10:
	add r2, r0, #0x400
	add r1, r4, #0xe00
	ldrh ip, [r2, #0x7c]
	ldrh r4, [r1, #0x14]
	ldr r1, =0x000071C8
	sub r4, ip, r4
	strh r4, [r2, #0x7c]
	ldrh r2, [r2, #0x7c]
	cmp r2, r1
	bhi _02164B48
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
_02164B48:
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #2]
	cmp r1, #0x7a
	bne _02164B68
	ldr r1, [r3, #0]
	ldr r1, [r1, #0x47c]
	mov r1, r1, asr #1
	str r1, [r0, #0x42c]
_02164B68:
	add r2, r0, #0x400
	ldrh r3, [r2, #0x7c]
	ldr r1, =TripleGrindRail__Singleton
	ldr lr, =FX_SinCosTable_
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh ip, [lr, r3]
	ldr r3, [r0, #0x478]
	ldr r4, [r1, #0]
	smull r3, r1, ip, r3
	adds r3, r3, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	ldr ip, [r4, #0x44]
	orr r3, r3, r1, lsl #20
	ldr r1, =0x00141BB2
	add r3, ip, r3
	add r1, r3, r1
	str r1, [r0, #0x44]
	ldrh r2, [r2, #0x7c]
	ldr r1, [r0, #0x478]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [lr, r2]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x4c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x354]
	mov r2, #0
	tst r0, #1
	add r0, sp, #0x10
	beq _02164C70
	mov r1, #0x100
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw3DEx
	ldr r0, [sp, #0x10]
	tst r0, #0x40000000
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x18]
	add sp, sp, #0x14
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02164C70:
	ldr r1, =0x00001104
	add r3, r4, #0x38
	str r1, [sp, #0x10]
	str r0, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, =TripleGrindRail__Singleton
	str r2, [sp, #0xc]
	ldr r0, [r0, #0]
	add r1, r4, #0x44
	add r0, r0, #0x3fc
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailEntity__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0, #0]
	cmp r1, #1
	ldreqb r1, [r0, #0x5d1]
	cmpeq r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl Player__GiveRings
	ldr r1, [r4, #0x354]
	mov r0, #0
	orr r1, r1, #1
	orr r1, r1, #0x10000
	str r1, [r4, #0x354]
	str r0, [r4, #0x234]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailRingLoss__State_Active(TripleGrindRailRingLoss *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r1, =TripleGrindRail__Singleton
	mov r10, r0
	ldr r1, [r1, #0]
	ldr r6, [r10, #0x168]
	cmp r1, #0
	ldrne r0, =g_obj
	mov r11, #1
	ldrne r0, [r0, #0x14]
	cmpne r0, #0
	beq _02164D44
	ldr r0, [r1, #0xe04]
	tst r0, #2
	beq _02164D58
_02164D44:
	ldr r0, [r10, #0x18]
	add sp, sp, #0xc
	orr r0, r0, #4
	str r0, [r10, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02164D58:
	add r7, r10, #0x16c
	add r0, r10, #0x6c
	cmp r6, #0
	add r8, r0, #0x400
	add r9, r7, #0x400
	mov r5, #0
	ble _02164DEC
	mov r4, r5
_02164D78:
	ldr r1, [r7, #0]
	ldr r0, [r8, #0]
	mov r2, #0x20
	add r0, r1, r0
	str r0, [r7]
	ldr r0, =0x02118D5C
	ldr r1, [r9, #0]
	ldrsh r0, [r0, #0]
	ldr r3, [r7, #4]
	add r1, r1, r0
	add r1, r3, r1
	str r1, [r7, #4]
	ldr r1, [r9, #0]
	mov r3, r4
	add r0, r1, r0
	str r0, [r9]
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldmia r7, {r0, r1}
	bl StageTask__ViewOutCheck
	cmp r0, #0
	add r5, r5, #1
	moveq r11, #0
	cmp r5, r6
	add r7, r7, #0xc
	add r8, r8, #4
	add r9, r9, #4
	blt _02164D78
_02164DEC:
	cmp r11, #0
	ldrne r0, [r10, #0x18]
	orrne r0, r0, #4
	strne r0, [r10, #0x18]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void TripleGrindRailRingLoss__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x38
	add r7, sp, #0x14
	ldmia r0, {r0, r1, r2}
	ldr r3, =0x00001104
	stmia r7, {r0, r1, r2}
	str r3, [sp, #0x10]
	ldr r9, [r4, #0x168]
	mov r8, #0
	cmp r9, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r10, r4, #0x16c
	ldr r4, =TripleGrindRail__Singleton
	add r6, sp, #0x10
	mov r5, r8
_02164E5C:
	str r6, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	str r5, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r1, r10
	add r0, r0, #0x3fc
	mov r2, r5
	mov r3, r7
	add r0, r0, #0x800
	bl StageTask__Draw3DEx
	add r8, r8, #1
	cmp r8, r9
	add r10, r10, #0xc
	blt _02164E5C
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}