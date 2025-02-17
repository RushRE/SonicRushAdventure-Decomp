#include <hub/cviMap.hpp>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <hub/hubConfig.h>
#include <hub/hubAudio.h>
#include <game/graphics/paletteAnimation.h>
#include <game/file/fsRequest.h>

// resources
#include <resources/narc/vi_act_lz7.h>
#include <resources/narc/vi_bg_lz7.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl17GetBackgroundFileEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B03CEv(void);

NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZnwmPv(void);

NOT_DECOMPILED fx32 Unknown2051334__Func_2051534(s32 a1, s32 a2, s32 a3, s32 a4, s32 a5);
}

// --------------------
// VARIABLES
// --------------------

Task *mapTaskSingleton;
Task *mapPaletteAnimationTaskSingleton;

// --------------------
// FUNCTIONS
// --------------------

void ViMap__Create(void)
{
    // TODO: use 'HubTaskCreate' when 'ViMap__CreateInternal' matches
    // mapTaskSingleton = HubTaskCreate(ViMap__Main_Idle, ViMap__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1040, TASK_GROUP(16), CViMap);
    mapTaskSingleton = ViMap__CreateInternal(ViMap__Main_Idle, ViMap__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1040, TASK_GROUP(16));

    CViMap *work          = TaskGetWork(mapTaskSingleton, CViMap);
    work->mapPos.x        = 0;
    work->mapPos.y        = 0;
    work->mapPrevPos.x    = 0;
    work->mapPrevPos.y    = 0;
    work->mapTargetPos.x  = 0;
    work->mapTargetPos.y  = 0;
    work->mapMoveDuration = 0;
    work->mapMoveTimer    = 0;

    InitHubBGCircleEffect(&work->bgCircleEffect);

    ViMap__InitMapBack(work);
    ViMap__InitMapIcon(work);
    ViMap__Func_215CA60(work);
    ViMap__InitSprites(work);
    ViMap__InitUnknown2056FDC(work);
    ViMap__InitUnknown(work);
}

// TODO: should match when constructors are decompiled for 'CViMapIcon' & 'CViMapBack'
NONMATCH_FUNC Task *ViMap__CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, =0x00000FB4
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, r4
	bl _ZnwmPv
	movs r4, r0
	beq _0215BAE0
	bl _ZN10CViMapBackC1Ev
	add r0, r4, #0x5d0
	bl _ZN10CViMapIconC1Ev
_0215BAE0:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void ViMap__Destroy(void)
{
    if (mapTaskSingleton != NULL)
    {
        CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);
        UNUSED(work);

        DestroyTask(mapTaskSingleton);

        mapTaskSingleton = NULL;
    }
}

void ViMap__SetType(s32 type)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    switch (type)
    {
        case CViMap::TYPE_MAP_ACTIVE:
            SetTaskMainEvent(mapTaskSingleton, ViMap__Main_Moving);
            break;

        case CViMap::TYPE_DOCK_ACTIVE:
            SetTaskMainEvent(mapTaskSingleton, ViMap__Main_Idle);
            break;

        case CViMap::TYPE_CONSTRUCTION_CUTSCENE:
            work->cutsceneState = 6;
            SetTaskMainEvent(mapTaskSingleton, ViMap__Main_ConstructionCutscene);
            break;
    }
}

void ViMap__WarpToPosition(u16 x, u16 y)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapPos.x        = x;
    work->mapPos.y        = y;
    work->mapPrevPos.x    = x;
    work->mapPrevPos.y    = y;
    work->mapTargetPos.x  = x;
    work->mapTargetPos.y  = y;
    work->mapMoveDuration = 0;
    work->mapMoveTimer    = 0;
}

void ViMap__TravelToPosition(u16 x, u16 y, u16 duration)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapTargetPos.x  = x;
    work->mapTargetPos.y  = y;
    work->mapPrevPos.x    = work->mapPos.x;
    work->mapPrevPos.y    = work->mapPos.y;
    work->mapMoveDuration = duration;
    work->mapMoveTimer    = 0;
}

void ViMap__GetMapPosition(u16 *x, u16 *y)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    if (x != NULL)
        *x = work->mapPos.x;

    if (y != NULL)
        *y = work->mapPos.y;
}

MapArea ViMap__GetMapAreaFromMapIconTouchInput(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    return work->mapIcon.GetAreaFromTouchInput();
}

MapArea ViMap__GetMapAreaFromMapIconMarker(BOOL mustBeIdle)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    if (mustBeIdle && work->mapIcon.IsMoving())
        return MAPAREA_INVALID;

    return work->mapIcon.GetCurrentArea();
}

void ViMap__GoToMapArea(u32 mapArea, BOOL shouldTravel)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    u16 y, x;
    if (shouldTravel)
    {
        work->mapIcon.TravelToArea(mapArea);
        work->mapIcon.GetIconPosition(mapArea, &x, &y);

        x += 8;
        y += 8;
        ViMap__ClampPosToMapBounds(x, y, &x, &y);
        ViMap__TravelToPosition(x, y, 32);
    }
    else
    {
        work->mapIcon.WarpToArea(mapArea);
        work->mapIcon.GetIconPosition(mapArea, &x, &y);

        x += 8;
        y += 8;
        ViMap__ClampPosToMapBounds(x, y, &x, &y);
        ViMap__WarpToPosition(x, y);
    }
}

MapArea ViMap__GetChosenMapArea(void)
{
    MapArea mapArea = ViMap__GetMapAreaFromMapIconMarker(TRUE);

    if (mapArea >= MAPAREA_COUNT)
        return MAPAREA_INVALID;

    if (mapArea == ViMap__GetMapAreaFromMapIconTouchInput())
        return mapArea;

    if ((padInput.btnPress & PAD_BUTTON_A) == 0)
        mapArea = MAPAREA_INVALID;

    return mapArea;
}

void ViMap__StartShipConstructCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID  = id;
    work->decorConstructionID = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID       = CViMap::UPGRADE_SHIP_INVALID;
    work->vmiFile             = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapConfig(work->shipConstructionID)->mapArea)->field_3C;

    s32 i;
    AnimatorSprite *aniMaterialIcon = &work->aniMaterialIcon[0];
    for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        AnimatorSprite__SetAnimation(aniMaterialIcon, i);
        aniMaterialIcon->paletteMode    = PALETTE_MODE_SUB_OBJ;
        aniMaterialIcon->vramPalette    = NULL;
        aniMaterialIcon->cParam.palette = PALETTE_ROW_15;
        aniMaterialIcon->oamPriority    = SPRITE_PRIORITY_0;
        aniMaterialIcon->oamOrder       = SPRITE_ORDER_1;

        aniMaterialIcon++;
    }

    AnimatorSprite__SetAnimation(&work->aniRingIcon, 0);
    work->aniRingIcon.cParam.alpha = PALETTE_ROW_12;
    work->aniRingIcon.oamPriority  = SPRITE_PRIORITY_0;
    work->aniRingIcon.oamOrder     = SPRITE_ORDER_0;

    AnimatorSprite *aniSparkle = &work->aniSparkle[0];
    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniSparkle); i++)
    {
        aniSparkle->cParam.palette = PALETTE_ROW_13;
        aniSparkle->oamPriority    = SPRITE_PRIORITY_0;
        aniSparkle->oamOrder       = SPRITE_ORDER_1;

        aniSparkle++;
    }

    u16 x, y;
    ViMap__ClampPosToMapBounds(32, 40, &x, &y);
    ViMap__WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForShipConstructionCutscene();

    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);
    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void ViMap__StartDecorConstructCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID  = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructionID = id;
    work->shipUpgradeID       = CViMap::UPGRADE_SHIP_INVALID;

    if (HubConfig__CheckDecorConstructionUnknown(id))
        work->vmiFile = *HubConfig__Func_2152A20(id);
    else
        work->vmiFile = -1;

    u16 x, y;
    ViMap__ClampPosToMapBounds(32, 40, &x, &y);
    ViMap__WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForShipConstructionCutscene();
    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void ViMap__StartShipUpgradeCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID  = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructionID = CViMap::CONSTRUCT_DECOR_INVALID;
    work->shipUpgradeID       = id;
    work->vmiFile             = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID)->mapArea)->field_3C;

    s32 i;
    AnimatorSprite *aniMaterialIcon = &work->aniMaterialIcon[0];
    for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        AnimatorSprite__SetAnimation(aniMaterialIcon, i);
        aniMaterialIcon->paletteMode    = PALETTE_MODE_SUB_OBJ;
        aniMaterialIcon->vramPalette    = NULL;
        aniMaterialIcon->cParam.palette = PALETTE_ROW_15;
        aniMaterialIcon->oamPriority    = SPRITE_PRIORITY_0;
        aniMaterialIcon->oamOrder       = SPRITE_ORDER_1;

        aniMaterialIcon++;
    }

    AnimatorSprite__SetAnimation(&work->aniRingIcon, 0);
    work->aniRingIcon.cParam.alpha = PALETTE_ROW_12;
    work->aniRingIcon.oamPriority  = SPRITE_PRIORITY_0;
    work->aniRingIcon.oamOrder     = SPRITE_ORDER_0;

    AnimatorSprite *aniSparkle = &work->aniSparkle[0];
    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniSparkle); i++)
    {
        aniSparkle->cParam.palette = PALETTE_ROW_13;
        aniSparkle->oamPriority    = SPRITE_PRIORITY_0;
        aniSparkle->oamOrder       = SPRITE_ORDER_1;

        aniSparkle++;
    }

    u16 x, y;
    ViMap__ClampPosToMapBounds(32, 40, &x, &y);
    ViMap__WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForShipConstructionCutscene();

    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);
    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

NONMATCH_FUNC void ViMap__Func_215C284(s32 a1)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r1, =mapTaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x20
	mov r1, #0x28
	add r2, sp, #6
	add r3, sp, #4
	strh r0, [sp, #0xa]
	strh r1, [sp, #8]
	bl ViMap__ClampPosToMapBounds
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r2, sp, #6
	add r3, sp, #4
	bl ViMap__ClampPosToMapBounds
	add r0, r4, #0x700
	ldrh r0, [r0, #0xe8]
	ldr r1, =0x0000FFFF
	cmp r0, r1
	beq _0215C32C
	bl HubConfig__GetDecorVmiFile
	ldrh r1, [r0, #0]
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, r4
	bl ViMapBack__Func_2161864
	ldrh r1, [sp, #0xa]
	ldrh r0, [sp, #8]
	add r2, sp, #2
	add r1, r1, #0x18
	add r0, r0, #0x10
	strh r1, [sp, #0xa]
	strh r0, [sp, #8]
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r3, sp, #0
	bl ViMap__ClampPosToMapBounds
	b _0215C378
_0215C32C:
	ldr r0, [r4, #0x7e0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A20
	ldrh r0, [r0, #0]
	add r1, sp, #0xa
	add r2, sp, #8
	bl ViMapBack__Func_2162798
	ldrh r1, [sp, #0xa]
	ldrh r0, [sp, #8]
	add r2, sp, #2
	add r1, r1, #0x18
	add r0, r0, #0x10
	strh r1, [sp, #0xa]
	strh r0, [sp, #8]
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r3, sp, #0
	bl ViMap__ClampPosToMapBounds
_0215C378:
	cmp r5, #0
	ldreqh r5, [sp, #6]
	ldreqh r6, [sp, #4]
	beq _0215C3D0
	cmp r5, #0x1000
	ldreqh r5, [sp, #2]
	ldreqh r6, [sp]
	beq _0215C3D0
	ldrh r3, [sp, #6]
	ldrh r2, [sp, #2]
	ldrh r1, [sp, #4]
	ldrh r0, [sp]
	sub r2, r2, r3
	mul r2, r5, r2
	sub r0, r0, r1
	mul r0, r5, r0
	add r2, r3, r2, asr #12
	add r1, r1, r0, asr #12
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r6, r1, lsr #0x10
_0215C3D0:
	mov r0, r5
	mov r1, r6
	bl ViMap__WarpToPosition
	ldrh r1, [sp, #0xa]
	add r0, r4, #0x700
	sub r1, r1, r5
	strh r1, [r0, #0xd0]
	ldrh r1, [sp, #8]
	sub r1, r1, r6
	strh r1, [r0, #0xd2]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C408(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =mapTaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x7dc]
	cmp r0, #5
	bge _0215C438
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	b _0215C448
_0215C438:
	ldr r0, [r4, #0x7e4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapUnknownConfig
_0215C448:
	add r1, r4, #0x700
	mov r2, #0
	strh r2, [r1, #0xea]
	strh r2, [r1, #0xec]
	ldrh r1, [r0, #0x14]
	mov r0, #0x10000
	bl FX_DivS32
	add r1, r4, #0x700
	strh r0, [r1, #0xee]
	add r1, r4, #0x7f0
	mov r0, #0x100
	mov r2, #0x20
	bl MIi_CpuClear32
	mov r0, #2
	str r0, [r4, #0x7d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViMap__Func_215C48C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =mapTaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0x7dc]
	add r0, r0, #0x700
	cmp r1, #5
	movlt r2, #0x100
	ldrh r1, [r0, #0xea]
	movge r2, #0xa0
	add r0, r2, #0x62
	cmp r1, r0
	movhs r0, #1
	movlo r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void ViMap__Func_215C4CC(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->cutsceneState = 3;
    work->cutsceneTimer = 0;
}

BOOL ViMap__Func_215C4F8(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    return work->cutsceneTimer >= 80;
}

void ViMap__Func_215C524(u16 a1)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ViMap__Func_215D374(work);

    ViMapBack__Func_21619B0(&work->mapBack, *HubConfig__GetDecorVmiFile(a1));
    ViMapBack__Func_2161ADC(&work->mapBack, *HubConfig__GetDecorVmiFile(a1));
    ViMapBack__Func_2161F3C(&work->mapBack, (u8 *)VRAM_DB_BG + 0xC040, 0);
    ViMapBack__Func_2161DC8(&work->mapBack);
}

void ViMap__Func_215C58C(u16 a1)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    const u16 *value = HubConfig__Func_2152A20(a1);
    if (HubConfig__CheckDecorConstructionUnknown(a1))
    {
        ViMap__Func_215D374(work);

        ViMapBack__Func_21619B0(&work->mapBack, *HubConfig__GetDecorVmiFile(*value));
        ViMapBack__Func_2161ADC(&work->mapBack, *HubConfig__GetDecorVmiFile(*value));
        ViMapBack__Func_2161F3C(&work->mapBack, (u8 *)VRAM_DB_BG + 0xC040, 0);
        ViMapBack__Func_2161DC8(&work->mapBack);

        if (a1 == 1)
            ViMapBack__Func_21620FC(&work->mapBack, 2);
    }
    else
    {
        ViMapBack__Func_21620FC(&work->mapBack, *value);
    }
}

void ViMap__Func_215C638(u16 a1)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::Func_215B168();

    for (s32 i = 0; i < 8; i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    ViMap__Func_215D7D8(work, a1);
    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void ViMap__Func_215C6AC(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::Func_215B168();

    for (s32 i = 0; i < 8; i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    if (HubConfig__CheckDecorConstructionUnknown(work->decorConstructionID))
    {
        u16 value = *HubConfig__Func_2152A20(work->decorConstructionID);
        ViMap__Func_215D7D8(work, value);
        if (value == 1)
            ViMapBack__Func_21620FC(&work->mapBack, 2);
    }
    else
    {
        HubControl::Func_215B250();
        ViMap__InitConstructionCompletePulse(work);
    }

    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void ViMap__Func_215C76C(u16 a1)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::Func_215B168();

    for (s32 i = 0; i < 8; i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    ViMap__Func_215D7D8(work, a1);
    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void ViMap__Func_215C7E0(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ViMap__ReleaseUnknown2056FDC(work);
    work->cutsceneState = 6;
    work->cutsceneTimer = 0;
    ReleaseHubBGCircleEffect(&work->bgCircleEffect);

    ViMap__Func_215DA68(work);
    HubControl::Func_215B3B4();
}

void ViMap__InitMapIcons(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.InitIcons();
}

void ViMap__EnableMapIcons(BOOL enabled)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_ISLAND_ICONS, enabled);
}

void ViMap__DrawMapCursor(s16 x, s16 y)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.DrawCursor(x, y);
}

void ViMapPaletteAnimation__Create(void)
{
    ViMapPaletteAnimation__Destroy();

    mapPaletteAnimationTaskSingleton = TaskCreate(ViMapPaletteAnimation__Main, ViMapPaletteAnimation__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1041,
                                                  TASK_GROUP(16), CViMapPaletteAnimation);

    CViMapPaletteAnimation *work = TaskGetWork(mapPaletteAnimationTaskSingleton, CViMapPaletteAnimation);

    work->aniPaletteFile = FSRequestFileSync("bpa/vi_map.bpa", FSREQ_AUTO_ALLOC_HEAD);
    for (s32 i = 0; i < 3; i++)
    {
        InitPaletteAnimator(&work->aniPalette[i], work->aniPaletteFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SUB_BG, NULL);
    }
}

void ViMapPaletteAnimation__Destroy(void)
{
    if (mapPaletteAnimationTaskSingleton != NULL)
    {
        DestroyTask(mapPaletteAnimationTaskSingleton);
        mapPaletteAnimationTaskSingleton = NULL;
    }
}

AnimatorSprite *ViMap__Func_215C98C(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);
    return &work->aniMaterialIcon[id];
}

void ViMap__InitMapBack(CViMap *work)
{
    ViMapBack__LoadAssets(&work->mapBack);
    ViMapBack__Func_2161F08(&work->mapBack, 0, 0);
    ViMapBack__Func_2162010(&work->mapBack, (u8 *)VRAM_DB_BG + 0xA000, 1);
    ViMapBack__Func_2161924(&work->mapBack);
    ViMap__Func_215D374(work);
    ViMapBack__Func_2161A40(&work->mapBack);
    ViMapBack__Func_2161F3C(&work->mapBack, (u8 *)VRAM_DB_BG + 0xC040, 0);
    ViMapBack__Func_2161DC8(&work->mapBack);
}

void ViMap__InitMapIcon(CViMap *work)
{
    work->mapIcon.Init(GRAPHICS_ENGINE_B);
    work->mapIcon.WarpToArea(MAPAREA_BASE);
    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_PLAYER_ICON, TRUE);
    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_ISLAND_ICONS, TRUE);
}

void ViMap__Func_215CA60(CViMap *work)
{
    ViMap__Func_215D214(work);
    ViMapBack__Func_2162648(&work->mapBack, work->mapPos.x, work->mapPos.y);
}

void ViMap__InitSprites(CViMap *work)
{
    void *sprMaterialIcon = HubControl::GetSpriteFile(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_MAT32_256_BAC);
    for (s32 i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        size_t sprMaterialIconSize = Sprite__GetSpriteSize3FromAnim(sprMaterialIcon, i);

        AnimatorFlags flags;
        if (i == 0)
            flags = ANIMATOR_FLAG_NONE;
        else
            flags = ANIMATOR_FLAG_DISABLE_PALETTES;

        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprMaterialIconSize);
        AnimatorSprite__Init(&work->aniMaterialIcon[i], sprMaterialIcon, 0, flags, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SUB_OBJ, VRAMKEY_TO_ADDR(0x1E00),
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    }

    void *sprRingIcon       = HubControl::GetSpriteFile(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_RING32_BAC);
    VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprRingIcon, 0));
    AnimatorSprite__Init(&work->aniRingIcon, sprRingIcon, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_0);

    // Sparkle sprites
    {
        AnimatorSprite *aniSparkle;
        void *sprSparkle;
        s32 i;
        size_t sprSparkleSize;

        sprSparkle     = HubControl::GetSpriteFile(ARCHIVE_VI_ACT_LZ7_FILE_VI_EFF_JEWEL_BAC);
        sprSparkleSize = Sprite__GetSpriteSize3(sprSparkle);

        aniSparkle = &work->aniSparkle[0];
        for (i = 0; i < (s32)ARRAY_COUNT(work->aniSparkle); i++)
        {
            AnimatorFlags flags;
            if (i == 0)
                flags = ANIMATOR_FLAG_NONE;
            else
                flags = ANIMATOR_FLAG_DISABLE_PALETTES;
            VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, sprSparkleSize);
            AnimatorSprite__Init(aniSparkle, sprSparkle, 0, flags | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE,
                                 VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);

            aniSparkle++;
        }
    }
}

void ViMap__Release(CViMap *work)
{
    s32 i;

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    ViMap__ReleaseUnknown2056FDC(work);

    for (i = 0; i < (s32)ARRAY_COUNT(work->aniSparkle); i++)
    {
        AnimatorSprite__Release(&work->aniSparkle[i]);
    }
    AnimatorSprite__Release(&work->aniRingIcon);

    for (i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        AnimatorSprite__Release(&work->aniMaterialIcon[i]);
    }

    work->mapIcon.Release();
    ViMapBack__Release(&work->mapBack);
}

void ViMap__Main_Moving(void)
{
    CViMap *work = TaskGetWorkCurrent(CViMap);

    s32 newMapArea = MAPAREA_INVALID;
    if (work->mapMoveDuration == 0)
    {
        newMapArea = work->mapIcon.GetAreaFromTouchInput();
        if (newMapArea >= MAPAREA_COUNT)
            newMapArea = work->mapIcon.GetAreaFromPadInput();
    }

    if (newMapArea < MAPAREA_COUNT && newMapArea != work->mapIcon.GetCurrentArea())
    {
        u16 y, x;

        work->mapIcon.TravelToArea(newMapArea);
        work->mapIcon.GetIconPosition(newMapArea, &x, &y);
        x += 8;
        y += 8;
        ViMap__ClampPosToMapBounds(x, y, &x, &y);
        ViMap__TravelToPosition(x, y, 32);
        PlayHubSfx(HUB_SFX_CURSOL);
    }

    ViMap__Func_215D2B4(work);
    ViMapBack__Func_2162110(&work->mapBack);
    ViMapBack__Func_2162158(&work->mapBack, 0);
    work->mapIcon.SetWorldPosition(work->mapPos.x, work->mapPos.y);
    work->mapIcon.ProcessPlayerIcon();
    work->mapIcon.Draw();
}

void ViMap__Main_Idle(void)
{
    CViMap *work = TaskGetWorkCurrent(CViMap);

    ViMap__Func_215D2B4(work);

    ViMapBack__Func_2162110(&work->mapBack);
    ViMapBack__Func_2162158(&work->mapBack, 0);

    work->mapIcon.SetWorldPosition(work->mapPos.x, work->mapPos.y);
    work->mapIcon.ProcessPlayerIcon();
    work->mapIcon.Draw();
}

void ViMap__Main_ConstructionCutscene(void)
{
    CViMap *work;
    GXRgb color;
    const CViMapAreaConfig *config;
    BOOL flag = FALSE;
    u16 v4;
    s16 v3;
    s32 timer;
    s32 offset;
    s32 i;
    s32 radius;
    s32 brightness;

    work = TaskGetWorkCurrent(CViMap);

    if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT)
    {
        config = HubConfig__GetDockMapConfig(work->shipConstructionID);
    }
    else if (work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT)
    {
        config = HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID);
    }
    else
    {
        config = NULL;
    }

    switch (work->cutsceneState)
    {
        case 1:
            if (work->cutsceneTimer < 128)
            {
                v3 = FLOAT_TO_FX32(2.0) - (FX32_FROM_WHOLE(work->cutsceneTimer) >> 7);
                v4 = work->cutsceneTimer >> 4;
            }
            else
            {
                v3 = FLOAT_TO_FX32(1.0);
                v4 = 8;
            }
            ViMap__Func_215D44C(work, v3, v4);
            break;

        case 2:
            if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT)
                offset = FX_DivS32(256, config->materialCount);
            else
                offset = FX_DivS32(160, config->materialCount);

            timer = work->cutsceneTimer;
            for (i = 0; i < config->materialCount; i++)
            {
                if (timer < 0)
                {
                    work->materialRadius[i] = 256;
                }
                else if (timer >= 98)
                {
                    work->materialRadius[i] = 48;
                }
                else
                {
                    work->materialRadius[i] = Unknown2051334__Func_2051534(256, 48, 98, timer, FLOAT_TO_FX32(2.0));
                }
                timer -= offset;
            }

            work->materialCircleAngle -= 512;
            ViMap__Func_215D44C(work, FLOAT_TO_FX32(1.0), 8);
            ViMap__Func_215D4B4(work);
            break;

        case 3:
            work->materialCircleAngle -= 512;
            work->materialCircleAngle -= FX_DivS32(0xC00 * work->cutsceneTimer, 128);

            radius = 48 - FX_DivS32(48 * work->cutsceneTimer, 128);
            if (radius < 16)
                radius = 16;

            for (i = 0; i < config->materialCount; i++)
            {
                work->materialRadius[i] = radius;
            }

            ViMap__Func_215D44C(work, FLOAT_TO_FX32(1.0), 8);
            ViMap__Func_215D4B4(work);
            break;

        case 4:
            if ((work->cutsceneTimer & 7) == 0)
                ViMap__Func_215D604(work);

            ViMap__Func_215D734(work);

            brightness = work->cutsceneTimer & 0x3F;
            if (brightness >= 0x20)
                brightness = 0x3F - brightness;

            color = GX_RGB(brightness >> 1, brightness >> 1, brightness >> 1);

            if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT || work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT
                || HubConfig__CheckDecorConstructionUnknown(work->decorConstructionID))
            {
                ViMap__Func_215D930(work, color);
            }
            else
            {
                ViMapBack__Func_2162508(&work->mapBack, work->decorConstructionID, &work->constructionPos.x, &work->constructionPos.y, TRUE, TRUE);
                flag = TRUE;
            }
            break;
    }

    work->cutsceneTimer++;

    ViMap__Func_215D2B4(work);
    ViMapBack__Func_2162110(&work->mapBack);

    if (flag)
        ViMap__DrawConstructionCompletePulse(work, color);

    if (work->decorConstructionID == CViMap::CONSTRUCT_DECOR_19)
        ViMapBack__Func_2162158(&work->mapBack, 1);
    else
        ViMapBack__Func_2162158(&work->mapBack, 0);
}

void ViMap__Destructor(Task *task)
{
    CViMap *work = TaskGetWork(task, CViMap);

    ViMap__Release(work);

    // TODO: use 'HubTaskDestroy' when ViMap__Func_215D150 matches
    // HubTaskDestroy<CViMap>(task);
    ViMap__Func_215D150(task);

    mapTaskSingleton = NULL;
}

// TODO: should match when destructors are decompiled for 'CViMapIcon' & 'CViMapBack'
NONMATCH_FUNC void ViMap__Func_215D150(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0215D17C
	add r0, r4, #0x5d0
	bl _ZN10CViMapIconD1Ev
	mov r0, r4
	bl _ZN10CViMapBackD0Ev
	mov r0, r4
	bl _ZdlPv
_0215D17C:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void ViMapPaletteAnimation__Main(void)
{
    CViMapPaletteAnimation *work = TaskGetWorkCurrent(CViMapPaletteAnimation);

    for (s32 i = 0; i < 3; i++)
    {
        AnimatePalette(&work->aniPalette[i]);
        DrawAnimatedPalette(&work->aniPalette[i]);
    }
}

void ViMapPaletteAnimation__Destructor(Task *task)
{
    s32 i;

    CViMapPaletteAnimation *work = TaskGetWork(task, CViMapPaletteAnimation);

    for (i = 0; i < 3; i++)
    {
        ReleasePaletteAnimator(&work->aniPalette[i]);
    }

    if (work->aniPaletteFile != NULL)
    {
        HeapFree(HEAP_USER, work->aniPaletteFile);
        work->aniPaletteFile = NULL;
    }

    mapPaletteAnimationTaskSingleton = NULL;
}

void ViMap__Func_215D214(CViMap *work)
{
    u16 y, x;
    work->mapIcon.GetIconPosition(work->mapIcon.GetCurrentArea(), &x, &y);

    x += 8;
    y += 8;
    ViMap__ClampPosToMapBounds(x, y, &x, &y);
    ViMap__WarpToPosition(x, y);
}

void ViMap__ClampPosToMapBounds(u16 x, u16 y, u16 *outX, u16 *outY)
{
    s32 newX = x - HW_LCD_CENTER_X;
    s32 newY = y - HW_LCD_CENTER_Y;

    if (newX < 0)
        newX = 0;

    if (newY < 16)
        newY = 16;

    if (newX > 64)
        newX = 64;

    if (newY > 64)
        newY = 64;

    if (outX != NULL)
        *outX = newX;

    if (outY != NULL)
        *outY = newY;
}

void ViMap__Func_215D2B4(CViMap *work)
{
    if (work->mapMoveDuration != 0)
    {
        if (work->mapMoveTimer >= work->mapMoveDuration)
        {
            work->mapPos.x        = work->mapTargetPos.x;
            work->mapPos.y        = work->mapTargetPos.y;
            work->mapPrevPos.x    = work->mapTargetPos.x;
            work->mapPrevPos.y    = work->mapTargetPos.y;
            work->mapMoveDuration = 0;
            work->mapMoveTimer    = 0;
        }
        else
        {
            s32 value  = work->mapPrevPos.x;
            s32 value2 = (work->mapTargetPos.x - value);
            value2 *= work->mapMoveTimer;
            work->mapPos.x = value + FX_DivS32(value2, work->mapMoveDuration);

            value  = work->mapPrevPos.y;
            value2 = (work->mapTargetPos.y - value);
            value2 *= work->mapMoveTimer;
            work->mapPos.y = value + FX_DivS32(value2, work->mapMoveDuration);

            work->mapMoveTimer++;
        }
    }

    ViMapBack__Func_2162648(&work->mapBack, work->mapPos.x, work->mapPos.y);
}

void ViMap__Func_215D374(CViMap *work)
{
    ViMapBack__Func_21619B0(&work->mapBack, 0);
    ViMapBack__Func_21619B0(&work->mapBack, 1);

    for (s32 i = 0; i < CViMap::CONSTRUCT_SHIP_COUNT; i++)
    {
        if (HubControl::CheckShipConstructed(i))
        {
            const CViMapAreaConfig *config = HubConfig__GetDockMapConfig(i);

            ViMapBack__Func_21619B0(&work->mapBack, *HubConfig__GetDecorVmiFile(HubConfig__GetDockMapIconConfig(config->mapArea)->field_3C));
        }
    }

    for (s32 i = 0; i < CViMap::CONSTRUCT_DECOR_COUNT; i++)
    {
        if (HubControl::CheckDecorConstructed(i))
        {
            const u16 *value = HubConfig__Func_2152A20(i);
            if (HubConfig__CheckDecorConstructionUnknown(i))
            {
                ViMapBack__Func_21619B0(&work->mapBack, *HubConfig__GetDecorVmiFile(*value));
            }
            else
            {
                ViMapBack__Func_21620FC(&work->mapBack, *value);
            }
        }
    }
}

void ViMap__Func_215D44C(CViMap *work, fx32 scale, s32 progress)
{
    SetHubBGCircleEffectPosition(&work->bgCircleEffect, work->constructionPos.x, work->constructionPos.y);
    SetHubBGCircleEffectScale(&work->bgCircleEffect, scale);
    SetHubBGCircleEffectBrightness(&work->bgCircleEffect, FX_DivS32(FX32_FROM_WHOLE(progress), 16));
    ProcessHubBGCircleEffect(&work->bgCircleEffect);
}

NONMATCH_FUNC void ViMap__Func_215D4B4(CViMap *work)
{
    // https://decomp.me/scratch/ZoGxf -> 95.65%
#ifdef NON_MATCHING
    const CViMapAreaConfig *config;
    if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT)
        config = HubConfig__GetDockMapConfig(work->shipConstructionID);
    else
        config = HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID);

    for (s32 i = 0; i < SAVE_MATERIAL_COUNT; i++)
    {
        AnimatorSprite__ProcessAnimationFast(&work->aniMaterialIcon[i]);
    }

    AnimatorSprite__ProcessAnimationFast(&work->aniRingIcon);

    u16 angle = work->materialCircleAngle;
    for (s32 i = 0; i < config->materialCount; i++)
    {
        s32 radius = work->materialRadius[i];

        s32 y1 = radius * SinFX(angle);
        s32 x1 = radius * CosFX(angle);

        s32 y = work->constructionPos.y;
        s32 x = work->constructionPos.x;

        x += FX32_TO_WHOLE(x1);

        AnimatorSprite *aniIcon;
        if (config->materials[i] < SAVE_MATERIAL_COUNT)
            aniIcon = &work->aniMaterialIcon[config->materials[i]];
        else
            aniIcon = &work->aniRingIcon;

        y += FX32_TO_WHOLE(y1);
        if (x > -32 && x < 288 && y > -32 && y < 224)
        {
            aniIcon->pos.x = x - 16;
            aniIcon->pos.y = y - 16;
            AnimatorSprite__DrawFrame(aniIcon);
        }

        angle += work->materialCircleAngleOffset;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldr r0, [r10, #0x7dc]
	cmp r0, #5
	bge _0215D4D8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	b _0215D4E8
_0215D4D8:
	ldr r0, [r10, #0x7e4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapUnknownConfig
_0215D4E8:
	mov r5, #0
	mov r9, r0
	add r6, r10, #0x810
	mov r4, r5
_0215D4F8:
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	cmp r5, #9
	add r6, r6, #0x64
	blt _0215D4F8
	add r0, r10, #0x394
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x800
	bl AnimatorSprite__ProcessAnimation
	add r5, r10, #0x700
	ldrh r0, [r9, #0x14]
	ldrh r7, [r5, #0xec]
	mov r8, #0
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r11, r10, #0x394
	add r6, r10, #0x810
	mvn r4, #0x1f
_0215D550:
	mov r0, r7, asr #4
	mov r1, r0, lsl #1
	ldr r0, =FX_SinCosTable_
	mov r2, r1, lsl #1
	add r0, r0, r1, lsl #1
	add r3, r10, r8, lsl #2
	ldrsh r1, [r0, #2]
	ldr r0, [r3, #0x7f0]
	ldr r3, =FX_SinCosTable_
	ldrsh ip, [r3, r2]
	mul r2, r0, r1
	mul r1, r0, ip
	add r3, r9, r8, lsl #1
	ldrh r0, [r5, #0xd0]
	ldrh r3, [r3, #0x18]
	ldrh ip, [r5, #0xd2]
	add r2, r0, r2, asr #12
	cmp r3, #9
	movlo r0, #0x64
	mlalo r0, r3, r0, r6
	addhs r0, r11, #0x800
	add r1, ip, r1, asr #12
	cmp r2, r4
	ble _0215D5DC
	cmp r2, #0x120
	bge _0215D5DC
	cmp r1, r4
	ble _0215D5DC
	cmp r1, #0xe0
	bge _0215D5DC
	sub r2, r2, #0x10
	strh r2, [r0, #8]
	sub r1, r1, #0x10
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_0215D5DC:
	ldrh r0, [r5, #0xee]
	ldrh r1, [r9, #0x14]
	add r8, r8, #1
	add r0, r7, r0
	mov r0, r0, lsl #0x10
	cmp r8, r1
	mov r7, r0, lsr #0x10
	blt _0215D550
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void ViMap__Func_215D604(CViMap *work)
{
    AnimatorSprite *aniSparkle;
    s32 i;

    for (i = 0; i < (s32)ARRAY_COUNT(work->sparklePos); i++)
    {
        if (work->sparklePos[i].x == FLOAT_TO_FX32(0.25))
        {
            aniSparkle = &work->aniSparkle[i];

            AnimatorSprite__SetAnimation(aniSparkle, FX_ModS32(mtMathRand(), 10));

            work->sparklePos[i].x = (mtMathRand() & 0x3F) - 32;
            work->sparklePos[i].y = (mtMathRand() & 0x1F) - 47;

            work->sparklePos[i].x += work->constructionPos.x;
            work->sparklePos[i].y += work->constructionPos.y;

            aniSparkle->pos.x = work->sparklePos[i].x;
            aniSparkle->pos.y = work->sparklePos[i].y;
            break;
        }
    }
}

void ViMap__Func_215D734(CViMap *work)
{
    s32 i;
    AnimatorSprite *aniSparkle;

    aniSparkle = &work->aniSparkle[0];
    for (i = 0; i < (s32)ARRAY_COUNT(work->sparklePos); i++)
    {
        if (work->sparklePos[i].x != FLOAT_TO_FX32(0.25))
        {
            if (aniSparkle->pos.y >= work->sparklePos[i].y + 64)
            {
                work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
                work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
            }
            else
            {
                aniSparkle->pos.y++;
                AnimatorSprite__ProcessAnimationFast(aniSparkle);
                AnimatorSprite__DrawFrame(aniSparkle);
            }
        }

        aniSparkle++;
    }
}

void ViMap__InitUnknown2056FDC(CViMap *work)
{
    work->field_F68 = 0;
    work->field_F6A = 0;
    Unknown2056FDC__Init(&work->unknown);
}

NONMATCH_FUNC void ViMap__Func_215D7D8(CViMap *work, u16 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	mov r4, r1
	bl ViMap__ReleaseUnknown2056FDC
	mov r0, r5
	bl ViMap__Func_215D374
	mov r0, r4
	bl HubConfig__GetDecorVmiFile
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_21619B0
	mov r0, r4
	bl HubConfig__GetDecorVmiFile
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_2161BE4
	mov r0, r4
	bl HubConfig__GetDecorVmiFile
	add r2, sp, #0x12
	str r2, [sp]
	add r1, sp, #0x10
	str r1, [sp, #4]
	ldrh r1, [r0, #0]
	mov r0, r5
	add r2, sp, #0x16
	add r3, sp, #0x14
	bl ViMapBack__Func_21617E4
	ldrh r1, [sp, #0x16]
	add r0, r5, #0xf00
	mov r1, r1, lsl #3
	strh r1, [r0, #0x68]
	ldrh r1, [sp, #0x14]
	mov r1, r1, lsl #3
	strh r1, [r0, #0x6a]
	ldrh r0, [sp, #0x12]
	ldrh r1, [sp, #0x10]
	mov r0, r0, lsl #6
	mul r0, r1, r0
	bl _AllocTailHEAP_USER
	mov r4, r0
	ldrh r2, [sp, #0x12]
	mov r0, r5
	mov r1, r4
	str r2, [sp]
	ldrh ip, [sp, #0x10]
	mov r2, #0
	mov r3, r2
	str ip, [sp, #4]
	bl ViMapBack__Func_2161E30
	mov r0, r5
	bl ViMapBack__Func_2161DC8
	mov r0, r5
	bl ViMapBack__Func_2161E20
	ldrh r1, [sp, #0x12]
	add r3, r5, #0x36c
	mov ip, #0x100
	str r1, [sp]
	ldrh lr, [sp, #0x10]
	mov r1, #1
	mov r2, r1
	str lr, [sp, #4]
	str r0, [sp, #8]
	add r0, r3, #0xc00
	mov r3, r4
	str ip, [sp, #0xc]
	bl Unknown2056FDC__Func_2057004
	add r1, r5, #0xf00
	ldrh r3, [r1, #0x6c]
	add r0, r5, #0x36c
	mov r2, #0xf
	orr r3, r3, #0xc
	strh r3, [r1, #0x6c]
	strh r2, [r1, #0xa0]
	mov r1, #2
	strb r1, [r5, #0xfa6]
	mov r1, #0x1f
	strb r1, [r5, #0xfa7]
	mov r1, #0
	add r0, r0, #0xc00
	str r1, [r5, #0xfa8]
	bl Unknown2056FDC__Func_2057484
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void ViMap__Func_215D930(CViMap *work, GXRgb color)
{
    s16 x;
    s16 y;
    ViMapBack__Func_2162774(&work->mapBack, &x, &y);

    work->unknown.work.mode = 1;
    MI_CpuFill16(work->unknown.work.palettePtr, color, 2 * work->unknown.work.colorCount);

    Unknown2056FDC__Func_2057460(&work->unknown, FALSE, TRUE);
    work->unknown.work.x1 = work->field_F68 - x + 24;
    work->unknown.work.y1 = work->field_F6A - y + 16;

    Unknown2056FDC__Func_2057484(&work->unknown);
    Unknown2056FDC__Func_2057614(&work->unknown);
}

void ViMap__ReleaseUnknown2056FDC(CViMap *work)
{
    work->field_F68 = 0;
    work->field_F6A = 0;
    Unknown2056FDC__Release(&work->unknown);
}

void ViMap__InitUnknown(CViMap *work)
{
    // Nothing to do.
}

void ViMap__InitConstructionCompletePulse(CViMap *work)
{
    InitHubConstructionCompletePulse(&work->constructionCompletePulse, 0, GRAPHICS_ENGINE_B, BACKGROUND_2, PALETTE_ROW_0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void ViMap__DrawConstructionCompletePulse(CViMap *work, GXRgb color)
{
    DrawHubConstructionCompletePulse(&work->constructionCompletePulse, color);
    ViMapBack__Func_216233C(&work->mapBack, work->decorConstructionID, 1);
}

void ViMap__Func_215DA68(CViMap *work)
{
    // Nothing to do.
}