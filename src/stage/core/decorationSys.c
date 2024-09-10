#include <stage/core/decorationSys.h>
#include <game/stage/eventManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>

// Effects
#include <stage/effectTask.h>
#include <stage/effects/coralDebris.h>
#include <stage/effects/bridgeDebris.h>
#include <stage/effects/iceSparkles.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/waterWake.h>

// --------------------
// STRUCTS
// --------------------

struct Unknown2189EAC
{
    StageDecoration *lastDecor;
    s16 timer;
    u16 lastType;
};

struct DecorAsset
{
    const char *path;
    u16 fileID;
};

struct DecorConfig
{
    u8 assetID;
    u8 flags;
    u8 animID;
    u8 animID2;
    u8 animFlags2;
    u8 oamOrder;
    u8 spriteID;
    u8 type;
};

struct DecorRect
{
    s8 left;
    s8 top;
    s8 right;
    s8 bottom;
};

// --------------------
// VARIABLES
// --------------------

static DecorationSys *DecorationSys__WorkSingleton;

NOT_DECOMPILED u32 DecorationSys__TempDecorBitfield[(STAGEDECOR_TEMPLIST_SIZE + (32 - 1)) / 32];
NOT_DECOMPILED struct Unknown2189EAC decorUnknownList[4];
NOT_DECOMPILED MapDecor DecorationSys__TempDecorList[STAGEDECOR_TEMPLIST_SIZE];
NOT_DECOMPILED OBS_DATA_WORK decorFileList[20];
NOT_DECOMPILED OBS_SPRITE_REF decorSpriteRefList[55];

NOT_DECOMPILED void *DecorationSys__rangeTable;
NOT_DECOMPILED void *DecorationSys__offsetTable;
NOT_DECOMPILED struct DecorRect DecorationSys__rectList[11];
NOT_DECOMPILED void (*DecorationSys__initTable[11])(StageDecoration *work);
NOT_DECOMPILED void *_021876CC;
NOT_DECOMPILED void *_021876D4;

NOT_DECOMPILED struct DecorAsset decorAssets[36];
NOT_DECOMPILED struct DecorConfig decorInfo[MAPDECOR_COUNT];

NOT_DECOMPILED void *_02188780;
NOT_DECOMPILED void *_02188784;

NOT_DECOMPILED const char *aActAcEffGrd3lL;
NOT_DECOMPILED const char *aActAcDecMoBac;
NOT_DECOMPILED const char *aActAcDecFlwBac;
NOT_DECOMPILED const char *aActAcDecSailBa;
NOT_DECOMPILED const char *aActAcDecSakuBa_0;
NOT_DECOMPILED const char *aActAcDecPalmBa;
NOT_DECOMPILED const char *aActAcDecBoatBa;
NOT_DECOMPILED const char *aActAcDecMastBa;
NOT_DECOMPILED const char *aActAcDecRopeBa;
NOT_DECOMPILED const char *aActAcEffWaterB_2;
NOT_DECOMPILED const char *aActAcDecCloudB;
NOT_DECOMPILED const char *aActAcDecGrassB;
NOT_DECOMPILED const char *aActAcDecCoralB_0;
NOT_DECOMPILED const char *aActAcGmkBarrel_0;
NOT_DECOMPILED const char *aActAcDecKinoko;
NOT_DECOMPILED const char *aActAcDecSuimen;
NOT_DECOMPILED const char *aActAcDecGrass6;
NOT_DECOMPILED const char *aActAcDecIcicle;
NOT_DECOMPILED const char *aActAcDecCannon;
NOT_DECOMPILED const char *aActAcDecRudder;
NOT_DECOMPILED const char *aActAcDecThunde;
NOT_DECOMPILED const char *aActAcDecKinoko_0;
NOT_DECOMPILED const char *aActAcDecChimne;
NOT_DECOMPILED const char *aActAcGmkFlipmu_1;
NOT_DECOMPILED const char *aActAcDecIceTre_0;
NOT_DECOMPILED const char *aActAcDecPipeFl;
NOT_DECOMPILED const char *aActAcDecBigLea;
NOT_DECOMPILED const char *aActAcDecFlwTub;
NOT_DECOMPILED const char *aActAcDecGstTre;
NOT_DECOMPILED const char *aActAcDecDecopi;
NOT_DECOMPILED const char *aActAcDecCloudS;
NOT_DECOMPILED const char *aActAcDecTrampo;
NOT_DECOMPILED const char *aActAcDecLeafWa;
NOT_DECOMPILED const char *aActAcDecPipeSt;
NOT_DECOMPILED const char *aActAcDecKojima;
NOT_DECOMPILED const char *aActAcDecFallin;
NOT_DECOMPILED const char *aActAcDecAnchor;

// --------------------
// FUNCTIONS
// --------------------

void DecorationSys__Create(void)
{
    if (DecorationSys__WorkSingleton != NULL)
        return;

    Task *task = TaskCreate(DecorationSys__Main, DecorationSys__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_3, DecorationSys);
    if (task == HeapNull)
        return;

    DecorationSys *work = TaskGetWork(task, DecorationSys);
    TaskInitWork8(work);

    DecorationSys__WorkSingleton = work;
}

StageDecoration *DecorationSys__Construct(size_t structSize, MapDecor *mapDecor, fx32 x, fx32 y, BOOL prepend)
{
    if (structSize < sizeof(StageDecoration))
        structSize = sizeof(StageDecoration);

    StageDecoration *work = HeapAllocHead(HEAP_SYSTEM, structSize);
    MI_CpuClear8(work, structSize);

    if (prepend)
        DecorationSys__AddEntry_Head(work);
    else
        DecorationSys__AddEntry_Tail(work);

    DecorationSys__InitMapDecor(work, mapDecor, x, y);

    return work;
}

void DecorationSys__DestroyDecor(StageDecoration *work)
{
    if (work == NULL)
        return;

    if (work->destructor != NULL)
        work->destructor(work);

    DecorationSys__RemoveEntry(work);
    HeapFree(HEAP_SYSTEM, work);
}

void DecorationSys__Release(void)
{
    if (DecorationSys__WorkSingleton == NULL)
        return;

    StageDecoration *decor = DecorationSys__WorkSingleton->listStart;
    while (decor != NULL)
    {
        StageDecoration *next = decor->next;
        DecorationSys__DestroyDecor(decor);
        decor = next;
    }
}

StageDecoration *DecorationSys__CreateTempDecoration(s32 type, fx32 x, fx32 y)
{
    StageDecoration *work = NULL;

    s32 slot = DecorationSys__GetNextTempSlot();
    if (slot < STAGEDECOR_TEMPLIST_SIZE)
    {
        DecorationSys__TempDecorList[slot].x  = -1;
        DecorationSys__TempDecorList[slot].y  = -1;
        DecorationSys__TempDecorList[slot].id = type;

        work = stageDecorationSpawnList[type](&DecorationSys__TempDecorList[slot], x, y, 0);
        if (work == NULL)
            DecorationSys__ReleaseTempDecor(&DecorationSys__TempDecorList[slot]);
    }

    return work;
}

NONMATCH_FUNC StageDecoration *DecorationSys__CreateCommonDecor(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
    // https://decomp.me/scratch/TSQVo -> 97.16%
#ifdef NON_MATCHING
    struct DecorAsset *asset;
    struct DecorConfig *config;

    config = &decorInfo[mapDecor->id];
    asset  = &decorAssets[config->assetID];

    DecorationCommon *work = (DecorationCommon *)DecorationSys__Construct(sizeof(DecorationCommon), mapDecor, x, y, ((config->flags & 0x80) != 0));

    work->decorWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->decorWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    if ((config->flags & 4) != 0 && (config->flags & 0x10) == 0)
    {
        ObjObjectAction2dBACLoad(&work->decorWork.objWork, &work->animator, asset->path, &decorFileList[asset->fileID], gameArchiveStage, OBJ_DATA_GFX_AUTO);
        ObjActionAllocSpritePalette(&work->decorWork.objWork, config->animID2, config->animFlags2);
        StageTask__SetAnimation(&work->decorWork.objWork, config->animID);
    }
    else
    {
        if ((config->flags & 0x40) == 0)
        {
            ObjObjectAction2dBACLoad(&work->decorWork.objWork, &work->animator, asset->path, &decorFileList[asset->fileID], gameArchiveStage, OBJ_DATA_GFX_NONE);
            ObjActionAllocSpritePalette(&work->decorWork.objWork, config->animID2, config->animFlags2);
            ObjObjectActionAllocSprite(&work->decorWork.objWork, Sprite__GetSpriteSize2FromAnim(work->animator.fileWork->fileData, config->animID),
                                       &decorSpriteRefList[config->spriteID]);
            StageTask__SetAnimation(&work->decorWork.objWork, config->animID);

            AnimatorSpriteDS *ani = &work->decorWork.objWork.obj_2d->ani;
            if ((decorSpriteRefList[config->spriteID].engineRef[0].referenceCount & OBJDATA_FLAG_REFCOUNT_MASK) == 1)
            {
                ani->work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PALETTES | ANIMATOR_FLAG_UNCOMPRESSED_PIXELS;
                AnimatorSpriteDS__ProcessAnimationFast(ani);
                StageTask__SetAnimation(&work->decorWork.objWork, config->animID);
            }
            ani->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
        }
    }

    if ((config->flags & (0x40 | 0x04)) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    else
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

    if ((config->flags & 1) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((config->flags & 2) != 0)
        work->decorWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    u8 priority;
    if ((config->flags & 8) != 0)
    {
        priority = SPRITE_PRIORITY_0;
    }
    else if ((config->flags & 0x20) != 0)
    {
        priority = SPRITE_PRIORITY_3;
    }
    else
    {
        priority = SPRITE_PRIORITY_2;
    }
    StageTask__SetAnimatorOAMOrder(&work->decorWork.objWork, config->oamOrder + SPRITE_ORDER_25);
    StageTask__SetAnimatorPriority(&work->decorWork.objWork, priority);

    if (DecorationSys__initTable[config->type] != NULL)
        DecorationSys__initTable[config->type](&work->decorWork);

    return &work->decorWork;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldrh r3, [r0, #2]
	ldr r4, =decorInfo
	mov lr, r1
	add r5, r4, r3, lsl #3
	ldrb r6, [r4, r3, lsl #3]
	ldrb r4, [r5, #1]
	ldr ip, =decorAssets
	mov r3, r2
	tst r4, #0x80
	movne r4, #1
	moveq r4, #0
	mov r1, r0
	mov r2, lr
	mov r0, #0x2dc
	add r6, ip, r6, lsl #3
	str r4, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldrb r1, [r5, #1]
	tst r1, #4
	beq _02152C10
	tst r1, #0x10
	bne _02152C10
	ldr r1, =gameArchiveStage
	ldr r2, =0x0000FFFF
	ldr r1, [r1]
	ldr ip, =decorFileList
	stmia sp, {r1, r2}
	ldrh r3, [r6, #4]
	ldr r2, [r6]
	add r1, r4, #0x22c
	add r3, ip, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r5, #3]
	ldrb r2, [r5, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	b _02152CDC
_02152C10:
	tst r1, #0x40
	bne _02152CDC
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r0, [r0]
	ldr ip, =decorFileList
	stmia sp, {r0, r1}
	ldrh r3, [r6, #4]
	ldr r2, [r6]
	mov r0, r4
	add r1, r4, #0x22c
	add r3, ip, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r5, #3]
	ldrb r2, [r5, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x2d0]
	ldrb r1, [r5, #2]
	ldr r0, [r0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	ldrb r2, [r5, #6]
	ldr r3, =decorSpriteRefList
	mov r0, r4
	add r2, r3, r2, lsl #4
	bl ObjObjectActionAllocSprite
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	ldrb r1, [r5, #6]
	ldr r0, =0x02189FF0
	ldr r6, [r4, #0x128]
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02152CD0
	ldr r0, [r6, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r6
	mov r2, r1
	str r3, [r6, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
_02152CD0:
	ldr r0, [r6, #0x3c]
	orr r0, r0, #0x18
	str r0, [r6, #0x3c]
_02152CDC:
	ldrb r0, [r5, #1]
	tst r0, #0x44
	ldr r0, [r4, #0x20]
	orrne r0, r0, #4
	orreq r0, r0, #0x10
	str r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #2
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #8
	movne r6, #0
	bne _02152D38
	tst r0, #0x20
	movne r6, #3
	moveq r6, #2
_02152D38:
	ldrsb r1, [r5, #5]
	mov r0, r4
	add r1, r1, #0x19
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, r6
	bl StageTask__SetAnimatorPriority
	ldrb r1, [r5, #7]
	ldr r0, =DecorationSys__initTable
	ldr r1, [r0, r1, lsl #2]
	cmp r1, #0
	beq _02152D70
	mov r0, r4
	blx r1
_02152D70:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC StageDecoration *DecorationSys__CreateUnknown2152D9C(MapDecor *mapDecor, fx32 x, fx32 y, s32 type){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	ldrh r3, [r0, #2]
	ldr r4, =decorInfo
	ldr lr, =_021876D4
	add r5, r4, r3, lsl #3
	ldrb r9, [r5, #4]
	ldrb r6, [r5, #1]
	ldrb r7, [r4, r3, lsl #3]
	ldrb r8, [lr, r9, lsl #3]
	ldr ip, =decorAssets
	mov r4, r1
	tst r6, #0x80
	add r6, lr, r9, lsl #3
	movne r9, #1
	mov r3, r2
	moveq r9, #0
	mov r1, r0
	mov r2, r4
	mov r0, #0x3f0
	add r7, ip, r7, lsl #3
	add r8, ip, r8, lsl #3
	str r9, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldrb r1, [r5, #1]
	tst r1, #4
	beq _02152EB8
	tst r1, #0x10
	bne _02152EB8
	ldr r3, =0x0000FFFF
	ldr ip, =decorFileList
	str r3, [sp]
	ldrh r9, [r7, #4]
	ldr r2, =gameArchiveStage
	add r1, r4, #0x2dc
	add r9, ip, r9, lsl #3
	str r9, [sp, #4]
	ldr r2, [r2]
	str r2, [sp, #8]
	ldr r2, [r7]
	bl ObjObjectAction3dBACLoad
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldrh r3, [r8, #4]
	ldr r2, [r8]
	add r1, r4, #0x22c
	ldr r7, =decorFileList
	add r3, r7, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	ldrb r1, [r6, #3]
	ldrb r2, [r6, #4]
	bl ObjActionAllocSpritePalette
	mov r0, r4
	ldrb r1, [r6, #2]
	bl DecorationSys__SetAnimation
	b _02153054
_02152EB8:
	mov r3, #0
	str r3, [sp]
	ldrh r1, [r7, #4]
	ldr r2, =decorFileList
	ldr r0, =gameArchiveStage
	add r1, r2, r1, lsl #3
	str r1, [sp, #4]
	ldr r1, [r0]
	mov r0, r4
	str r1, [sp, #8]
	ldr r2, [r7]
	add r1, r4, #0x2dc
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x3e4]
	ldrb r1, [r5, #2]
	ldr r0, [r0]
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, [r4, #0x3e4]
	mov r9, r0
	ldr r0, [r1]
	ldrb r1, [r5, #2]
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, r9
	mov r2, r0
	mov r0, r4
	ldr r9, =decorSpriteRefList
	ldrb r3, [r5, #6]
	add r3, r9, r3, lsl #4
	bl ObjObjectActionAllocTexture
	mov r0, r4
	ldrb r1, [r5, #2]
	bl StageTask__SetAnimation
	ldr r9, [r4, #0x134]
	ldrb r1, [r5, #6]
	ldr r0, =0x02189FF0
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02152F80
	ldr r0, [r9, #0xcc]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r9
	mov r2, r1
	str r3, [r9, #0xcc]
	bl AnimatorSprite3D__ProcessAnimation
	ldrb r1, [r5, #2]
	mov r0, r4
	bl StageTask__SetAnimation
_02152F80:
	ldr r1, [r9, #0xcc]
	ldr r0, =gameArchiveStage
	orr r1, r1, #0x18
	str r1, [r9, #0xcc]
	ldr r1, [r0]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldrh r3, [r8, #4]
	ldr r8, =decorFileList
	ldr r2, [r7]
	mov r0, r4
	add r1, r4, #0x22c
	add r3, r8, r3, lsl #3
	bl ObjObjectAction2dBACLoad
	ldrb r1, [r6, #3]
	ldrb r2, [r6, #4]
	mov r0, r4
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x2d0]
	ldrb r1, [r6, #2]
	ldr r0, [r0]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	ldrb r2, [r6, #6]
	mov r0, r4
	ldr r3, =decorSpriteRefList
	add r2, r3, r2, lsl #4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	ldrb r1, [r6, #2]
	bl DecorationSys__SetAnimation
	ldr r7, [r4, #0x128]
	ldrb r1, [r6, #6]
	ldr r0, =0x02189FF0
	mov r1, r1, lsl #4
	ldrh r0, [r0, r1]
	bic r0, r0, #0x8000
	cmp r0, #1
	bne _02153048
	ldr r0, [r7, #0x3c]
	mov r1, #0
	orr r3, r0, #0x60
	mov r0, r7
	mov r2, r1
	str r3, [r7, #0x3c]
	bl AnimatorSpriteDS__ProcessAnimation
	ldrb r1, [r6, #2]
	mov r0, r4
	bl DecorationSys__SetAnimation
_02153048:
	ldr r0, [r7, #0x3c]
	orr r0, r0, #0x18
	str r0, [r7, #0x3c]
_02153054:
	ldrb r0, [r5, #1]
	tst r0, #4
	ldr r0, [r4, #0x20]
	orrne r0, r0, #4
	orreq r0, r0, #0x10
	str r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrb r0, [r5, #1]
	tst r0, #2
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	ldrb r0, [r6, #1]
	tst r0, #8
	movne r7, #0
	bne _021530B0
	tst r0, #0x20
	movne r7, #3
	moveq r7, #2
_021530B0:
	ldrsb r1, [r6, #5]
	mov r0, r4
	add r1, r1, #0x19
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, r7
	bl StageTask__SetAnimatorPriority
	ldrb r1, [r5, #7]
	ldr r0, =DecorationSys__initTable
	ldr r1, [r0, r1, lsl #2]
	cmp r1, #0
	beq _021530E8
	mov r0, r4
	blx r1
_021530E8:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

StageDecoration *DecorationSys__CreateUnknown2153118(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
    StageDecoration *work = DecorationSys__Construct(sizeof(StageDecoration), mapDecor, x, y, 0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    SetTaskState(&work->objWork, DecorationSys__CreateWaterBubble);
    return work;
}

void DecorationSys__Destructor(Task *task)
{
    UNUSED(task);

    if (DecorationSys__WorkSingleton == NULL)
        return;

    DecorationSys__Release();
    DecorationSys__WorkSingleton = NULL;
}

void DecorationSys__Main(void)
{
    StageDecoration *decor = DecorationSys__WorkSingleton->listStart;
    while (decor != NULL)
    {
        StageDecoration *next = decor->next;
        DecorationSys__Decor_Main(decor);
        decor = next;
    }
}

void DecorationSys__Decor_Main(StageDecoration *work)
{
    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        DecorationSys__DestroyDecor(work);
        return;
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROY_NEXT_FRAME) != 0)
    {
        work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        return;
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT) == 0)
    {
        if (work->objWork.ppViewCheck != NULL)
        {
            if (work->objWork.ppViewCheck(&work->objWork))
            {
                work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
                return;
            }
        }
    }

    if (work->objWork.parentObj != NULL && (work->objWork.parentObj->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
    {
        if ((work->objWork.flag & STAGE_TASK_FLAG_200) == 0)
        {
            work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
            work->objWork.parentObj = NULL;
            return;
        }

        work->objWork.parentObj = NULL;
    }

    if (!ObjectPauseCheck(work->objWork.flag))
    {
        if ((work->objWork.flag & STAGE_TASK_FLAG_DISABLE_STATE) == 0)
        {
            if (work->objWork.state != NULL)
            {
                ((StageDecorState)work->objWork.state)(work);
            }
        }

        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT) == 0)
        {
            if (work->objWork.ppMove != NULL)
                ((StageDecorMoveFunc)work->objWork.ppMove)(work);
            else
                StageTask__Move(&work->objWork);
        }
    }

    if ((work->objWork.flag & STAGE_TASK_FLAG_DESTROYED) == 0)
    {
        if (work->objWork.ppOut == NULL || (work->objWork.displayFlag & DISPLAY_FLAG_NO_DRAW_EVENT) != 0)
            DecorationSys__Draw(work);

        if (work->objWork.ppOut != NULL)
            ((StageDecorOutFunc)work->objWork.ppOut)(work);
    }

    if (!ObjectPauseCheck(work->objWork.flag))
    {
        if (work->objWork.ppCollide != NULL)
        {
            ((StageDecorCollideFunc)work->objWork.ppCollide)(work);
        }
        else
        {
            for (s32 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
            {
                if (work->objWork.colliderList[c] != NULL)
                    StageTask__HandleCollider(&work->objWork, work->objWork.colliderList[c]);
            }
        }

        work->objWork.prevOffset.x = work->objWork.offset.x;
        work->objWork.prevOffset.y = work->objWork.offset.y;
        work->objWork.prevOffset.z = work->objWork.offset.z;

        work->objWork.offset.x = 0;
        work->objWork.offset.y = 0;
        work->objWork.offset.z = 0;

        work->objWork.flow.x = 0;
        work->objWork.flow.y = 0;
        work->objWork.flow.z = 0;
    }
}

void DecorationSys__Draw(StageDecoration *work)
{
    if (work->objWork.obj_2d != NULL)
    {
        StageDisplayFlags displayFlag;
        if (work->objWork.obj_3d != NULL || work->objWork.obj_3des != NULL || work->objWork.obj_2dIn3d != NULL)
            displayFlag = work->objWork.displayFlag;

        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);

        if (work->objWork.obj_3d != NULL || work->objWork.obj_3des != NULL || work->objWork.obj_2dIn3d != NULL)
            work->objWork.displayFlag = displayFlag;
    }

    if (work->objWork.obj_2dIn3d != NULL)
        StageTask__Draw3D(&work->objWork, &work->objWork.obj_2dIn3d->ani.work);
}

void DecorationSys__ReleaseDecor(StageDecoration *work)
{
    ObjObjectActionReleaseGfxRefs(&work->objWork);

    if (work->objWork.obj_2d != NULL)
    {
        ObjDrawReleaseSpritePalette(work->objWork.obj_2d->ani.cParam[0].palette);

        if (work->objWork.obj_2d->fileWork != NULL)
        {
            ObjDataRelease(work->objWork.obj_2d->fileWork);
        }
        else if (work->objWork.obj_2d->ani.work.fileData != NULL && (work->objWork.flag & STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE) == 0)
        {
            HeapFree(HEAP_USER, work->objWork.obj_2d->ani.work.fileData);
        }
    }

    if (work->objWork.obj_2dIn3d != NULL)
    {
        if (work->objWork.obj_2dIn3d->fileWork != NULL)
        {
            ObjDataRelease(work->objWork.obj_2dIn3d->fileWork);
            work->objWork.obj_2dIn3d->fileData = NULL;
        }
        else if (work->objWork.obj_2dIn3d->fileData != NULL && (work->objWork.obj_2dIn3d->flags & 1) == 0)
        {
            HeapFree(HEAP_USER, work->objWork.obj_2dIn3d->fileData);
            work->objWork.obj_2dIn3d->fileData = NULL;
        }
    }
}

void DecorationSys__InitMapDecor(StageDecoration *work, MapDecor *mapDecor, fx32 x, fx32 y)
{
    SetTaskSpriteCallback(&work->objWork, DecorationSys__SpriteCallback_Default);
    SetDecorCollideFunc(&work->objWork, DecorationSys__Collide_Default);
    SetTaskViewCheckFunc(&work->objWork, StageTask__ViewCheck_Default);

    work->originPos.x        = x;
    work->originPos.y        = y;
    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.scale.x = work->objWork.scale.y = work->objWork.scale.z = FLOAT_TO_FX32(1.0);
    work->objWork.objType                                                 = STAGE_OBJ_TYPE_DECORATION;

    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.1640625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(15.0);

    work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;

    StageTask__SetHitbox(&work->objWork, -2, -6, 2, 0);
    ObjRect__SetGroupFlags(&work->rect[0], 2, 1);
    ObjRect__SetAttackStat(&work->rect[0], 0, 0);
    ObjRect__SetDefenceStat(&work->rect[0], ~1, 0x3F);
    work->rect[0].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;

    if (mapDecor != NULL)
    {
        work->mapDecor    = mapDecor;
        work->mapDecor->x = MAPOBJECT_DESTROYED;
    }

    work->objWork.viewOutOffset = 264 - GameDecoration__ViewOffsetTable[mapDecor->id];
    work->destructor            = DecorationSys__Destructor_21535B8;
}

void DecorationSys__Destructor_21535B8(StageDecoration *work)
{
    MapDecor *mapDecor = work->mapDecor;
    if (mapDecor != NULL && mapDecor->x == MAPOBJECT_DESTROYED && mapDecor->y == MAPOBJECT_DESTROYED)
    {
        DecorationSys__ReleaseTempDecor(mapDecor);
    }
    else
    {
        if ((work->flags & 0x10000) == 0 && mapDecor != NULL)
            mapDecor->x = FX32_TO_WHOLE(work->originPos.x);
    }

    DecorationSys__ReleaseDecor(work);
}

void DecorationSys__AddEntry_Tail(StageDecoration *work)
{
    if (DecorationSys__WorkSingleton->listEnd != NULL)
    {
        DecorationSys__WorkSingleton->listEnd->next = work;
        work->prev                                  = DecorationSys__WorkSingleton->listEnd;
        work->next                                  = NULL;
        DecorationSys__WorkSingleton->listEnd       = work;
    }
    else
    {
        DecorationSys__WorkSingleton->listEnd   = work;
        DecorationSys__WorkSingleton->listStart = DecorationSys__WorkSingleton->listEnd;

        work->next = NULL;
        work->prev = NULL;
    }
}

void DecorationSys__AddEntry_Head(StageDecoration *work)
{
    if (DecorationSys__WorkSingleton->listStart != NULL)
    {
        DecorationSys__WorkSingleton->listStart->prev = work;
        work->next                                    = DecorationSys__WorkSingleton->listStart;
        work->prev                                    = NULL;
        DecorationSys__WorkSingleton->listStart       = work;
    }
    else
    {
        DecorationSys__WorkSingleton->listEnd   = work;
        DecorationSys__WorkSingleton->listStart = DecorationSys__WorkSingleton->listEnd;
        work->next                              = NULL;
        work->prev                              = NULL;
    }
}

void DecorationSys__RemoveEntry(StageDecoration *work)
{
    StageDecoration *prev = work->prev;
    if (prev != NULL)
        prev->next = work->next;
    else
        DecorationSys__WorkSingleton->listStart = work->next;

    StageDecoration *next = work->next;
    if (next != NULL)
        next->prev = work->prev;
    else
        DecorationSys__WorkSingleton->listEnd = work->prev;
}

NONMATCH_FUNC void DecorationSys__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, StageDecoration *work)
{
    // https://decomp.me/scratch/2lTX6 -> 73.68%
#ifdef NON_MATCHING
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        if (block->id == 0)
        {
            work->rect[block->id].parent = &work->objWork;
            ObjRect__SetBox(&work->rect[block->id], block->hitbox.left, block->hitbox.top, block->hitbox.right, block->hitbox.bottom);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0]
	cmp r1, #7
	ldmneia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	add r1, r2, r1, lsl #6
	str r2, [r1, #0x184]
	ldrsh r1, [r0, #0xe]
	add lr, r2, #0x168
	str r1, [sp]
	ldrh ip, [r0, #4]
	ldrsh r1, [r0, #8]
	ldrsh r2, [r0, #0xa]
	ldrsh r3, [r0, #0xc]
	add r0, lr, ip, lsl #6
	bl ObjRect__SetBox2D
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void DecorationSys__Collide_Default(StageDecoration *work)
{
    if ((work->objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) == 0)
    {
        if (work->rect[0].parent != NULL)
            StageTask__HandleCollider(&work->objWork, work->rect);
    }
}

s16 DecorationSys__GetNextTempSlot(void)
{
    s16 slot = 0;

    for (slot = 0; slot < STAGEDECOR_TEMPLIST_SIZE; slot++)
    {
        if ((DecorationSys__TempDecorBitfield[slot >> 5] & (1 << (slot & 0x1F))) == 0)
        {
            DecorationSys__TempDecorBitfield[slot >> 5] |= (1 << (slot & 0x1F));
            return slot;
        }
    }

    return slot;
}

void DecorationSys__ReleaseTempDecor(MapDecor *mapDecor)
{
    u32 slot = FX_DivS32((size_t)mapDecor - (size_t)DecorationSys__TempDecorList, 4);

    DecorationSys__TempDecorBitfield[slot >> 5] &= ~(1 << (slot & 0x1F));
}

void DecorationSys__CreateWaterBubble(StageDecoration *work)
{
    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0)
    {
        EffectWaterBubble__Create(work->objWork.position.x + (((mtMathRand() & 7) - 3) << 12), work->objWork.position.y - FLOAT_TO_FX32(4.0), (u16)(mtMathRand() & 1),
                                  mapCamera.camera[0].waterLevel);

        work->objWork.userTimer = (mtMathRand() & 0x3F) + 8;
    }
}

NONMATCH_FUNC void DecorationSys__InitFunc_21538D0(StageDecoration *work)
{
    // https://decomp.me/scratch/HeuQt -> 85.54%
#ifdef NON_MATCHING
    s32 type;

    u16 id = work->mapDecor->id;
    if (id >= MAPDECOR_195 && id <= MAPDECOR_202)
    {
        type = id - MAPDECOR_195;
    }
    else if (id >= MAPDECOR_217 && id <= MAPDECOR_220)
    {
        type = id - MAPDECOR_209;
    }
    else if (id >= MAPDECOR_225 && id <= MAPDECOR_228)
    {
        type = id - MAPDECOR_213;
    }
    else if (id >= MAPDECOR_290)
    {
        type = id - MAPDECOR_274;
    }
    else
    {
        type = id - MAPDECOR_290;
    }

    ObjRect__SetBox2D(&work->rect[0].rect, DecorationSys__rectList[type >> 1].left, DecorationSys__rectList[type >> 1].top, DecorationSys__rectList[type >> 1].right,
                      DecorationSys__rectList[type >> 1].bottom);

    work->rect[0].parent = &work->objWork;
    ObjRect__SetOnDefend(&work->rect[0], DecorationSys__OnDefend_21539B0);
    work->rect[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x20c]
	ldrh r1, [r0, #2]
	cmp r1, #0xc3
	blo _021538F8
	cmp r1, #0xca
	subls r0, r1, #0xc3
	bls _02153934
_021538F8:
	cmp r1, #0xd9
	blo _0215390C
	cmp r1, #0xdc
	subls r0, r1, #0xd1
	bls _02153934
_0215390C:
	cmp r1, #0xe1
	blo _02153920
	cmp r1, #0xe4
	subls r0, r1, #0xd5
	bls _02153934
_02153920:
	ldr r0, =0x00000122
	cmp r1, r0
	sub r0, r0, #0x234
	addhs r0, r1, r0
	addlo r0, r1, r0
_02153934:
	mov r0, r0, asr #1
	ldr r3, =0x02187677
	mov lr, r0, lsl #2
	ldr r1, =DecorationSys__rectList
	ldr r2, =0x02187675
	ldr r0, =0x02187676
	ldrsb ip, [r3, lr]
	ldrsb r1, [r1, lr]
	ldrsb r2, [r2, lr]
	ldrsb r3, [r0, lr]
	add r0, r4, #0x168
	str ip, [sp]
	bl ObjRect__SetBox2D
	ldr r0, =DecorationSys__OnDefend_21539B0
	str r4, [r4, #0x184]
	str r0, [r4, #0x18c]
	ldr r0, [r4, #0x180]
	orr r0, r0, #4
	orr r0, r0, #0x400
	str r0, [r4, #0x180]
	ldr r0, [r4, #0x18]
	bic r0, r0, #2
	str r0, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DecorationSys__OnDefend_21539B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r4, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r4, #0
	cmpne r2, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r3, [r2]
	cmp r3, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r3, [r2, #0x1c]
	tst r3, #0x40
	beq _021539FC
	ldr r5, [r2, #0xc8]
	cmp r5, #0
	rsblt r5, r5, #0
	b _02153A18
_021539FC:
	ldr r3, [r2, #0x9c]
	ldr r5, [r2, #0x98]
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r5, #0
	rsblt r5, r5, #0
	add r5, r5, r3
_02153A18:
	ldr r3, [r2, #0x64c]
	cmp r5, r3
	bge _02153A30
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02153A30:
	ldr r0, [r2, #0x5d8]
	tst r0, #0x80
	beq _02153C1C
	ldr r1, [r4, #0x20c]
	ldr r0, =0x00000122
	ldrh r1, [r1, #2]
	cmp r1, r0
	ldr r0, [r2, #0xc0]
	blo _02153B34
	sub r0, r0, #0x5000
	ldr r6, [r2, #0xbc]
	ldr r10, =_mt_math_rand
	ldr r7, =0x00196225
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	str r0, [sp, #4]
	mov r5, #0
_02153A74:
	ldr r1, [r10]
	ldr r2, [r9]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla r11, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov ip, r3, lsr #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsl #0x10
	mov ip, r3, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsr #0x10
	and r1, r1, #7
	and r3, r3, #3
	and r0, r0, #1
	str r11, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10]
	ldr r0, [r9]
	mov r11, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, r11, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #6
	rsb r2, r2, #3
	ldr r11, [r4, #0x48]
	sub r1, r1, #3
	add r1, r11, r1, lsl #12
	ldr ip, [r4, #0x44]
	sub r0, r0, #3
	ldr r11, [sp, #4]
	add r3, r3, #4
	add r0, ip, r0, lsl #12
	add r2, r6, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r5, r5, #1
	cmp r5, #2
	blt _02153A74
	b _02153FD8
_02153B34:
	sub r6, r0, #0x5000
	ldr r0, =0x00001FFF
	ldr r5, [r2, #0xbc]
	rsb r0, r0, #0x1000
	str r0, [sp, #0xc]
	ldr r0, =0x00001FFF
	ldr r10, =_mt_math_rand
	sub r0, r0, #0x1800
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	mov r7, #0
	str r0, [sp, #8]
_02153B64:
	ldr r0, [r10]
	mla r3, r0, r8, r9
	mla r1, r3, r8, r9
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r8, r9
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #8]
	and r1, r1, r3, lsr #16
	sub r3, r6, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r8, r9
	ldr r2, =0x00001FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0xc]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r8, r9
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r2, r5, lsl #1
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r7, r7, #1
	cmp r7, #3
	blt _02153B64
	b _02153FD8
_02153C1C:
	ldr r1, [r4, #0x20c]
	tst r0, #0x100
	ldr r0, =0x00000122
	ldrh r1, [r1, #2]
	mov r6, #0
	beq _02153E04
	cmp r1, r0
	ldr r7, =0x00196225
	blo _02153D1C
	ldr r0, [r2, #0xbc]
	mov r11, #0x5000
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	mov r5, r0, asr #1
	rsb r11, r11, #0
_02153C5C:
	ldr r1, [r10]
	ldr r2, [r9]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla ip, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r3, r3, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	and r3, r3, #3
	add r3, r3, #3
	and r0, r0, #1
	str ip, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10]
	ldr r0, [r9]
	mov ip, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #2
	rsb r2, r2, #1
	ldr lr, [r4, #0x44]
	sub r0, r0, #3
	ldr ip, [r4, #0x48]
	sub r1, r1, #3
	add r0, lr, r0, lsl #12
	add r1, ip, r1, lsl #12
	add r2, r5, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r6, r6, #1
	cmp r6, #2
	rsb r5, r5, #0
	blt _02153C5C
	b _02153FD8
_02153D1C:
	ldr r0, =0x00001FFF
	mov r9, #0x5000
	rsb r0, r0, #0x1000
	str r0, [sp, #0x14]
	ldr r0, =0x00001FFF
	ldr r5, [r2, #0xbc]
	sub r0, r0, #0x1800
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	str r0, [sp, #0x10]
	rsb r9, r9, #0
_02153D48:
	ldr r0, [r10]
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r7, r8
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #0x10]
	and r1, r1, r3, lsr #16
	sub r3, r9, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r7, r8
	ldr r2, =0x00001FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0x14]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r7, r8
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r5, r2
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r6, r6, #1
	cmp r6, #3
	rsb r5, r5, #0
	blt _02153D48
	b _02153FD8
_02153E04:
	cmp r1, r0
	ldr r0, [r2, #0xbc]
	ldr r7, =0x00196225
	blo _02153EF4
	mov r5, r0, asr #2
	mov r0, #0x3000
	rsb r0, r0, #0
	ldr r10, =_mt_math_rand
	ldr r8, =0x3C6EF35F
	ldr r9, =_obj_disp_rand
	str r0, [sp, #0x18]
_02153E30:
	ldr r1, [r10]
	ldr r2, [r9]
	mla r0, r1, r7, r8
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mla r11, r2, r7, r8
	mla r2, r1, r7, r8
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov ip, r3, lsr #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsl #0x10
	mov ip, r3, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, ip, lsr #0x10
	and r1, r1, #7
	and r3, r3, #1
	and r0, r0, #1
	str r11, [r9]
	str r2, [r10]
	str r0, [sp]
	ldr r2, [r10]
	ldr r0, [r9]
	mov r11, r2, lsr #0x10
	mov r2, r0, lsr #0x10
	mov r0, r11, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	and r0, r0, #7
	and r2, r2, #2
	rsb r2, r2, #1
	ldr r11, [r4, #0x48]
	sub r1, r1, #3
	add r1, r11, r1, lsl #12
	ldr ip, [r4, #0x44]
	sub r0, r0, #3
	ldr r11, [sp, #0x18]
	add r3, r3, #1
	add r0, ip, r0, lsl #12
	add r2, r5, r2, lsl #12
	sub r3, r11, r3, lsl #12
	bl EffectBridgeDebris__Create
	add r6, r6, #1
	cmp r6, #2
	rsb r5, r5, #0
	blt _02153E30
	b _02153FD8
_02153EF4:
	mov r5, r0, asr #1
	ldr r0, =0x00000FFF
	mov r9, #0x3000
	rsb r0, r0, #0x800
	str r0, [sp, #0x20]
	ldr r0, =0x00000FFF
	ldr r10, =_mt_math_rand
	sub r0, r0, #0xc00
	ldr r8, =0x3C6EF35F
	str r0, [sp, #0x1c]
	rsb r9, r9, #0
_02153F20:
	ldr r0, [r10]
	mla r3, r0, r7, r8
	mla r1, r3, r7, r8
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mla r2, r1, r7, r8
	mov r3, r0, lsl #0x10
	ldr r0, =_021876CC
	and r1, r11, #7
	ldrb r0, [r0, r1]
	ldr r1, [sp, #0x1c]
	and r1, r1, r3, lsr #16
	sub r3, r9, r1
	mov r1, r2, lsr #0x10
	mov r11, r1, lsl #0x10
	mla r1, r2, r7, r8
	ldr r2, =0x00000FFF
	and r11, r2, r11, lsr #16
	ldr r2, [sp, #0x20]
	add r2, r11, r2
	mov r11, r1, lsr #0x10
	mov r11, r11, lsl #0x10
	mov ip, r11, lsr #0x10
	mla r11, r1, r7, r8
	str r11, [r10]
	str r0, [sp]
	and r0, ip, #7
	sub r1, r0, #3
	ldr r0, [r10]
	ldr ip, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	ldr r11, [r4, #0x44]
	sub r0, r0, #3
	add r2, r5, r2
	add r1, ip, r1, lsl #12
	add r0, r11, r0, lsl #12
	bl EffectCoralDebris__Create
	add r6, r6, #1
	cmp r6, #3
	rsb r5, r5, #0
	blt _02153F20
_02153FD8:
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x218]
	orr r0, r0, #0x10000
	str r0, [r4, #0x218]
	ldr r0, [r4, #0x18]
	orr r0, r0, #8
	str r0, [r4, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154030(StageDecoration *work)
{
    work->objWork.prevPosition.x = work->objWork.position.x - g_obj.camera[0].x;
    work->objWork.prevPosition.y = work->objWork.position.y - g_obj.camera[0].y;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    SetTaskState(&work->objWork, DecorationSys__State_2154074);
}

NONMATCH_FUNC void DecorationSys__State_2154074(StageDecoration *work)
{
    // https://decomp.me/scratch/ggt64 -> 99.45%
#ifdef NON_MATCHING
    static s16 rangeTable[]  = { 0x32, 0x40 };
    static s16 offsetTable[] = { -0x400, -0x500 };

    work->objWork.position.x = work->objWork.prevPosition.x + g_obj.camera[0].x;
    work->objWork.position.y = work->objWork.prevPosition.y + g_obj.camera[0].y;
    work->objWork.position.x = work->objWork.position.x + offsetTable[work->mapDecor->id - MAPDECOR_261];

    u32 type = work->mapDecor->id - MAPDECOR_261;
    if (work->objWork.position.x - g_obj.camera[0].x < -FX32_FROM_WHOLE(rangeTable[type]))
    {
        work->objWork.position.x += FLOAT_TO_FX32(256.0) + (rangeTable[type] << 1);
    }
    else if (work->objWork.position.x - g_obj.camera[0].x > FX32_FROM_WHOLE(rangeTable[type]) + FLOAT_TO_FX32(256.0))
    {
        work->objWork.position.x -= FLOAT_TO_FX32(256.0) + (rangeTable[type] << 1);
    }

    work->objWork.prevPosition.x = work->objWork.position.x - g_obj.camera[0].x;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r2, =g_obj
	ldr r4, [r0, #0x8c]
	ldr r3, [r2, #0x2c]
	mvn r1, #0x104
	add r3, r4, r3
	str r3, [r0, #0x44]
	ldr r4, [r0, #0x90]
	ldr r3, [r2, #0x30]
	ldr ip, =DecorationSys__offsetTable
	add r3, r4, r3
	str r3, [r0, #0x48]
	ldr r3, [r0, #0x20c]
	ldr r4, [r0, #0x44]
	ldrh lr, [r3, #2]
	ldr r3, =DecorationSys__rangeTable
	add lr, lr, r1
	mov lr, lr, lsl #1
	ldrsh ip, [ip, lr]
	add r4, r4, ip
	str r4, [r0, #0x44]
	ldr ip, [r0, #0x20c]
	ldr r2, [r2, #0x2c]
	ldrh ip, [ip, #2]
	sub r2, r4, r2
	add r1, ip, r1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	mov r3, r1, lsl #0xc
	rsb r1, r3, #0
	cmp r2, r1
	bge _0215410C
	mov r1, r3, lsl #1
	ldr r2, [r0, #0x44]
	add r1, r1, #0x100000
	add r1, r2, r1
	str r1, [r0, #0x44]
	b _0215412C
_0215410C:
	add r1, r3, #0x100000
	cmp r2, r1
	ble _0215412C
	mov r1, r3, lsl #1
	ldr r2, [r0, #0x44]
	add r1, r1, #0x100000
	sub r1, r2, r1
	str r1, [r0, #0x44]
_0215412C:
	ldr r1, =g_obj
	ldr r2, [r0, #0x44]
	ldr r1, [r1, #0x2c]
	sub r1, r2, r1
	str r1, [r0, #0x8c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154150(StageDecoration *work)
{
    s32 offset;
    if (work->mapDecor->id != MAPDECOR_134)
        offset = -FLOAT_TO_FX32(43.0);
    else
        offset = FLOAT_TO_FX32(43.0);

    StageDecoration *decor = DecorationSys__CreateTempDecoration(MAPDECOR_297, work->objWork.position.x + offset, work->objWork.position.y - FLOAT_TO_FX32(38.0));
    if (decor != NULL)
        decor->objWork.parentObj = &work->objWork;
}

void DecorationSys__InitFunc_2154194(StageDecoration *work)
{
    work->objWork.userTimer = work->objWork.position.x;
    work->objWork.userWork  = work->objWork.position.y;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    SetTaskState(&work->objWork, DecorationSys__State_21541C0);
}

NONMATCH_FUNC void DecorationSys__State_21541C0(StageDecoration *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =gPlayer
	mov r4, r0
	ldr r0, [r1]
	ldr r2, [r4, #0x2c]
	ldr r3, [r0, #0x44]
	ldr r1, [r0, #0x48]
	ldr r0, [r4, #0x28]
	sub r5, r3, r2
	sub r6, r1, r0
	mov r0, r6
	mov r1, r5
	bl FX_Atan2Idx
	mov r2, r6, asr #6
	mul r1, r2, r2
	mov r2, r5, asr #6
	mla r1, r2, r2, r1
	mov r5, r0
	cmp r1, #0x40000
	movgt r0, #0x4000
	bgt _02154220
	mov r0, r1, lsl #2
	mov r1, #0x40000
	bl FX_Div
_02154220:
	mov r1, r5, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov ip, r1, lsl #1
	add r1, ip, #1
	ldr r3, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r2, [r3, r1]
	mov r1, ip, lsl #1
	ldrsh r1, [r3, r1]
	smull r2, r3, r0, r2
	adds ip, r2, #0x800
	smull r2, r1, r0, r1
	adc r0, r3, #0
	adds r2, r2, #0x800
	mov r3, ip, lsr #0xc
	ldr ip, [r4, #0x2c]
	orr r3, r3, r0, lsl #20
	add r0, ip, r3
	str r0, [r4, #0x44]
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r4, #0x28]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4, #0x48]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void DecorationSys__InitFunc_2154294(StageDecoration *work)
{
    work->objWork.viewOutOffset = 145;
    SetDecorOutFunc(&work->objWork, DecorationSys__Draw_21542BC);
    work->objWork.userTimer = (u16)work->objWork.position.x;
}

void DecorationSys__Draw_21542BC(StageDecoration *work)
{
    work->objWork.userTimer = (s32)(u16)(work->objWork.userTimer + 256);
    work->objWork.offset.y  = MultiplyFX(0x7FFF, SinFX((s32)(u16)work->objWork.userTimer));

    if ((g_obj.flag & OBJECTMANAGER_FLAG_800) != 0)
    {
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[0].x + FLOAT_TO_FX32(128.0))) >> 3;

        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
    }
    else
    {
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[0].x + FLOAT_TO_FX32(128.0))) >> 3;

        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_B;
        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
        work->objWork.offset.x = (work->objWork.position.x - (g_obj.camera[1].x + FLOAT_TO_FX32(128.0))) >> 3;
        work->objWork.obj_2d->ani.screensToDraw &= ~SCREEN_DRAW_B;

        work->objWork.obj_2d->ani.screensToDraw |= SCREEN_DRAW_A;
        StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);
        work->objWork.obj_2d->ani.screensToDraw &= ~SCREEN_DRAW_A;
    }
}

void DecorationSys__InitFunc_21543E8(StageDecoration *work)
{
    work->objWork.userTimer = (u16)work->objWork.position.x;
    SetTaskState(&work->objWork, DecorationSys__State_2154408);
}

void DecorationSys__State_2154408(StageDecoration *work)
{
    work->objWork.userTimer = (s32)(u16)(work->objWork.userTimer + 256);
    work->objWork.offset.y  = MultiplyFX(0x3FFF, SinFX((s32)(u16)work->objWork.userTimer));
}

void DecorationSys__InitFunc_2154478(StageDecoration *work)
{
    ObjRect__SetBox2D(&work->rect[0].rect, 0, -48, 32, 0);
    work->rect[0].parent = &work->objWork;
    ObjRect__SetOnDefend(&work->rect[0], DecorationSys__OnDefend_21544D0);
    work->rect[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
}

void DecorationSys__OnDefend_21544D0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    StageDecoration *decor = (StageDecoration *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (decor != NULL && player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        decor->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        decor->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        decor->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }
}

void DecorationSys__InitFunc_2154510(StageDecoration *work)
{
    SetTaskState(&work->objWork, DecorationSys__State_2154520);
}

NONMATCH_FUNC void DecorationSys__State_2154520(StageDecoration *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r3, =_mt_math_rand
	mov r2, #0
	ldr r5, [r3]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldr ip, =_02188784
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r3]
	str r2, [sp]
	mov r0, r0, lsl #0x1d
	mov r1, r0, lsr #0x1c
	ldr r0, =0x02188785
	ldrsb lr, [ip, r1]
	ldr r5, [r4, #0x44]
	ldrsb r1, [r0, r1]
	ldr ip, [r4, #0x48]
	mov r3, r2
	add r0, r5, lr, lsl #12
	add r1, ip, r1, lsl #12
	bl EffectIceSparkles__Create
	cmp r0, #0
	beq _021545AC
	ldr r1, [r4, #0x128]
	ldrb r1, [r1, #0x56]
	bl StageTask__SetAnimatorPriority
_021545AC:
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r2]
	add r0, r0, #0x3c
	str r0, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DecorationSys__CreateGrind3LineLeaf(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r0, #0x218
	mov r1, #0
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x9e
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr ip, =0x0000FFFF
	str r0, [sp]
	ldr r2, =aActAcEffGrd3lL
	mov r0, r4
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x13
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r1, [sp, #0x20]
	mov r0, r4
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	tst r1, #1
	ldrne r0, [r4, #0x20]
	mov r2, #0
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	tst r1, #2
	ldrne r0, [r4, #0x20]
	mov r3, r2
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	str r5, [r4, #0x9c]
	ldr r0, [r4, #0xd8]
	mov r0, r0, asr #2
	str r0, [r4, #0xd8]
	ldr r1, [r4, #0xdc]
	mov r0, r4
	mov r1, r1, asr #2
	str r1, [r4, #0xdc]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x180
	str r1, [r4, #0x1c]
	ldr r5, [r4, #0x18]
	mov r1, #0x20
	orr r5, r5, #2
	str r5, [r4, #0x18]
	str r2, [sp]
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	ldr r0, =DecorationSys__State_215475C
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void DecorationSys__State_215475C(StageDecoration *work)
{
    if ((mtMathRand() & 0x1F) == 0)
        work->objWork.velocity.x = -work->objWork.velocity.x;

    if ((mtMathRand() & 0x1F) == 0)
        work->objWork.velocity.y >>= 2;
}

NONMATCH_FUNC void DecorationSys__CreateUnknown21547D4(MapDecor *mapDecor, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, r1
	mov r3, r2
	mov r4, #0
	mov r1, r5
	mov r2, r0
	mov r0, #0x22c
	str r4, [sp]
	bl DecorationSys__Construct
	mov r4, r0
	ldr r0, [r4, #0x1c]
	ldr r1, =DecorationSys__State_21548A8
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r0, =DecorationSys__OnDefend_21548D4
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	str r4, [r4, #0x184]
	str r0, [r4, #0x18c]
	ldr r0, [r4, #0x180]
	orr r0, r0, #0xc4
	str r0, [r4, #0x180]
	ldrh r1, [r5, #2]
	cmp r1, #0x114
	beq _0215485C
	ldr r0, =0x00000119
	cmp r1, r0
	addne r0, r0, #1
	cmpne r1, r0
	beq _02154878
	b _02154894
_0215485C:
	mov r3, #0x20
	sub r1, r3, #0x40
	mov r2, r1
	add r0, r4, #0x168
	str r3, [sp]
	bl ObjRect__SetBox2D
	b _02154894
_02154878:
	mov r5, #0x10
	add r0, r4, #0x168
	sub r1, r5, #0x30
	sub r2, r5, #0x20
	mov r3, #0x20
	str r5, [sp]
	bl ObjRect__SetBox2D
_02154894:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void DecorationSys__State_21548A8(StageDecoration *work)
{
    if ((work->objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
    {
        work->objWork.userTimer--;
        if (work->objWork.userTimer <= 0)
            work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

NONMATCH_FUNC void DecorationSys__OnDefend_21548D4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	str r1, [sp, #0x14]
	cmpne r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r1, [r0]
	cmp r1, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x14]
	ldr r1, [r1, #0x20c]
	ldrh r2, [r1, #2]
	cmp r2, #0x114
	beq _02154934
	ldr r1, =0x00000119
	cmp r2, r1
	addne r1, r1, #1
	cmpne r2, r1
	beq _02154AE4
	b _02154B44
_02154934:
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02154B44
	ldr r1, [r0, #0xc0]
	ldr r2, [r0, #0xbc]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	add r1, r2, r1
	cmp r1, #0x1000
	ble _02154B44
	ldr r11, =_mt_math_rand
	ldr r1, [sp, #0x14]
	mov r2, #0x20
	str r2, [r1, #0x2c]
	ldr r1, [r11]
	ldr r5, =0x00196225
	ldr r6, =0x3C6EF35F
	mla r3, r1, r5, r6
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r3, [r11]
	tst r1, #1
	beq _02154B44
	mla r2, r3, r5, r6
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	str r2, [r11]
	add r1, r1, #3
	str r1, [sp, #8]
	ldr r1, [r0, #0xbc]
	ldr r3, [r0, #0xc0]
	mov r1, r1, asr #1
	str r1, [sp, #0x10]
	ldr r1, [sp, #8]
	ldr r4, [r0, #0x44]
	mov r2, r1, asr #1
	mov r1, r3, asr #1
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x10]
	mov r9, #0
	mul r3, r1, r2
	ldr r1, [sp, #0xc]
	sub r7, r4, r3
	mul r2, r1, r2
	ldr r1, [r0, #0x48]
	ldr r0, [sp, #8]
	sub r8, r1, r2
	cmp r0, #0
	ble _02154B44
	ldr r0, =_02188780
	ldr r4, =0x0000FFFE
	str r0, [sp, #4]
	sub r0, r4, #0x8000
	str r0, [sp, #0x20]
	sub r0, r4, #0xc000
	str r0, [sp, #0x1c]
	sub r0, r4, #0xe000
	mov r10, r9
	str r0, [sp, #0x18]
_02154A34:
	ldr r0, [sp, #4]
	ldr r2, [r11]
	ldrb r1, [r0], #1
	str r0, [sp, #4]
	mla r0, r2, r5, r6
	mov r2, r0, lsr #0x10
	mov r3, r2, lsl #0x10
	mla r2, r0, r5, r6
	mla lr, r2, r5, r6
	ldr r0, [sp, #0x18]
	mla ip, lr, r5, r6
	and r0, r0, r3, lsr #16
	rsb r0, r0, r4, lsr #4
	add r3, r10, r0
	mov r0, r2, lsr #0x10
	str ip, [r11]
	str r1, [sp]
	ldr r2, [sp, #0x1c]
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	rsb r2, r0, r4, lsr #3
	mov r0, lr, lsr #0x10
	ldr r1, [sp, #0x20]
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	rsb r0, r0, r4, lsr #2
	add r1, r8, r0
	ldr r0, [r11]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r4, r0, lsr #16
	rsb r0, r0, r4, lsr #1
	add r0, r7, r0
	bl DecorationSys__CreateGrind3LineLeaf
	ldr r0, [sp, #0x10]
	add r9, r9, #1
	add r7, r7, r0
	ldr r0, [sp, #0xc]
	sub r10, r10, #0x400
	add r8, r8, r0
	ldr r0, [sp, #8]
	cmp r9, r0
	blt _02154A34
	b _02154B44
_02154AE4:
	ldr r2, [r0, #0x1c]
	ldr r1, =0x00400001
	tst r2, r1
	beq _02154B44
	ldr r1, [r0, #0xbc]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, #0x800
	bgt _02154B14
	ldr r1, [r0, #0xc0]
	cmp r1, #0
	beq _02154B44
_02154B14:
	ldr r1, [sp, #0x14]
	mov r2, #4
	str r2, [r1, #0x2c]
	bl CreateEffectWaterWakeForPlayer2
	ldr r1, [sp, #0x14]
	ldr r2, [r1, #0x20c]
	ldr r1, =0x00000119
	ldrh r2, [r2, #2]
	cmp r2, r1
	bne _02154B44
	mov r1, #1
	bl StageTask__SetAnimatorPriority
_02154B44:
	ldr r0, [sp, #0x14]
	ldr r0, [r0, #0x18]
	orr r1, r0, #2
	ldr r0, [sp, #0x14]
	str r1, [r0, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 DecorationSys__Func_2154B7C(s32 id)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mvn r0, #0
	ldr r3, =decorUnknownList
	mov r4, r0
	mov ip, #0
_02154B94:
	add r2, r3, ip, lsl #3
	ldrsh r1, [r2, #4]
	cmp r1, #0
	beq _02154BB8
	ldrh r1, [r2, #6]
	cmp r5, r1
	bne _02154BBC
	mov r0, ip
	b _02154BC8
_02154BB8:
	mov r4, ip
_02154BBC:
	add ip, ip, #1
	cmp ip, #4
	blt _02154B94
_02154BC8:
	mvn r1, #0
	cmp r0, r1
	bne _02154C0C
	cmp r4, r1
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl DecorationSys__CreateTempDecoration
	ldr r1, =decorUnknownList
	mov r2, r4, lsl #3
	str r0, [r1, r4, lsl #3]
	str r4, [r0, #0x2c]
	ldr r1, =0x02189EB2
	mov r0, r4
	strh r5, [r1, r2]
_02154C0C:
	ldr r3, =0x02189EB0
	mov r2, r0, lsl #3
	ldrsh r1, [r3, r2]
	add r1, r1, #1
	strh r1, [r3, r2]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void DecorationSys__Func_2154C30(s32 id)
{
    if (decorUnknownList[id].timer != 0)
    {
        decorUnknownList[id].timer--;
        if (decorUnknownList[id].timer == 0)
        {
            decorUnknownList[id].lastDecor->objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME;
            decorUnknownList[id].lastDecor = NULL;
            decorUnknownList[id].lastType  = MAPDECOR_0;
        }
    }
}

void DecorationSys__InitFunc_2154C90(StageDecoration *work)
{
    SetDecorOutFunc(&work->objWork, DecorationSys__Draw_2154D14);
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->destructor = DecorationSys__Destructor_2154CCC;
    AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
}

void DecorationSys__Destructor_2154CCC(StageDecoration *work)
{
    s32 id = work->objWork.userTimer;
    if (decorUnknownList[id].lastDecor == work)
    {
        decorUnknownList[id].lastDecor = NULL;
        decorUnknownList[id].timer     = 0;
        decorUnknownList[id].lastType  = MAPDECOR_0;
    }

    DecorationSys__Destructor_21535B8(work);
}

void DecorationSys__Draw_2154D14(StageDecoration *work)
{
    AnimatorSpriteDS__ProcessAnimationFast(&work->objWork.obj_2d->ani);
}

void DecorationSys__InitFunc_2154D2C(StageDecoration *work)
{
    u16 type = 0xFFFF;
    switch (work->mapDecor->id)
    {
        case MAPDECOR_271:
            type = 298;
            break;

        case MAPDECOR_254:
            type = 299;
            break;

        case MAPDECOR_64:
            type = 300;
            break;

        case MAPDECOR_277:
            type = 301;
            break;

        case MAPDECOR_278:
            type = 302;
            break;

        case MAPDECOR_279:
            type = 303;
            break;

        case MAPDECOR_280:
            type = 304;
            break;
    }

    if (type != 0xFFFF)
    {
        s32 id = DecorationSys__Func_2154B7C(type);
        if (id != -1)
        {
            StageDecoration *lastDecor = decorUnknownList[id].lastDecor;

            work->objWork.userTimer = id;
            work->objWork.obj_2d    = lastDecor->objWork.obj_2d;
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_ANIMATE_CB;
            work->destructor = DecorationSys__Destructor_2154E20;
        }
    }
}

void DecorationSys__Destructor_2154E20(StageDecoration *work)
{
    work->objWork.obj_2d = NULL;

    DecorationSys__Func_2154C30(work->objWork.userTimer);
    DecorationSys__Destructor_21535B8(work);
}

void DecorationSys__SetAnimation(StageDecoration *work, u16 anim)
{
    AnimatorSpriteDS__SetAnimation(&work->objWork.obj_2d->ani, anim);

    for (s32 c = 0; c < STAGETASK_COLLIDER_COUNT; c++)
    {
        if (work->objWork.colliderList[c] != NULL && work->objWork.colliderFlags[c] != STAGE_TASK_COLLIDER_FLAGS_NONE)
            work->objWork.colliderList[c]->flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }
}
