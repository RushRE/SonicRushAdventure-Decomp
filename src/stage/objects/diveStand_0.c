#include <stage/objects/diveStand.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// CONSTANTS
// --------------------

#define DIVESTAND_DRAWLIST_SIZE 0x400

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *aActAcGmkDiveSt;

NONMATCH_FUNC DiveStand *DiveStand__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/KuNjX -> 94.89%
#ifdef NON_MATCHING
    Task *task;
    DiveStand *work;

    s32 i;
    AnimatorSprite3D* aniDiveStand;
    
    task = CreateStageTask(DiveStand__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), DiveStand);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, DiveStand);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->drawData   = HeapAllocHead(HEAP_SYSTEM, DIVESTAND_DRAWLIST_SIZE);
    work->dword70C = 4096;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    aniDiveStand = &work->aniDiveStand[0];
    work->sprDiveStand3D = ObjDataLoad(GetObjectDataWork(OBJDATAWORK_168), "/act/ac_gmk_dive_stand3d.bac", gameArchiveStage);

    VRAMPaletteKey paletteKey = ObjActionAllocPalette(GetObjectGraphicsRef(OBJDATAWORK_172), Sprite__GetPaletteSizeFromAnim(work->sprDiveStand3D, 0));
    for (i = 0; i < 1; )
    {
        VRAMPixelKey pixelKey = ObjActionAllocTexture(GetObjectGraphicsRef(i + OBJDATAWORK_169), Sprite__GetTextureSizeFromAnim(work->sprDiveStand3D, i));
        AnimatorSprite3D__Init(aniDiveStand, 0, work->sprDiveStand3D, i, ANIMATOR_FLAG_NONE, pixelKey, paletteKey);
        AnimatorSprite3D__ProcessAnimationFast(aniDiveStand);

        i++;
        aniDiveStand++;
    }
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_VRAM_A;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dive_stand3d.bac", GetObjectDataWork(OBJDATAWORK_168), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 1, GetObjectSpriteRef(OBJDATAWORK_173));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 1, 60);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 1);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__ProcessAnimationFast(&work->gameWork.animator.ani);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;

    G3_BeginMakeDL(&work->drawList, work->drawData, DIVESTAND_DRAWLIST_SIZE);
    G3C_PolygonAttr(&work->drawList, 
                    GX_LIGHTID_0, 
                    GX_POLYGONMODE_MODULATE, 
                    GX_CULL_NONE, 
                    0, 
                    GX_COLOR_FROM_888(0xFF), 
                    GX_POLYGON_ATTR_MISC_NONE);

    G3C_TexPlttBase(&work->drawList, 
                    VRAMKEY_TO_KEY(work->aniDiveStand[0].animatorSprite.vramPalette) & 0x1FFFF, 
                    GX_TEXFMT_PLTT16);

    G3C_TexImageParam(&work->drawList, 
                      GX_TEXFMT_PLTT16, 
                      GX_TEXGEN_TEXCOORD, 
                      GX_TEXSIZE_S8, 
                      GX_TEXSIZE_T8, 
                      GX_TEXREPEAT_S, 
                      GX_TEXFLIP_NONE, 
                      GX_TEXPLTTCOLOR0_TRNS,
                      VRAMKEY_TO_KEY(work->aniDiveStand[0].animatorSprite.vramPixels) & 0x7FFFF);
    G3C_MtxMode(&work->drawList, GX_MTXMODE_TEXTURE);

    FXMatrix43 mtx;
    MTX_Identity43(mtx.nnMtx);
    G3C_LoadMtx43(&work->drawList, mtx.nnMtx);
    G3C_MtxMode(&work->drawList, GX_MTXMODE_POSITION);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    if (mapObject->id == MAPOBJECT_143)
        ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -16, -16, 208, 192);
    else
        ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, 16, -16, -208, 192);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], DiveStand__OnDefend_DiveStandSolid);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -8, -16, 8, 16);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], DiveStand__OnDefend_DiveTrigger);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET | OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 192;
    work->gameWork.collisionObject.work.height    = 16;
    if (mapObject->id == MAPOBJECT_143)
        work->gameWork.collisionObject.work.ofst_x = 0;
    else
        work->gameWork.collisionObject.work.ofst_x = -192;
    work->gameWork.collisionObject.work.ofst_y = 0;

    SetTaskOutFunc(&work->gameWork.objWork, DiveStand__Draw);
    SetTaskState(&work->gameWork.objWork, DiveStand__State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	ldr r3, =0x000010F6
	mov r10, r0
	str r3, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r6, =0x00000714
	ldr r0, =StageTask_Main
	ldr r1, =DiveStand__Destructor
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r6, r0
	addeq sp, sp, #0x44
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r6
	bl GetTaskWork_
	ldr r2, =0x00000714
	mov r6, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	mov r1, r10
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	mov r0, #0x400
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r6, #0x480]
	mov r0, #0x1000
	str r0, [r6, #0x70c]
	ldr r0, [r6, #0x1c]
	add r8, r6, #0x368
	orr r0, r0, #0x2100
	str r0, [r6, #0x1c]
	mov r0, #0xa8
	bl GetObjectFileWork
	ldr r2, =gameArchiveStage
	ldr r1, =aActAcGmkDiveSt
	ldr r2, [r2, #0]
	bl ObjDataLoad
	str r0, [r6, #0x364]
	mov r0, #0xac
	bl GetObjectFileWork
	mov r4, r0
	ldr r0, [r6, #0x364]
	mov r1, #0
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, r0
	mov r0, r4
	bl ObjActionAllocPalette
	mov r7, #0
	mov r9, r0
	mov r4, r7
	mov r11, r7
	b _02169C60
_02169C00:
	add r0, r7, #0xa9
	bl GetObjectFileWork
	mov r5, r0
	mov r1, r7, lsl #0x10
	ldr r0, [r6, #0x364]
	mov r1, r1, lsr #0x10
	bl Sprite__GetTextureSizeFromAnim
	mov r1, r0
	mov r0, r5
	bl ObjActionAllocTexture
	str r4, [sp]
	stmib sp, {r0, r9}
	mov r3, r7, lsl #0x10
	ldr r2, [r6, #0x364]
	mov r0, r8
	mov r1, r4
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	mov r0, r8
	mov r1, r11
	mov r2, r11
	bl AnimatorSprite3D__ProcessAnimation
	add r7, r7, #1
	add r8, r8, #0x104
_02169C60:
	cmp r7, #1
	blt _02169C00
	ldr r1, [r6, #0x18]
	mov r0, #0xa8
	orr r1, r1, #0x400000
	str r1, [r6, #0x18]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, =aActAcGmkDiveSt
	str r1, [sp]
	mov r4, #0
	mov r0, r6
	add r1, r6, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xad
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r6
	mov r1, #1
	bl ObjObjectActionAllocSprite
	mov r0, r6
	mov r1, #1
	mov r2, #0x3c
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r6
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r1, [r6, #0x1a4]
	add r0, r6, #0x168
	orr r1, r1, #0x30
	str r1, [r6, #0x1a4]
	mov r1, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r1, [r6, #0x1a4]
	add r0, r6, #0x6c
	orr r1, r1, #8
	str r1, [r6, #0x1a4]
	ldr r1, [r6, #0x20]
	add r0, r0, #0x400
	orr r1, r1, #0x1000
	str r1, [r6, #0x20]
	ldr r1, [r6, #0x480]
	mov r2, #0x400
	bl G3_BeginMakeDL
	mov r1, r4
	str r1, [sp]
	mov r0, #0x1f
	stmib sp, {r0, r1}
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r2, r1
	mov r3, #3
	bl G3C_PolygonAttr
	ldr r1, [r6, #0x444]
	ldr r0, =0x0001FFFF
	add r2, r6, #0x6c
	and r1, r1, r0
	add r0, r2, #0x400
	mov r2, #3
	bl G3C_TexPlttBase
	ldr r4, [r6, #0x43c]
	mov r3, #0
	str r3, [sp]
	mov r2, #1
	ldr r0, =0x0007FFFF
	stmib sp, {r2, r3}
	add r1, r6, #0x6c
	and r4, r4, r0
	str r2, [sp, #0xc]
	add r0, r1, #0x400
	mov r1, #3
	str r4, [sp, #0x10]
	bl G3C_TexImageParam
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r1, #3
	bl G3C_MtxMode
	add r0, sp, #0x14
	bl MTX_Identity43_
	add r0, r6, #0x6c
	add r1, sp, #0x14
	add r0, r0, #0x400
	bl G3C_LoadMtx43
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r1, #1
	bl G3C_MtxMode
	str r6, [r6, #0x234]
	ldrh r0, [r10, #2]
	mov r4, #0xc0
	cmp r0, #0x8f
	bne _02169E14
	sub r1, r4, #0xd0
	mov r2, r1
	add r0, r6, #0x218
	mov r3, #0xd0
	str r4, [sp]
	bl ObjRect__SetBox2D
	b _02169E2C
_02169E14:
	mov r1, #0x10
	add r0, r6, #0x218
	sub r2, r1, #0x20
	sub r3, r1, #0xe0
	str r4, [sp]
	bl ObjRect__SetBox2D
_02169E2C:
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r6, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =DiveStand__OnDefend_DiveStandSolid
	mov r2, #0x10
	str r1, [r6, #0x23c]
	str r6, [r6, #0x274]
	add r0, r6, #0x258
	str r2, [sp]
	sub r1, r2, #0x18
	sub r2, r2, #0x20
	mov r3, #8
	bl ObjRect__SetBox2D
	ldr r1, [r6, #0x44]
	add r0, r6, #0x258
	mov r1, r1, asr #0xc
	str r1, [r6, #0x264]
	ldr r2, [r6, #0x48]
	mov r1, #0
	mov r2, r2, asr #0xc
	str r2, [r6, #0x268]
	ldr r3, [r6, #0x4c]
	mov r2, r1
	mov r3, r3, asr #0xc
	str r3, [r6, #0x26c]
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r6, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =DiveStand__OnDefend_DiveTrigger
	mov r2, #0
	str r0, [r6, #0x27c]
	ldr r1, [r6, #0x270]
	ldr r0, =StageTask__DefaultDiffData
	orr r1, r1, #0x1400
	str r1, [r6, #0x270]
	str r2, [r6, #0x13c]
	str r0, [r6, #0x2fc]
	mov r1, #0xc0
	add r0, r6, #0x300
	strh r1, [r0, #8]
	mov r1, #0x10
	strh r1, [r0, #0xa]
	ldrh r0, [r10, #2]
	cmp r0, #0x8f
	addeq r0, r6, #0x200
	streqh r2, [r0, #0xf0]
	subne r1, r1, #0xd0
	addne r0, r6, #0x200
	strneh r1, [r0, #0xf0]
	add r0, r6, #0x200
	mov r1, #0
	strh r1, [r0, #0xf2]
	ldr r2, =DiveStand__Draw
	ldr r1, =DiveStand__State_Active
	str r2, [r6, #0xfc]
	mov r0, r6
	str r1, [r6, #0xf4]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}