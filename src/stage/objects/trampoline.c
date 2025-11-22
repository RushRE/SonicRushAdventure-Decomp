#include <stage/objects/trampoline.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_width mapObject->width
#define mapObjectParam_id    mapObject->height

// --------------------
// ENUMS
// --------------------

enum TrampolineObjectFlags
{
    TRAMPOLINE_OBJFLAG_NONE,

    TRAMPOLINE_OBJFLAG_TYPE_MASK = 1 << 0,

    TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE = 1 << 7,
};

enum TrampolineType
{
    TRAMPOLINE_TYPE_FLAT,
    TRAMPOLINE_TYPE_SLANTED,

    TRAMPOLINE_TYPE_COUNT,
};

enum TrampolineAnimIDs
{
    TRAMPOLINE_ANI_BASE,
    TRAMPOLINE_ANI_FLAT,
    TRAMPOLINE_ANI_SLOPE_UPWARDS,
    TRAMPOLINE_ANI_SLOPE_DOWNWARDS,
};

// --------------------
// VARIABLES
// --------------------

static u32 allocatedSlots;

static s8 elevationForType[TRAMPOLINE_TYPE_COUNT] = { [TRAMPOLINE_TYPE_FLAT] = 0, [TRAMPOLINE_TYPE_SLANTED] = -2 };

// --------------------
// FUNCTION DECLS
// --------------------

static void Trampoline_Destructor(Task *task);
static void Trampoline_State_Active(Trampoline *work);
static void Trampoline_InitNodeList(Trampoline *work);
static void Trampoline_CalculateNodeDeform(Trampoline *work);
static void Trampoline_Draw(void);
static void Trampoline_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static BOOL Trampoline_AllocateSlot(u8 id);
static void Trampoline_ReleaseSlot(u8 id);

// --------------------
// FUNCTIONS
// --------------------

Trampoline *CreateTrampoline(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (!Trampoline_AllocateSlot(mapObjectParam_id))
        return NULL;

    Task *task = CreateStageTask(Trampoline_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), Trampoline);
    if (task == HeapNull)
        return NULL;

    Trampoline *work = TaskGetWork(task, Trampoline);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->type        = mapObject->flags & TRAMPOLINE_OBJFLAG_TYPE_MASK;
    work->targetPos.x = FX32_FROM_WHOLE(mapObjectParam_width << 4);

    if (work->targetPos.x > FLOAT_TO_FX32(512.0))
    {
        work->targetPos.x = FLOAT_TO_FX32(512.0);
    }
    else if (work->targetPos.x < FLOAT_TO_FX32(64.0))
    {
        work->targetPos.x = FLOAT_TO_FX32(64.0);
    }

    work->targetPos.y = elevationForType[work->type] * (work->targetPos.x >> 3);

    if ((mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) != 0)
        work->targetPos.y = -work->targetPos.y;

    work->drawData = HeapAllocHead(HEAP_SYSTEM, 0x400);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    u16 anims[] = { TRAMPOLINE_ANI_FLAT, TRAMPOLINE_ANI_SLOPE_UPWARDS, TRAMPOLINE_ANI_SLOPE_UPWARDS };

    void *sprTrampoline = ObjDataLoad(GetObjectDataWork(OBJDATAWORK_95), "/act/ac_gmk_trampoline3d.bac", gameArchiveStage);

    VRAMPaletteKey vramPalette = ObjActionAllocPalette(GetObjectGraphicsRef(OBJDATAWORK_97), Sprite__GetPaletteSizeFromAnim(sprTrampoline, TRAMPOLINE_ANI_BASE));
    VRAMPixelKey vramPixels    = ObjActionAllocTexture(GetObjectGraphicsRef(OBJDATAWORK_96), Sprite__GetTextureSizeFromAnim(sprTrampoline, TRAMPOLINE_ANI_BASE));
    AnimatorSprite3D__Init(&work->aniTrampoline, ANIMATOR_FLAG_NONE, sprTrampoline, TRAMPOLINE_ANI_BASE, ANIMATOR_FLAG_NONE, vramPixels, vramPalette);
    AnimatorSprite3D__ProcessAnimationFast(&work->aniTrampoline);

    u16 anim;
    if (work->type == 0)
    {
        anim = TRAMPOLINE_ANI_FLAT - 1;
    }
    else
    {
        if ((mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) != 0)
            anim = TRAMPOLINE_ANI_SLOPE_DOWNWARDS - 1;
        else
            anim = TRAMPOLINE_ANI_SLOPE_UPWARDS - 1;
    }

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_VRAM_A;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_trampoline3d.bac", GetObjectDataWork(OBJDATAWORK_95), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, anims[anim], GetObjectSpriteRef(2 * anim + OBJDATAWORK_98));

    if (GetCurrentZoneID() == ZONE_SKY_BABYLON)
        ObjActionAllocSpritePalette(&work->gameWork.objWork, anim + TRAMPOLINE_ANI_FLAT, 97);
    else
        ObjActionAllocSpritePalette(&work->gameWork.objWork, anim + TRAMPOLINE_ANI_FLAT, 89);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, anim + TRAMPOLINE_ANI_FLAT);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_UNCOMPRESSED_PIXELS | ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__ProcessAnimationFast(&work->gameWork.animator.ani);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;

    G3_BeginMakeDL(&work->drawList, work->drawData, 0x400);
    G3C_PolygonAttr(&work->drawList, GX_LIGHTID_0, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, GX_COLOR_FROM_888(0xFF), GX_POLYGON_ATTR_MISC_NONE);
    G3C_TexPlttBase(&work->drawList, VRAMKEY_TO_KEY(work->aniTrampoline.animatorSprite.vramPalette) & 0x1FFFF, GX_TEXFMT_PLTT16);
    G3C_TexImageParam(&work->drawList, GX_TEXFMT_PLTT16, GX_TEXGEN_TEXCOORD, GX_TEXSIZE_S8, GX_TEXSIZE_T8, GX_TEXREPEAT_S, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS,
                      VRAMKEY_TO_KEY(work->aniTrampoline.animatorSprite.vramPixels) & 0x7FFFF);

    G3C_MtxMode(&work->drawList, GX_MTXMODE_TEXTURE);

    FXMatrix43 mtx;
    MTX_Identity43(mtx.nnMtx);
    G3C_LoadMtx43(&work->drawList, mtx.nnMtx);
    G3C_MtxMode(&work->drawList, GX_MTXMODE_POSITION);

    work->position = work->gameWork.objWork.position;

    if (mapObject->id == MAPOBJECT_200)
    {
        work->position.x -= work->targetPos.x;
        work->position.y -= work->targetPos.y;
    }

    work->nodePositionList[0].start.x = FLOAT_TO_FX32(0.0);
    work->nodePositionList[0].start.y = FLOAT_TO_FX32(0.0);
    work->nodePositionList[0].end.x   = FLOAT_TO_FX32(0.0);
    work->nodePositionList[0].end.y   = -FLOAT_TO_FX32(8.0);

    work->nodePositionList[11].start.x = work->targetPos.x;
    work->nodePositionList[11].start.y = -work->targetPos.y;
    work->nodePositionList[11].start.z = FLOAT_TO_FX32(0.0);

    work->nodePositionList[11].end.x = work->targetPos.x;
    work->nodePositionList[11].end.y = -FLOAT_TO_FX32(8.0) - work->targetPos.y;
    work->nodePositionList[11].end.z = FLOAT_TO_FX32(0.0);

    Trampoline_InitNodeList(work);

    s16 left  = FX32_TO_WHOLE(work->position.x - work->gameWork.objWork.position.x);
    s16 right = left + FX32_TO_WHOLE(work->targetPos.x);

    s16 top;
    s16 bottom;
    if ((mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) != 0)
    {
        top    = FX32_TO_WHOLE(work->position.y - work->gameWork.objWork.position.y);
        bottom = top + FX32_TO_WHOLE(work->targetPos.y);
    }
    else
    {
        bottom = FX32_TO_WHOLE(work->position.y - work->gameWork.objWork.position.y);
        top    = bottom + FX32_TO_WHOLE(work->targetPos.y);
    }
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, left - 16, top - 24, right + 16, bottom + 24);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Trampoline_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE;

    if (work->gameWork.objWork.viewOutOffset < (s16)(FX32_TO_WHOLE(work->targetPos.x) + 86))
        work->gameWork.objWork.viewOutOffset = (s16)(FX32_TO_WHOLE(work->targetPos.x) + 86);

    SetTaskOutFunc(&work->gameWork.objWork, Trampoline_Draw);
    SetTaskState(&work->gameWork.objWork, Trampoline_State_Active);

    return work;
}

void Trampoline_Destructor(Task *task)
{
    Trampoline *work = TaskGetWork(task, Trampoline);

    Trampoline_ReleaseSlot(work->gameWork.mapObjectParam_id);
    HeapFree(HEAP_SYSTEM, work->drawData);

    OBS_DATA_WORK *paletteWork = GetObjectDataWork(OBJDATAWORK_97);
    paletteWork->referenceCount--;
    if (paletteWork->referenceCount == 0)
    {
        VRAMSystem__FreePalette(VRAMKEY_TO_ADDR(paletteWork->fileData));
        paletteWork->fileData = NULL;
    }

    OBS_DATA_WORK *textureWork = GetObjectFileWork(OBJDATAWORK_96);
    textureWork->referenceCount--;
    if (textureWork->referenceCount == 0)
    {
        VRAMSystem__FreeTexture(VRAMKEY_TO_ADDR(textureWork->fileData));
        textureWork->fileData = NULL;
    }

    ObjDataRelease(GetObjectDataWork(OBJDATAWORK_95));

    GameObject__Destructor(task);
}

NONMATCH_FUNC void Trampoline_State_Active(Trampoline *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	mov r3, r0
	ldr r2, [r3, #0x35c]
	mov r0, #0
	cmp r2, #0
	beq _021796E8
	ldr r1, [r2, #0x6d8]
	cmp r1, r3
	moveq r0, r2
	beq _021796E8
	str r0, [r3, #0x35c]
	str r3, [r3, #0x234]
	ldr r1, [r3, #0x230]
	bic r1, r1, #0x800
	str r1, [r3, #0x230]
	ldr r1, [r3, #0x354]
	orr r1, r1, #1
	str r1, [r3, #0x354]
	ldr r4, [r3, #0x5bc]
	ldr r2, [r3, #0x4fc]
	ldr r1, [r3, #0x5e0]
	sub r2, r4, r2
	sub r2, r2, r1
	str r2, [r3, #0x5d0]
	ldr r1, [r3, #0x5c8]
	add r1, r2, r1, asr #1
	str r1, [r3, #0x5d4]
	str r0, [r3, #0x5dc]
	ldr r1, [r3, #0x5d0]
	mov r1, r1, asr #3
	rsb r1, r1, #0
	str r1, [r3, #0x5d8]
_021796E8:
	cmp r0, #0
	beq _02179840
	add r0, r0, #0x44
	add r4, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [sp, #4]
	ldr r1, [sp]
	add r0, r0, #0xd000
	str r0, [sp, #4]
	ldr r0, [r3, #0x5b8]
	add r6, r3, #0x18
	sub r0, r1, r0
	sub r0, r0, #0x4000
	str r0, [r3, #0x4f8]
	ldr r0, [sp, #4]
	ldr r1, [r3, #0x5bc]
	mov r5, #1
	sub r1, r0, r1
	rsb r1, r1, #0
	str r1, [r3, #0x4fc]
	ldr r1, [r3, #0x4f8]
	str r1, [r3, #0x504]
	ldr r1, [r3, #0x4fc]
	sub r1, r1, #0x8000
	str r1, [r3, #0x508]
	ldr r2, [sp]
	ldr r1, [r3, #0x5b8]
	sub r1, r2, r1
	add r1, r1, #0x4000
	str r1, [r3, #0x510]
	ldr r1, [r3, #0x5bc]
	sub r0, r0, r1
	rsb r0, r0, #0
	str r0, [r3, #0x514]
	ldr r0, [r3, #0x510]
	str r0, [r3, #0x51c]
	ldr r0, [r3, #0x514]
	sub r0, r0, #0x8000
	str r0, [r3, #0x520]
	ldr r7, [r3, #0x510]
	ldr r4, [r3, #0x588]
	ldr r10, [r3, #0x4f8]
	ldr r2, [r3, #0x480]
	sub lr, r7, r4
	ldr r9, [r3, #0x4fc]
	ldr r8, [r3, #0x484]
	ldr r1, [r3, #0x514]
	ldr r0, [r3, #0x58c]
	mov r7, #0x18
	sub ip, r9, r8
	sub r2, r10, r2
	sub r4, r1, r0
	mov r8, r7
_021797C0:
	ldr r1, [r6, #0x468]
	rsb r0, r5, #0xc
	add r1, r1, r2, asr r5
	str r1, [r6, #0x480]
	ldr r1, [r6, #0x46c]
	rsb r9, r5, #0xb
	add r1, r1, ip, asr r5
	str r1, [r6, #0x484]
	ldr r10, [r6, #0x480]
	mla r1, r0, r7, r3
	str r10, [r6, #0x48c]
	ldr r10, [r6, #0x484]
	mla r0, r9, r8, r3
	sub r9, r10, #0x8000
	str r9, [r6, #0x490]
	ldr r9, [r1, #0x480]
	add r6, r6, #0x18
	add r9, r9, lr, asr r5
	str r9, [r0, #0x480]
	ldr r1, [r1, #0x484]
	add r1, r1, r4, asr r5
	str r1, [r0, #0x484]
	ldr r1, [r0, #0x480]
	add r5, r5, #1
	str r1, [r0, #0x48c]
	ldr r1, [r0, #0x484]
	cmp r5, #5
	sub r1, r1, #0x8000
	str r1, [r0, #0x490]
	blt _021797C0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_02179840:
	ldr r0, [r3, #0x354]
	tst r0, #1
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r2, [r3, #0x5dc]
	ldr r1, [r3, #0x5d8]
	mov r0, #1
	add r2, r2, r1
	str r2, [r3, #0x5dc]
	ldr r1, [r3, #0x5d4]
	add r1, r1, r2
	str r1, [r3, #0x5d4]
	ldr r5, [r3, #0x5d8]
	cmp r5, #0
	bge _021798D0
	ldr r2, [r3, #0x5d4]
	ldr r1, [r3, #0x5c8]
	cmp r2, r1, asr #1
	bgt _021798F8
	rsb r1, r5, #0
	movs r1, r1, asr #1
	str r1, [r3, #0x5d8]
	rsbmi r1, r1, #0
	cmp r1, #0x800
	bgt _021798B8
	ldr r1, [r3, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r3, #0x354]
	b _021798F8
_021798B8:
	mov r1, #0
	str r1, [r3, #0x5dc]
	ldr r1, [r3, #0x5d0]
	mov r1, r1, asr #1
	str r1, [r3, #0x5d0]
	b _021798F8
_021798D0:
	ldr r2, [r3, #0x5c8]
	ldr r1, [r3, #0x5d0]
	ldr r4, [r3, #0x5d4]
	add r1, r1, r2, asr #1
	cmp r4, r1
	blt _021798F8
	rsb r1, r5, #0
	str r1, [r3, #0x5d8]
	mov r1, #0
	str r1, [r3, #0x5dc]
_021798F8:
	cmp r0, #0
	mov r0, r3
	beq _02179910
	bl Trampoline_CalculateNodeDeform
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_02179910:
	bl Trampoline_InitNodeList
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void Trampoline_InitNodeList(Trampoline *work)
{
    s32 i;

    TrampolineNode *next;
    TrampolineNode *node;

    fx32 stepX = FX_DivS32(work->targetPos.x, 11);
    fx32 stepY = FX_DivS32(-work->targetPos.y, 11);

    node = &work->nodePositionList[0];
    next = &work->nodePositionList[1];

    for (i = 1; i < TRAMPOLINE_NODE_MAX - 1; i++)
    {
        next->start.x = node->start.x + stepX;
        next->start.y = node->start.y + stepY;
        next->end.x   = next->start.x;
        next->end.y   = next->start.y - FLOAT_TO_FX32(8.0);

        node = next;
        next++;
    }
}

NONMATCH_FUNC void Trampoline_CalculateNodeDeform(Trampoline *work)
{
    // https://decomp.me/scratch/WcK74 -> 91.12%
#ifdef NON_MATCHING
    s32 targetY = -work->targetPos.y;

    s32 v2 = targetY >> 1;
    s32 v3 = -(work->field_5D4 + v2);

    s32 offsetX  = work->targetPos.x >> 2;
    s32 offsetY2 = v2 >> 1;

    s32 nextOffsetX  = offsetX - (work->targetPos.x >> 1);
    s32 offsetY1     = v3 >> 1;
    s32 nextOffsetY2 = v2 - (v2 >> 1);
    s32 nextOffsetY1 = v3 - (v3 >> 1);

    for (s32 i = 0; i < 5; i++)
    {
        work->nodePositionList[i + 1].start.x = work->nodePositionList[i + 0].start.x + offsetX;
        work->nodePositionList[i + 1].start.y = work->nodePositionList[i + 0].start.y + offsetY1 + offsetY2;

        work->nodePositionList[i + 1].end.x = work->nodePositionList[i + 1].start.x;
        work->nodePositionList[i + 1].end.y = work->nodePositionList[i + 1].start.y - FLOAT_TO_FX32(8.0);

        work->nodePositionList[10 - i].start.x = work->nodePositionList[11 - i].start.x - offsetX;
        work->nodePositionList[10 - i].start.y = work->nodePositionList[11 - i].start.y - offsetY2 + offsetY1;

        work->nodePositionList[10 - i].end.x = work->nodePositionList[10 - i].start.x;
        work->nodePositionList[10 - i].end.y = work->nodePositionList[10 - i].start.y - FLOAT_TO_FX32(8.0);

        offsetX  = nextOffsetX >> 1;
        offsetY2 = nextOffsetY2 >> 1;
        offsetY1 = nextOffsetY1 >> 1;

        nextOffsetX -= offsetX;
        nextOffsetY2 -= offsetY2;
        nextOffsetY1 -= offsetY1;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r2, [r0, #0x5c8]
	ldr r1, [r0, #0x5d4]
	rsb r2, r2, #0
	ldr r3, [r0, #0x5c4]
	add r1, r1, r2, asr #1
	mov r5, r2, asr #1
	mov r7, r3, asr #1
	rsb r4, r1, #0
	mov r3, r4, asr #1
	mov r6, r0
	mov r1, r7, asr #1
	sub ip, r7, r7, asr #1
	mov r2, r5, asr #1
	sub lr, r5, r5, asr #1
	sub r4, r4, r4, asr #1
	mov r5, #0
	mov r7, #0x18
_021799E0:
	ldr r8, [r6, #0x480]
	rsb r9, r5, #0xb
	add r8, r1, r8
	str r8, [r6, #0x498]
	ldr r10, [r6, #0x484]
	rsb r8, r5, #0xa
	add r10, r2, r10
	add r10, r3, r10
	str r10, [r6, #0x49c]
	mov r10, #0x18
	mla r10, r9, r10, r0
	ldr r11, [r6, #0x498]
	mla r9, r8, r7, r0
	str r11, [r6, #0x4a4]
	ldr r11, [r6, #0x49c]
	add r5, r5, #1
	sub r8, r11, #0x8000
	str r8, [r6, #0x4a8]
	ldr r8, [r10, #0x480]
	add r6, r6, #0x18
	sub r1, r8, r1
	str r1, [r9, #0x480]
	ldr r8, [r10, #0x484]
	mov r1, ip, asr #1
	sub r2, r8, r2
	add r2, r3, r2
	str r2, [r9, #0x484]
	ldr r3, [r9, #0x480]
	mov r2, lr, asr #1
	str r3, [r9, #0x48c]
	ldr r8, [r9, #0x484]
	mov r3, r4, asr #1
	sub r8, r8, #0x8000
	str r8, [r9, #0x490]
	sub ip, ip, ip, asr #1
	sub lr, lr, lr, asr #1
	sub r4, r4, r4, asr #1
	cmp r5, #5
	blt _021799E0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void Trampoline_Draw(void)
{
    Trampoline *work = TaskGetWorkCurrent(Trampoline);

    GXDLInfo info;

    MtxFx44 mtx;
    VecFx32 scale;
    VecFx32 outputPos;
    FXMatrix33 matRot;

    VEC_Set(&scale, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        scale.x = MultiplyFX(g_obj.scale.x, scale.x);

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        scale.y = MultiplyFX(g_obj.scale.y, scale.y);

    scale.x <<= 7;
    scale.y <<= 7;
    scale.z <<= 7;

    MTX_Identity33(matRot.nnMtx);
    GameObject__TransformWorldToScreen(&work->position, &outputPos, &mtx, FALSE);
    NNS_G3dGlbSetBaseScale(&scale);
    NNS_G3dGlbSetBaseRot(matRot.nnMtx);
    NNS_G3dGlbSetBaseTrans(&outputPos);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION);
    NNS_G3dGlbFlush();

    info = work->drawList;
    G3C_Begin(&info, GX_BEGIN_QUAD_STRIP);

    s32 i             = 0;
    fx32 texS         = 0;
    fx32 lastStartPos = 0;
    G3C_Color(&info, GX_RGB_888(0xFF, 0xFF, 0xFF));

    lastStartPos         = work->nodePositionList[0].start.x;
    TrampolineNode *node = work->nodePositionList;
    for (i = 0; i < TRAMPOLINE_NODE_MAX; i++)
    {
        texS += node->start.x - lastStartPos;
        lastStartPos = node->start.x;

        G3C_TexCoord(&info, texS, FLOAT_TO_FX32(0.0));
        G3C_Vtx(&info, node->start.x >> 7, node->start.y >> 7, node->start.z >> 7);

        G3C_TexCoord(&info, texS, FLOAT_TO_FX32(8.0));
        G3C_Vtx(&info, node->end.x >> 7, node->end.y >> 7, node->end.z >> 7);

        node++;
    }
    G3C_End(&info);
    G3_EndMakeDL(&info);
    DC_FlushRange(work->drawData, 0x400);

    NNS_G3dGeSendDL(work->drawData, G3_GetDLSize(&info));

    VecFx32 position;
    position = work->position;

    s32 n;
    fx32 stepY = FLOAT_TO_FX32(2.0) * elevationForType[work->type];
    if ((work->gameWork.mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) != 0)
        stepY = -FLOAT_TO_FX32(2.0) * elevationForType[work->type];

    for (n = 0; n < work->targetPos.x >> 16; n++)
    {
        StageTask__Draw2DEx(&work->gameWork.animator.ani, &position, NULL, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
        position.x += FLOAT_TO_FX32(16.0);
        position.y += stepY;
    }
}

NONMATCH_FUNC void Trampoline_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING
    Trampoline *trampoline = (Trampoline *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (trampoline == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0 && player->objWork.velocity.y >= 0 && player->gimmickObj == NULL)
    {
        fx32 playerX     = player->objWork.position.x;
        fx32 playerY     = player->objWork.position.y;
        fx32 playerMoveX = player->objWork.prevPosition.x - playerX;
        fx32 playerMoveY = player->objWork.prevPosition.y - playerY;
        BOOL canBounce   = FALSE;

        if (trampoline->type == 0
            || trampoline->type == 1
                   && ((trampoline->gameWork.mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) != 0 && playerMoveX >= 0
                       || (trampoline->gameWork.mapObject->flags & TRAMPOLINE_OBJFLAG_DOWNWARDS_SLOPE) == 0 && playerMoveX <= 0))
        {
            playerMoveX *= 16;
            playerMoveY *= 16;
        }
        fx32 targetX = -trampoline->targetPos.y;
        fx32 targetY = -trampoline->targetPos.x;

        fx32 magnitude = MultiplyFX(playerMoveX, targetX) - MultiplyFX(playerMoveY, targetY);
        if (magnitude != 0)
        {
            fx32 distanceY = trampoline->position.y - (playerY + FLOAT_TO_FX32(12.0));
            fx32 distanceX = trampoline->position.x - playerX;

            fx32 targetPos   = MultiplyFX(distanceX, targetX) - MultiplyFX(distanceY, targetY);
            fx32 distancePos = MultiplyFX(distanceX, playerMoveY) - MultiplyFX(distanceY, playerMoveX);

            if (magnitude < 0)
            {
                magnitude   = -magnitude;
                targetPos   = -targetPos;
                distancePos = -distancePos;
            }

            if (targetPos >= 0 && magnitude >= targetPos && distancePos >= 0 && magnitude >= distancePos)
                canBounce = TRUE;
        }

        if (canBounce)
        {
            trampoline->gameWork.parent = &player->objWork;
            Player__Action_TrampolineLand(player, &trampoline->gameWork);
            trampoline->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
            trampoline->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            trampoline->playerBouncePos = player->objWork.position.y;
            return;
        }
    }

    ObjRect__FuncNoHit(rect1, rect2);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r5, #0
	cmpne r4, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r2, [r4, #0]
	cmp r2, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [r4, #0x1c]
	tst r2, #0x10
	beq _02179DB0
	ldr r2, [r4, #0x9c]
	cmp r2, #0
	blt _02179DB0
	ldr r2, [r4, #0x6d8]
	cmp r2, #0
	beq _02179DBC
_02179DB0:
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02179DBC:
	add r2, r5, #0x500
	ldrh r8, [r2, #0xcc]
	ldr r2, [r4, #0x44]
	ldr r6, [r4, #0x8c]
	str r2, [sp]
	ldr r3, [sp]
	ldr r2, [r4, #0x48]
	ldr r7, [r4, #0x90]
	sub r6, r6, r3
	mov r3, #0
	cmp r8, #0
	sub r7, r7, r2
	str r3, [sp, #4]
	beq _02179E24
	cmp r8, #1
	bne _02179E2C
	ldr r3, [r5, #0x340]
	ldrh r3, [r3, #4]
	ands r3, r3, #0x80
	beq _02179E14
	cmp r6, #0
	bge _02179E24
_02179E14:
	cmp r3, #0
	bne _02179E2C
	cmp r6, #0
	bgt _02179E2C
_02179E24:
	mov r6, r6, lsl #4
	mov r7, r7, lsl #4
_02179E2C:
	ldr r3, [r5, #0x5c8]
	ldr r8, [r5, #0x5c4]
	rsb ip, r3, #0
	smull r3, r9, r6, ip
	adds r10, r3, #0x800
	rsb lr, r8, #0
	smull r8, r3, r7, lr
	adc r9, r9, #0
	adds r8, r8, #0x800
	mov r10, r10, lsr #0xc
	adc r3, r3, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r3, lsl #20
	mov r3, lr, asr #0x1f
	str r3, [sp, #8]
	mov r3, r7, asr #0x1f
	str r3, [sp, #0xc]
	mov r3, ip, asr #0x1f
	orr r10, r10, r9, lsl #20
	str r3, [sp, #0x1c]
	mov r3, r6, asr #0x1f
	subs r8, r10, r8
	str r3, [sp, #0x10]
	beq _02179F84
	ldr r3, [r5, #0x5bc]
	add r2, r2, #0xc000
	sub r3, r3, r2
	ldr r9, [r5, #0x5b8]
	ldr r2, [sp]
	mov r11, r3, asr #0x1f
	sub r2, r9, r2
	str r2, [sp, #0x14]
	mov r2, r2, asr #0x1f
	ldr r9, [sp, #0x14]
	str r2, [sp, #0x20]
	umull r10, r2, r9, ip
	str r10, [sp, #0x18]
	mov r10, r9
	ldr r9, [sp, #0x1c]
	mla r2, r10, r9, r2
	ldr r9, [sp, #0x20]
	ldr r10, [sp, #0x18]
	mla r2, r9, ip, r2
	adds r9, r10, #0x800
	mov r10, r9, lsr #0xc
	adc r2, r2, #0
	orr r10, r10, r2, lsl #20
	ldr r2, [sp, #8]
	umull ip, r9, r3, lr
	mla r9, r3, r2, r9
	adds r2, ip, #0x800
	mla r9, r11, lr, r9
	adc r9, r9, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r9, lsl #20
	sub r2, r10, r2
	ldr ip, [sp, #0x10]
	umull r10, r9, r3, r6
	mla r9, r3, ip, r9
	mla r9, r11, r6, r9
	adds r6, r10, #0x800
	ldr r10, [sp, #0x14]
	adc r3, r9, #0
	mov r9, r6, lsr #0xc
	orr r9, r9, r3, lsl #20
	umull r6, r3, r10, r7
	mov r11, r10
	ldr r10, [sp, #0xc]
	mla r3, r11, r10, r3
	ldr r10, [sp, #0x20]
	mla r3, r10, r7, r3
	adds r7, r6, #0x800
	adc r3, r3, #0
	cmp r8, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r3, lsl #20
	sub r3, r9, r6
	rsblt r8, r8, #0
	rsblt r2, r2, #0
	rsblt r3, r3, #0
	cmp r2, #0
	cmpge r8, r2
	cmpge r3, #0
	cmpge r8, r3
	movge r2, #1
	strge r2, [sp, #4]
_02179F84:
	ldr r2, [sp, #4]
	cmp r2, #0
	beq _02179FC4
	mov r0, r4
	mov r1, r5
	str r4, [r5, #0x35c]
	bl Player__Action_TrampolineLand
	mov r0, #0
	str r0, [r5, #0x234]
	ldr r0, [r5, #0x230]
	add sp, sp, #0x24
	orr r0, r0, #0x800
	str r0, [r5, #0x230]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x5e0]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02179FC4:
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

BOOL Trampoline_AllocateSlot(u8 id)
{
    if ((allocatedSlots & (1 << id)) != 0)
        return FALSE;

    allocatedSlots |= (1 << id);

    return TRUE;
}

void Trampoline_ReleaseSlot(u8 id)
{
    allocatedSlots &= ~(1 << id);
}