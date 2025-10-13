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

NOT_DECOMPILED void *_02188580;
NOT_DECOMPILED void *aActAcGmkDiveSt;

NONMATCH_FUNC DiveStand *DiveStand__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/KuNjX -> 84.77%
#ifdef NON_MATCHING
    Task *task = CreateStageTask(DiveStand__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), DiveStand);
    if (task == HeapNull)
        return NULL;

    DiveStand *work = TaskGetWork(task, DiveStand);
    TaskInitWork8(task);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->drawData = HeapAllocHead(HEAP_SYSTEM, DIVESTAND_DRAWLIST_SIZE);
    work->dword70C = 4096;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->sprDiveStand3D = ObjDataLoad(GetObjectDataWork(OBJDATAWORK_168), "/act/ac_gmk_dive_stand3d.bac", gameArchiveStage);

    VRAMPaletteKey paletteKey = ObjActionAllocPalette(GetObjectGraphicsRef(OBJDATAWORK_172), Sprite__GetPaletteSizeFromAnim(work->sprDiveStand3D, 0));
    for (s32 i = 0; i < 1; i++)
    {
        VRAMPixelKey pixelKey = ObjActionAllocTexture(GetObjectGraphicsRef(i + OBJDATAWORK_169), Sprite__GetTextureSizeFromAnim(work->sprDiveStand3D, i));
        AnimatorSprite3D__Init(&work->aniDiveStand[i], ANIMATOR_FLAG_NONE, work->sprDiveStand3D, i, ANIMATOR_FLAG_NONE, pixelKey, paletteKey);
        AnimatorSprite3D__ProcessAnimationFast(&work->aniDiveStand[i]);
    }
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_VRAM_A;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dive_stand3d.bac", GetObjectDataWork(OBJDATAWORK_168), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 1, GetObjectSpriteRef(OBJDATAWORK_173));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 1, 60);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 1);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__ProcessAnimation(&work->gameWork.animator.ani, 0, 0);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;

    G3_BeginMakeDL(&work->drawList, work->drawData, DIVESTAND_DRAWLIST_SIZE);
    G3C_PolygonAttr(&work->drawList, GX_LIGHTID_0, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_NONE);
    G3C_TexPlttBase(&work->drawList, VRAMKEY_TO_KEY(work->aniDiveStand[0].animatorSprite.vramPalette) & 0x1FFFF, GX_TEXFMT_PLTT16);
    G3C_TexImageParam(&work->drawList, GX_TEXFMT_PLTT16, GX_TEXGEN_TEXCOORD, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_S, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS,
                      VRAMKEY_TO_KEY(work->aniDiveStand[0].animatorSprite.vramPixels) & 0x7FFFF);
    G3C_MtxMode(&work->drawList, GX_MTXMODE_TEXTURE);

    MtxFx43 mtx;
    MTX_Identity43(&mtx);
    G3C_LoadMtx43(&work->drawList, &mtx);
    G3C_MtxMode(&work->drawList, GX_MTXMODE_POSITION);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    if (mapObject->id == MAPOBJECT_143)
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -16, -16, 208, 192);
    else
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, 16, -16, -208, 192);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], DiveStand__OnDefend_DiveStandSolid);

    work->gameWork.colliders[1].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -8, -16, 8, 16);
    work->gameWork.colliders[1].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[1].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y);
    work->gameWork.colliders[1].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);
    ObjRect__SetAttackStat(&work->gameWork.colliders[1], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], DiveStand__OnDefend_DiveTrigger);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET | OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

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

void DiveStand__Func_2169F6C(DiveStand *work)
{
    work->gameWork.flags &= ~(1 | 4);
}

void DiveStand__Destructor(Task *task)
{
    DiveStand *work = TaskGetWork(task, DiveStand);

    HeapFree(HEAP_SYSTEM, work->drawData);

    OBS_TEXTURE_REF *ref = GetObjectTextureRef(OBJDATAWORK_172);
    ref->texture.referenceCount--;

    if (ref->texture.referenceCount == 0)
    {
        VRAMSystem__FreePalette(ref->texture.vramPixels);
        ref->texture.vramPixels = NULL;
    }

    for (s32 i = 0; i < 2; i++)
    {
        ref = GetObjectTextureRef(i + OBJDATAWORK_169);

        ref->texture.referenceCount--;
        if (ref->texture.referenceCount == 0)
        {
            VRAMSystem__FreeTexture(ref->texture.vramPixels);
            ref->texture.vramPixels = NULL;
        }
    }

    ObjDataRelease(GetObjectDataWork(OBJDATAWORK_168));
    GameObject__Destructor(task);
}

NONMATCH_FUNC void DiveStand__State_Active(DiveStand *work)
{
    // https://decomp.me/scratch/jFmka -> 87.71%
#ifdef NON_MATCHING
    s32 i;

    Player *player = gPlayer;

    fx32 playerX  = gPlayer->objWork.position.x;
    fx32 distance = playerX - work->gameWork.objWork.position.x;

    if ((work->gameWork.flags & 1) != 0)
    {
        if (CheckPlayerGimmickObj(gPlayer, work))
        {
            u16 targetAngle;
            s16 angleStep;
            if ((work->gameWork.flags & 4) != 0)
            {
                targetAngle = 0xFD60;
                angleStep   = -16;
            }
            else
            {
                targetAngle = 0xFEAB;
                angleStep   = -128;
            }

            VecFx32 *vertices = &work->vertices[23][1];
            u16 *angles       = &work->angles[22];
            for (i = 22; i >= 0; vertices -= 2, angles--, i--)
            {
                if ((work->gameWork.mapObject->id == MAPOBJECT_143 && distance <= 8 * vertices->x)
                    || (work->gameWork.mapObject->id == MAPOBJECT_149 && distance >= 8 * vertices->x))
                {
                    *angles += 16;
                    if ((s16)*angles > 0)
                        *angles = 0;
                    continue;
                }

                if (*angles != 0)
                {
                    *angles += angleStep;
                    if (*angles < targetAngle)
                        *angles = targetAngle;
                    continue;
                }

                *angles = angleStep;
                break;
            }

            if ((work->gameWork.flags & 4) != 0)
            {
                if (work->angles[22] == 0xFD60 && work->angles[0] == 0xFD60 && work->dword70C >= FLOAT_TO_FX32(1.5))
                {
                    work->gameWork.flags &= ~5;
                    work->gameWork.flags |= 8;
                    work->field_710 = 16;
                }
                else
                {
                    work->dword70C += 64;
                    if (work->dword70C > FLOAT_TO_FX32(1.5))
                        work->dword70C = FLOAT_TO_FX32(1.5);
                }
            }
            else
            {
                if (work->dword70C > FLOAT_TO_FX32(1.0))
                {
                    work->dword70C -= 64;
                    if (work->dword70C < FLOAT_TO_FX32(1.0))
                        work->dword70C = FLOAT_TO_FX32(1.0);
                }
            }
        }
        else
        {
            DiveStand__Func_2169F6C(work);
        }
    }
    else
    {
        if ((work->gameWork.flags & 2) != 0)
        {
            BOOL moved = FALSE;
            s16 step   = -16;
            if (work->dword70C > FLOAT_TO_FX32(1.0))
            {
                work->dword70C -= 64;
                if (work->dword70C < FLOAT_TO_FX32(1.0))
                    work->dword70C = FLOAT_TO_FX32(1.0);
            }

            if ((work->gameWork.flags & 8) != 0)
                step <<= 2;

            u16 *angles = &work->angles[0];
            for (i = 0; i < 23; i++)
            {
                if (*angles != FLOAT_DEG_TO_IDX(0.0))
                {
                    *angles -= step;
                    moved = TRUE;
                    if ((s16)*angles > 0)
                        *angles = 0;
                }

                angles++;
            }

            if (!moved)
            {
                work->gameWork.flags &= ~2;
                if ((work->gameWork.flags & 8) != 0)
                {
                    fx32 force = work->gameWork.mapObject->left;

                    fx32 velX = (force << 11) + FLOAT_TO_FX32(2.0);
                    if (work->gameWork.mapObject->id == MAPOBJECT_149)
                        velX = -velX;
                    Player__Action_DiveStandLaunch(player, &work->gameWork, velX, -FLOAT_TO_FX32(1.5) * force - FLOAT_TO_FX32(7.5));
                    Player__Action_AllowTrickCombos(player, &work->gameWork);
                }
            }
        }
        else
        {
            if (work->dword70C > FLOAT_TO_FX32(1.0))
            {
                work->dword70C -= 64;
                if (work->dword70C < FLOAT_TO_FX32(1.0))
                    work->dword70C = FLOAT_TO_FX32(1.0);
            }
        }
    }

    VecFx32 v68 = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };
    VecFx32 v69 = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) };

    fx32 v29 = work->dword70C;
    if (work->gameWork.mapObject->id != MAPOBJECT_143)
        v29 = -v29;

    VecFx32 upper;
    VecFx32 lower;
    VEC_Set(&upper, v29, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));

    work->vertices[0][0] = v69;
    work->vertices[0][1] = v68;

    MtxFx43 mtxIdentity;
    MtxFx43 mtxSegment;
    MtxFx43 mtxVertex;
    MtxFx43 mtxTranslate;
    MTX_Identity43(&mtxIdentity);
    MI_CpuCopy32(&mtxIdentity, &mtxVertex, sizeof(mtxVertex));
    MI_CpuCopy32(&mtxIdentity, &mtxTranslate, sizeof(mtxTranslate));
    MTX_TransApply43(&mtxTranslate, &mtxTranslate, upper.x, upper.y, upper.z);

    {
        VecFx32 *vertices = &work->vertices[1][0];
        u16 *angles       = &work->angles[0];
        if (work->gameWork.mapObject->id == MAPOBJECT_143)
        {
            for (i = 0; i < 24; i++)
            {
                MI_CpuCopy32(&mtxIdentity, &mtxSegment, sizeof(mtxSegment));
                VEC_Set(&lower, MultiplyFX(CosFX(*angles), v29), -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
                MTX_MultVec43(&upper, &mtxVertex, &vertices[0]);
                MTX_MultVec43(&lower, &mtxVertex, &vertices[1]);
                MTX_RotZ33((MtxFx33 *)&mtxSegment, SinFX(*angles), CosFX(*angles));
                MTX_Concat43(&mtxSegment, &mtxTranslate, &mtxSegment);
                MTX_Concat43(&mtxSegment, &mtxVertex, &mtxVertex);

                angles++;
                vertices += 2;
            }
        }
        else
        {
            for (i = 0; i < 24; i++)
            {
                MI_CpuCopy32(&mtxIdentity, &mtxSegment, sizeof(mtxSegment));
                VEC_Set(&lower, MultiplyFX(CosFX(*angles), v29), -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
                MTX_MultVec43(&upper, &mtxVertex, &vertices[0]);
                MTX_MultVec43(&lower, &mtxVertex, &vertices[1]);
                MTX_RotZ33((MtxFx33 *)&mtxSegment, SinFX((s32)(u16) - *angles), CosFX((s32)(u16) - *angles));
                MTX_Concat43(&mtxSegment, &mtxTranslate, &mtxSegment);
                MTX_Concat43(&mtxSegment, &mtxVertex, &mtxVertex);

                angles++;
                vertices += 2;
            }
        }
    }

    work->gameWork.colliders[1].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x) + (work->vertices[24][1].x >> 9);
    work->gameWork.colliders[1].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y) - (work->vertices[24][1].y >> 9);
    work->gameWork.objWork.prevPosition.x  = work->gameWork.objWork.position.x + 8 * work->vertices[24][1].x;
    work->gameWork.objWork.prevPosition.y  = work->gameWork.objWork.position.y - 8 * work->vertices[24][1].y;

    StageTaskCollisionObj *collisionObject = &work->gameWork.collisionObject.work;

    if (work->gameWork.mapObject->id != MAPOBJECT_143
        || player->objWork.position.x >= work->gameWork.objWork.position.x - 0x18000 && player->objWork.position.x <= work->gameWork.objWork.position.x + 0xD8000
               && player->objWork.position.y >= work->gameWork.objWork.position.y - 0x18000 && player->objWork.position.y <= work->gameWork.objWork.position.y + 0xD8000)
    {
        if (work->gameWork.mapObject->id != MAPOBJECT_149
            || player->objWork.position.x <= work->gameWork.objWork.position.x + 0x18000 && player->objWork.position.x >= work->gameWork.objWork.position.x - 0xD8000
                   && player->objWork.position.y >= work->gameWork.objWork.position.y - 0x18000 && player->objWork.position.y <= work->gameWork.objWork.position.y + 0xD8000)
        {
            if (work->gameWork.mapObject->id == MAPOBJECT_143 && distance <= 0 || work->gameWork.mapObject->id == MAPOBJECT_149 && distance >= 0)
            {
                if (work->gameWork.mapObject->id == MAPOBJECT_143)
                    collisionObject->ofst_x = 0;
                else
                    collisionObject->ofst_x = -192;
                collisionObject->ofst_y = 0;

                work->gameWork.objWork.userWork = 0;
            }
            else
            {
                s32 v = 0;

                VecFx32 *firstVertex = work->vertices[1];
                VecFx32 *vertices    = &work->vertices[0][0];
                u16 angle            = 0;

                if (work->gameWork.mapObject->id == MAPOBJECT_143)
                {
                    collisionObject->ofst_x = (work->vertices[24][0].x) - 192;
                    for (; v < 24; v++)
                    {
                        if (distance <= 8 * firstVertex->x)
                            break;

                        angle += work->angles[v];
                        firstVertex += 2;
                    }

                    if (v >= 24)
                    {
                        vertices -= 2;
                        firstVertex -= 2;
                    }

                    collisionObject->ofst_y =
                        -(vertices->y + ((MultiplyFX(FX_Div(distance - 8 * vertices->x, 8 * (firstVertex->x - vertices->x)), firstVertex->y - vertices->y)))) >> 9;
                    work->gameWork.objWork.userWork = 0x10000 - angle;
                }
                else
                {
                    collisionObject->ofst_x = work->vertices[24][0].x >> 9;
                    for (; v < 24; v++)
                    {
                        if (distance >= 8 * firstVertex->x)
                            break;

                        angle += work->angles[v];
                        firstVertex += 2;
                    }

                    if (v >= 24)
                    {
                        vertices -= 2;
                        firstVertex -= 2;
                    }

                    collisionObject->ofst_y =
                        -(vertices->y + ((MultiplyFX(FX_Div(distance - 8 * vertices->x, 8 * (firstVertex->x - vertices->x)), firstVertex->y - vertices->y)))) >> 9;
                    work->gameWork.objWork.userWork = angle;
                }
            }
            work->gameWork.objWork.userTimer = work->gameWork.objWork.position.y + FX32_FROM_WHOLE(collisionObject->ofst_y);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x114
	ldr r1, =gPlayer
	mov r8, r0
	ldr r1, [r1, #0]
	ldr r2, [r8, #0x354]
	str r1, [sp, #8]
	ldr r3, [r1, #0x44]
	ldr r1, [r8, #0x44]
	tst r2, #1
	sub r5, r3, r1
	beq _0216A1B0
	ldr r1, [sp, #8]
	ldr r1, [r1, #0x6d8]
	cmp r1, r8
	bne _0216A1A8
	tst r2, #4
	ldrne r3, =0x0000FD60
	mvnne r4, #0xf
	add r0, r8, #0x2b8
	add r1, r8, #0x308
	add r2, r0, #0x400
	ldreq r3, =0x0000FEAB
	mvneq r4, #0x7f
	add r1, r1, #0x400
	mov r0, #0x16
	mov r7, #0
_0216A08C:
	ldr r6, [r8, #0x340]
	ldrh r9, [r6, #2]
	cmp r9, #0x8f
	bne _0216A0A8
	ldr r6, [r2, #0]
	cmp r5, r6, lsl #3
	ble _0216A0BC
_0216A0A8:
	cmp r9, #0x95
	bne _0216A0D8
	ldr r6, [r2, #0]
	cmp r5, r6, lsl #3
	blt _0216A0D8
_0216A0BC:
	ldrh r6, [r1, #0]
	add r6, r6, #0x10
	strh r6, [r1]
	ldrsh r6, [r1, #0]
	cmp r6, #0
	strgth r7, [r1]
	b _0216A108
_0216A0D8:
	ldrh r6, [r1, #0]
	cmp r6, #0
	beq _0216A0FC
	add r6, r6, r4
	strh r6, [r1]
	ldrh r6, [r1, #0]
	cmp r6, r3
	strloh r3, [r1]
	b _0216A108
_0216A0FC:
	add r0, r6, r4
	strh r0, [r1]
	b _0216A118
_0216A108:
	sub r2, r2, #0x18
	sub r1, r1, #2
	subs r0, r0, #1
	bpl _0216A08C
_0216A118:
	ldr r3, [r8, #0x354]
	tst r3, #4
	beq _0216A184
	add r1, r8, #0x700
	ldrh r0, [r1, #8]
	ldr r2, =0x0000FD60
	cmp r0, r2
	addeq r0, r8, #0x600
	ldreqh r0, [r0, #0xdc]
	cmpeq r0, r2
	bne _0216A168
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1800
	blt _0216A168
	bic r0, r3, #5
	orr r0, r0, #8
	str r0, [r8, #0x354]
	mov r0, #0x10
	strh r0, [r1, #0x10]
	b _0216A2BC
_0216A168:
	ldr r0, [r8, #0x70c]
	add r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1800
	movgt r0, #0x1800
	strgt r0, [r8, #0x70c]
	b _0216A2BC
_0216A184:
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1000
	ble _0216A2BC
	sub r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1000
	movlt r0, #0x1000
	strlt r0, [r8, #0x70c]
	b _0216A2BC
_0216A1A8:
	bl DiveStand__Func_2169F6C
	b _0216A2BC
_0216A1B0:
	tst r2, #2
	beq _0216A29C
	ldr r2, [r8, #0x70c]
	mov r0, #0
	cmp r2, #0x1000
	sub r1, r0, #0x10
	ble _0216A1E0
	sub r2, r2, #0x40
	str r2, [r8, #0x70c]
	cmp r2, #0x1000
	movlt r2, #0x1000
	strlt r2, [r8, #0x70c]
_0216A1E0:
	ldr r2, [r8, #0x354]
	mov r7, #0
	tst r2, #8
	movne r1, r1, lsl #0x12
	add r2, r8, #0x2dc
	add r6, r2, #0x400
	movne r1, r1, asr #0x10
	mov r2, r7
	mov r4, #1
_0216A204:
	ldrh r3, [r6, #0]
	cmp r3, #0
	beq _0216A228
	sub r0, r3, r1
	strh r0, [r6]
	ldrsh r3, [r6, #0]
	mov r0, r4
	cmp r3, #0
	strgth r2, [r6]
_0216A228:
	add r7, r7, #1
	cmp r7, #0x17
	add r6, r6, #2
	blt _0216A204
	cmp r0, #0
	bne _0216A2BC
	ldr r0, [r8, #0x354]
	bic r0, r0, #2
	str r0, [r8, #0x354]
	tst r0, #8
	beq _0216A2BC
	ldr r0, [r8, #0x340]
	ldrsb r4, [r0, #6]
	ldrh r0, [r0, #2]
	mov r1, r4, lsl #0xb
	cmp r0, #0x95
	mov r0, #0x1800
	rsb r0, r0, #0
	mul r3, r4, r0
	add r2, r1, #0x2000
	ldr r0, [sp, #8]
	rsbeq r2, r2, #0
	mov r1, r8
	sub r3, r3, #0x7800
	bl Player__Action_DiveStandLaunch
	ldr r0, [sp, #8]
	mov r1, r8
	bl Player__Action_AllowTrickCombos
	b _0216A2BC
_0216A29C:
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1000
	ble _0216A2BC
	sub r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1000
	movlt r0, #0x1000
	strlt r0, [r8, #0x70c]
_0216A2BC:
	ldr r0, =_02188580
	mov r4, #0
	add r6, sp, #0xfc
	add r3, sp, #0xf0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	str r4, [r6]
	str r4, [r6, #4]
	str r4, [r6, #8]
	str r4, [sp, #0x10c]
	str r4, [sp, #0x110]
	ldr r0, [r8, #0x340]
	add r1, sp, #0xfc
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	ldr r0, [r8, #0x70c]
	streq r0, [sp, #0xc]
	streq r0, [sp, #0x108]
	rsbne r0, r0, #0
	strne r0, [sp, #0xc]
	strne r0, [sp, #0x108]
	add r0, r8, #0x84
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0xf0
	add r3, r8, #0x490
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x84
	bl MTX_Identity43_
	add r0, sp, #0x84
	add r1, sp, #0xb4
	mov r2, #0x30
	bl MIi_CpuCopy32
	add r0, sp, #0x84
	add r1, sp, #0x24
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldr r1, [sp, #0x110]
	add r0, sp, #0x24
	str r1, [sp]
	ldr r2, [sp, #0x108]
	ldr r3, [sp, #0x10c]
	mov r1, r0
	bl MTX_TransApply43
	add r0, r8, #0x9c
	add r6, r0, #0x400
	add r0, r8, #0x2dc
	add r7, r0, #0x400
	ldr r0, [r8, #0x340]
	add r4, sp, #0x54
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	bne _0216A498
	ldr r0, [sp, #0xc]
	mov r11, #0
	mov r0, r0, asr #0x1f
	str r0, [sp, #0x10]
	mov r0, #0x1000
	rsb r0, r0, #0
	str r0, [sp, #0x1c]
_0216A3B4:
	add r0, sp, #0x84
	mov r1, r4
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldrh r2, [r7, #0]
	add r0, sp, #0x108
	add r1, sp, #0xb4
	mov r3, r2, asr #4
	ldr r2, =FX_SinCosTable_
	add r2, r2, r3, lsl #2
	ldrsh lr, [r2, #2]
	ldr r3, [sp, #0xc]
	ldr r2, [sp, #0x1c]
	umull r10, r9, lr, r3
	ldr r3, [sp, #0x10]
	str r2, [sp, #0xe8]
	mla r9, lr, r3, r9
	mov r2, #0
	str r2, [sp, #0xec]
	ldr r3, [sp, #0xc]
	mov ip, lr, asr #0x1f
	mla r9, ip, r3, r9
	adds r10, r10, #0x800
	adc r3, r9, #0
	mov r9, r10, lsr #0xc
	orr r9, r9, r3, lsl #20
	mov r2, r6
	str r9, [sp, #0xe4]
	bl MTX_MultVec43
	add r0, sp, #0xe4
	add r1, sp, #0xb4
	add r2, r6, #0xc
	bl MTX_MultVec43
	ldrh r1, [r7], #2
	mov r0, r4
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r2, r3, lsl #1
	ldrsh r1, [r1, r2]
	ldr r2, =FX_SinCosTable_
	add r2, r2, r3, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotZ33_
	mov r0, r4
	add r1, sp, #0x24
	mov r2, r4
	bl MTX_Concat43
	add r1, sp, #0xb4
	mov r0, r4
	mov r2, r1
	bl MTX_Concat43
	add r11, r11, #1
	add r6, r6, #0x18
	cmp r11, #0x18
	blt _0216A3B4
	b _0216A5B4
_0216A498:
	ldr r0, [sp, #0xc]
	mov r0, r0, asr #0x1f
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, #0x1000
	rsb r0, r0, #0
	str r0, [sp, #0x20]
_0216A4B8:
	add r0, sp, #0x84
	mov r1, r4
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldrh r2, [r7, #0]
	ldr r10, [sp, #0xc]
	ldr ip, [sp, #0x18]
	mov r3, r2, asr #4
	ldr r2, =FX_SinCosTable_
	add r0, sp, #0x108
	add r2, r2, r3, lsl #2
	ldrsh r9, [r2, #2]
	ldr r2, [sp, #0x20]
	add r1, sp, #0xb4
	umull r11, r10, r9, r10
	str r2, [sp, #0xe8]
	mov r2, #0
	str r2, [sp, #0xec]
	mla r10, r9, ip, r10
	mov r3, r9, asr #0x1f
	ldr r9, [sp, #0xc]
	mov r2, r6
	mla r10, r3, r9, r10
	adds r9, r11, #0x800
	adc r3, r10, #0
	mov r9, r9, lsr #0xc
	orr r9, r9, r3, lsl #20
	str r9, [sp, #0xe4]
	bl MTX_MultVec43
	add r0, sp, #0xe4
	add r1, sp, #0xb4
	add r2, r6, #0xc
	bl MTX_MultVec43
	ldrh r1, [r7], #2
	mov r0, r4
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r2, r3, lsl #1
	ldrsh r1, [r1, r2]
	ldr r2, =FX_SinCosTable_
	add r2, r2, r3, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotZ33_
	mov r0, r4
	add r1, sp, #0x24
	mov r2, r4
	bl MTX_Concat43
	add r1, sp, #0xb4
	mov r0, r4
	mov r2, r1
	bl MTX_Concat43
	ldr r0, [sp, #4]
	add r6, r6, #0x18
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #0x18
	blt _0216A4B8
_0216A5B4:
	ldr r0, [r8, #0x6d0]
	ldr r1, [r8, #0x44]
	mov r0, r0, asr #9
	add r0, r0, r1, asr #12
	str r0, [r8, #0x264]
	ldr r0, [r8, #0x6d4]
	ldr r1, [r8, #0x48]
	mov r0, r0, asr #9
	rsb r0, r0, r1, asr #12
	str r0, [r8, #0x268]
	ldr r1, [r8, #0x44]
	ldr r0, [r8, #0x6d0]
	add r4, r8, #0x2d8
	add r0, r1, r0, lsl #3
	str r0, [r8, #0x8c]
	ldr r1, [r8, #0x48]
	ldr r0, [r8, #0x6d4]
	sub r0, r1, r0, lsl #3
	str r0, [r8, #0x90]
	ldr r0, [r8, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	bne _0216A668
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x44]
	ldr r2, [r1, #0x44]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x48]
	ldr r2, [r1, #0x48]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216A668:
	cmp r0, #0x95
	bne _0216A6C8
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x44]
	ldr r2, [r1, #0x44]
	add r1, r3, #0x18000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	sub r1, r3, #0xd8000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x48]
	ldr r2, [r1, #0x48]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216A6C8:
	cmp r0, #0x8f
	bne _0216A6D8
	cmp r5, #0
	ble _0216A6E8
_0216A6D8:
	cmp r0, #0x95
	bne _0216A708
	cmp r5, #0
	blt _0216A708
_0216A6E8:
	cmp r0, #0x8f
	moveq r0, #0
	mvnne r0, #0xbf
	strh r0, [r4, #0x18]
	mov r0, #0
	strh r0, [r4, #0x1a]
	str r0, [r8, #0x28]
	b _0216A868
_0216A708:
	add r1, r8, #0x9c
	add r2, r8, #0x84
	add r6, r2, #0x400
	mov r7, #0
	cmp r0, #0x8f
	add r1, r1, #0x400
	ldr r2, [r8, #0x6c4]
	mov r0, r7
	bne _0216A7D0
	mov r2, r2, asr #9
	sub r2, r2, #0xc0
	strh r2, [r4, #0x18]
_0216A738:
	ldr r2, [r1, #0]
	cmp r5, r2, lsl #3
	ble _0216A770
	add r2, r8, r0, lsl #1
	add r2, r2, #0x600
	ldrh r2, [r2, #0xdc]
	add r0, r0, #1
	mov r6, r1
	add r2, r7, r2
	mov r2, r2, lsl #0x10
	cmp r0, #0x18
	mov r7, r2, lsr #0x10
	add r1, r1, #0x18
	blt _0216A738
_0216A770:
	cmp r0, #0x18
	subge r6, r6, #0x18
	subge r1, r1, #0x18
	ldr r10, [r6, #0]
	ldmia r1, {r0, r3}
	sub r1, r0, r10
	ldr r2, [r6, #4]
	sub r0, r5, r10, lsl #3
	sub r9, r3, r2
	mov r1, r1, lsl #3
	bl FX_Div
	smull r2, r1, r0, r9
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r6, #4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, asr #9
	strh r0, [r4, #0x1a]
	rsb r0, r7, #0x10000
	str r0, [r8, #0x28]
	b _0216A868
_0216A7D0:
	mov r2, r2, asr #9
	strh r2, [r4, #0x18]
_0216A7D8:
	ldr r2, [r1, #0]
	cmp r5, r2, lsl #3
	bge _0216A810
	add r2, r8, r0, lsl #1
	add r2, r2, #0x600
	ldrh r2, [r2, #0xdc]
	add r0, r0, #1
	mov r6, r1
	add r2, r7, r2
	mov r2, r2, lsl #0x10
	cmp r0, #0x18
	mov r7, r2, lsr #0x10
	add r1, r1, #0x18
	blt _0216A7D8
_0216A810:
	cmp r0, #0x18
	subge r6, r6, #0x18
	subge r1, r1, #0x18
	ldr r10, [r6, #0]
	ldmia r1, {r0, r3}
	sub r1, r0, r10
	ldr r2, [r6, #4]
	sub r0, r5, r10, lsl #3
	sub r9, r3, r2
	mov r1, r1, lsl #3
	bl FX_Div
	smull r2, r1, r0, r9
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r6, #4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, asr #9
	strh r0, [r4, #0x1a]
	str r7, [r8, #0x28]
_0216A868:
	ldrsh r0, [r4, #0x1a]
	ldr r1, [r8, #0x48]
	add r0, r1, r0, lsl #12
	str r0, [r8, #0x2c]
	add sp, sp, #0x114
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void DiveStand__Draw(void)
{
    GXDLInfo info;

    MtxFx44 matTrans;
    VecFx32 baseScale;

    DiveStand *work = TaskGetWorkCurrent(DiveStand);

    VEC_Set(&baseScale, FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(1.0));

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        baseScale.x = MultiplyFX(g_obj.scale.x, baseScale.x);

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        baseScale.y = MultiplyFX(g_obj.scale.y, baseScale.y);

    baseScale.x *= 32;
    baseScale.y *= 32;
    baseScale.z *= 32;

    VecFx32 baseTranslation;
    s32 v;
    MtxFx33 baseRot;
    MTX_Identity33(&baseRot);
    GameObject__Func_20282A8(&work->gameWork.objWork.position, &baseTranslation, &matTrans, FALSE);
    NNS_G3dGlbSetBaseScale(&baseScale);
    NNS_G3dGlbSetBaseRot(&baseRot);
    NNS_G3dGlbSetBaseTrans(&baseTranslation);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
    NNS_G3dGlbFlush();

    info = work->drawList;
    G3C_Begin(&info, GX_BEGIN_QUAD_STRIP);

    fx32 texS;
    if (work->gameWork.mapObject->id == MAPOBJECT_143)
        texS = FLOAT_TO_FX32(0.0);
    else
        texS = FLOAT_TO_FX32(7.0);
    G3C_Color(&info, GX_RGB_888(0xFF, 0xFF, 0xFF));

    VecFx32 *vertices = (VecFx32 *)work->vertices;
    for (v = 0; v < 25; v++)
    {
        G3C_TexCoord(&info, texS, FLOAT_TO_FX32(0.0));
        G3C_Vtx(&info, vertices[0].x >> 5, vertices[0].y >> 5, vertices[0].z >> 5);

        G3C_TexCoord(&info, texS, FLOAT_TO_FX32(8.0));
        G3C_Vtx(&info, vertices[1].x >> 5, vertices[1].y >> 5, vertices[1].z >> 5);

        vertices += 2;
        texS += FLOAT_TO_FX32(8.0);
    }
    G3C_End(&info);
    G3_EndMakeDL(&info);
    DC_FlushRange(work->drawData, 0x400);

    NNS_G3dGeSendDL(work->drawData, G3_GetDLSize(&info));

    s32 i;
    if ((work->gameWork.flags & (1 | 2 | 4 | 8)) == 0)
    {
        VecFx32 position = work->gameWork.objWork.position;

        fx32 step;
        if (work->gameWork.mapObject->id == MAPOBJECT_143)
        {
            step = FLOAT_TO_FX32(8.0);
            position.x += FLOAT_TO_FX32(3.0);
        }
        else
        {
            step = -FLOAT_TO_FX32(8.0);
            position.x -= FLOAT_TO_FX32(4.0);
        }

        for (i = 0; i < 24; i++)
        {
            StageTask__Draw2DEx(&work->gameWork.animator.ani, &position, NULL, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
            position.x += step;
        }
    }
}

void DiveStand__OnDefend_DiveStandSolid(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    DiveStand *diveStand = (DiveStand *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (diveStand == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || CheckIsPlayer1(player) == FALSE)
        return;

    if (CheckPlayerGimmickObj(player, diveStand))
        return;

    if ((diveStand->gameWork.flags & 2) != 0)
    {
        diveStand->gameWork.collisionObject.work.parent = &diveStand->gameWork.objWork;
    }
    else
    {
        if (player->objWork.position.y + FLOAT_TO_FX32(13.0) > diveStand->gameWork.objWork.position.y)
        {
            diveStand->gameWork.collisionObject.work.parent = NULL;
        }
        else
        {
            diveStand->gameWork.collisionObject.work.parent = &diveStand->gameWork.objWork;
        }
    }

    if (!CheckStageTaskTouchObj(&player->objWork, &diveStand->gameWork.objWork) || (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        Player__Action_DiveStandStood(player, &diveStand->gameWork);
        diveStand->gameWork.flags |= 1 | 2;
        diveStand->gameWork.flags &= ~8;
        diveStand->gameWork.collisionObject.work.parent = NULL;
    }
}

void DiveStand__OnDefend_DiveTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    DiveStand *diveStand = (DiveStand *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (diveStand == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || CheckIsPlayer1(player) == FALSE)
        return;

    if (!CheckPlayerGimmickObj(player, diveStand))
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        Player__Action_DiveStandGrab(player, &diveStand->gameWork);
        diveStand->gameWork.flags |= 4;
        Player__Action_AllowTrickCombos(player, &diveStand->gameWork);
    }
}