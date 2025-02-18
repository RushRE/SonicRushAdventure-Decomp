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

void CViMap::Create(void)
{
    // TODO: use 'HubTaskCreate' when 'CViMap::CreateInternal' matches
    // mapTaskSingleton = HubTaskCreate(CViMap::Main_Idle, CViMap::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1040, TASK_GROUP(16), CViMap);
    mapTaskSingleton = CViMap::CreateInternal(CViMap::Main_Idle, CViMap::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1040, TASK_GROUP(16));

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

    CViMap::InitMapBack(work);
    CViMap::InitMapIcon(work);
    CViMap::InitIslandBackgrounds(work);
    CViMap::InitSprites(work);
    CViMap::InitUnknown2056FDC(work);
    CViMap::InitUnknown(work);
}

// TODO: should match when constructors are decompiled for 'CViMapIcon' & 'CViMapBack'
NONMATCH_FUNC Task *CViMap::CreateInternal(TaskMain taskMain, TaskDestructor taskDestructor, TaskFlags flags, u8 pauseLevel, u32 priority, TaskGroup group)
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

void CViMap::Destroy(void)
{
    if (mapTaskSingleton != NULL)
    {
        CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);
        UNUSED(work);

        DestroyTask(mapTaskSingleton);

        mapTaskSingleton = NULL;
    }
}

void CViMap::SetType(s32 type)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    switch (type)
    {
        case CViMap::TYPE_MAP_ACTIVE:
            SetTaskMainEvent(mapTaskSingleton, CViMap::Main_Moving);
            break;

        case CViMap::TYPE_DOCK_ACTIVE:
            SetTaskMainEvent(mapTaskSingleton, CViMap::Main_Idle);
            break;

        case CViMap::TYPE_CONSTRUCTION_CUTSCENE:
            work->cutsceneState = 6;
            SetTaskMainEvent(mapTaskSingleton, CViMap::Main_ConstructionCutscene);
            break;
    }
}

void CViMap::WarpToPosition(u16 x, u16 y)
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

void CViMap::TravelToPosition(u16 x, u16 y, u16 duration)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapTargetPos.x  = x;
    work->mapTargetPos.y  = y;
    work->mapPrevPos.x    = work->mapPos.x;
    work->mapPrevPos.y    = work->mapPos.y;
    work->mapMoveDuration = duration;
    work->mapMoveTimer    = 0;
}

void CViMap::GetMapPosition(u16 *x, u16 *y)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    if (x != NULL)
        *x = work->mapPos.x;

    if (y != NULL)
        *y = work->mapPos.y;
}

MapArea CViMap::GetMapAreaFromMapIconTouchInput(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    return work->mapIcon.GetAreaFromTouchInput();
}

MapArea CViMap::GetMapAreaFromMapIconMarker(BOOL mustBeIdle)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    if (mustBeIdle && work->mapIcon.IsMoving())
        return MAPAREA_INVALID;

    return work->mapIcon.GetCurrentArea();
}

void CViMap::GoToMapArea(u32 mapArea, BOOL shouldTravel)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    u16 y, x;
    if (shouldTravel)
    {
        work->mapIcon.TravelToArea(mapArea);
        work->mapIcon.GetIconPosition(mapArea, &x, &y);

        x += 8;
        y += 8;
        CViMap::ClampPosToMapBounds(x, y, &x, &y);
        CViMap::TravelToPosition(x, y, 32);
    }
    else
    {
        work->mapIcon.WarpToArea(mapArea);
        work->mapIcon.GetIconPosition(mapArea, &x, &y);

        x += 8;
        y += 8;
        CViMap::ClampPosToMapBounds(x, y, &x, &y);
        CViMap::WarpToPosition(x, y);
    }
}

MapArea CViMap::GetChosenMapArea(void)
{
    MapArea mapArea = CViMap::GetMapAreaFromMapIconMarker(TRUE);

    if (mapArea >= MAPAREA_COUNT)
        return MAPAREA_INVALID;

    if (mapArea == CViMap::GetMapAreaFromMapIconTouchInput())
        return mapArea;

    if ((padInput.btnPress & PAD_BUTTON_A) == 0)
        mapArea = MAPAREA_INVALID;

    return mapArea;
}

void CViMap::StartShipConstructCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID      = id;
    work->decorConstructionID     = CVIMAP_DECOR_INVALID;
    work->shipUpgradeID           = CViMap::UPGRADE_SHIP_INVALID;
    work->shipConstructionImageID = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapConfig(work->shipConstructionID)->mapArea)->dockImageID;

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
    CViMap::ClampPosToMapBounds(32, 40, &x, &y);
    CViMap::WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForConstructionCutscene();

    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);
    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void CViMap::StartDecorConstructCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID  = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructionID = id;
    work->shipUpgradeID       = CViMap::UPGRADE_SHIP_INVALID;

    if (HubConfig__CheckDecorConstructionIsBackground(id))
        work->shipConstructionImageID = *HubConfig__GetMapBackDecorID(id);
    else
        work->shipConstructionImageID = -1;

    u16 x, y;
    CViMap::ClampPosToMapBounds(32, 40, &x, &y);
    CViMap::WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForConstructionCutscene();
    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void CViMap::StartShipUpgradeCutscene(s32 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->shipConstructionID      = CViMap::CONSTRUCT_SHIP_INVALID;
    work->decorConstructionID     = CVIMAP_DECOR_INVALID;
    work->shipUpgradeID           = id;
    work->shipConstructionImageID = HubConfig__GetDockMapIconConfig(HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID)->mapArea)->dockImageID;

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
    CViMap::ClampPosToMapBounds(32, 40, &x, &y);
    CViMap::WarpToPosition(x, y);
    work->constructionPos.x = 32 - x;
    work->constructionPos.y = 40 - y;

    work->cutsceneState = 1;
    work->cutsceneTimer = 0;
    HubControl::InitEngineBForConstructionCutscene();

    LoadHubBGCircleEffect(&work->bgCircleEffect, HubControl::GetBackgroundFile(ARCHIVE_VI_BG_LZ7_FILE_VI_EF_CIRCLE_BBG), BACKGROUND_FLAG_NONE, GRAPHICS_ENGINE_B, BACKGROUND_2,
                          PALETTE_ROW_0);
    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void CViMap::TravelToConstructionPos(fx32 progress)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    u16 x = 32;
    u16 y = 40;

    u16 startX;
    u16 startY;
    CViMap::ClampPosToMapBounds(32, 40, &startX, &startY);
    CViMap::ClampPosToMapBounds(x, y, &startX, &startY);

    u16 endX;
    u16 endY;
    if (work->shipConstructionImageID != 0xFFFF)
    {
        work->mapBack.GetImageCenter(*HubConfig__GetMapBackDecorBackgroundConfig(work->shipConstructionImageID), &x, &y);

        x += 24;
        y += 16;
        CViMap::ClampPosToMapBounds(x, y, &endX, &endY);
    }
    else
    {
        CViMapBack::GetDecorationImagePosition(*HubConfig__GetMapBackDecorID(work->decorConstructionID), &x, &y);

        x += 24;
        y += 16;
        CViMap::ClampPosToMapBounds(x, y, &endX, &endY);
    }

    u16 currentX;
    u16 currentY;
    if (progress == FLOAT_TO_FX32(0.0))
    {
        currentX = startX;
        currentY = startY;
    }
    else if (progress == FLOAT_TO_FX32(1.0))
    {
        currentX = endX;
        currentY = endY;
    }
    else
    {
        currentX = startX + FX32_TO_WHOLE(progress * (endX - startX));
        currentY = startY + FX32_TO_WHOLE(progress * (endY - startY));
    }

    CViMap::WarpToPosition(currentX, currentY);

    work->constructionPos.x = x - currentX;
    work->constructionPos.y = y - currentY;
}

void CViMap::InitMaterialRingAppearConstructCutsceneState(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    const CViMapAreaConfig *config;
    if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT)
        config = HubConfig__GetDockMapConfig(work->shipConstructionID);
    else
        config = HubConfig__GetDockMapUnknownConfig(work->shipUpgradeID);

    work->cutsceneTimer             = 0;
    work->materialCircleAngle       = 0;
    work->materialCircleAngleOffset = FX_DivS32(FLOAT_TO_FX32(16.0), config->materialCount);
    MI_CpuFill32(work->materialRadius, 0x100, sizeof(work->materialRadius));
    work->cutsceneState = 2;
}

BOOL CViMap::CheckMaterialRingAppearStateDone(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    u32 duration;
    if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT)
        duration = 256;
    else
        duration = 160;

    return work->cutsceneTimer >= duration + 98;
}

void CViMap::InitMaterialRingShrinkConstructCutsceneState(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->cutsceneState = 3;
    work->cutsceneTimer = 0;
}

BOOL CViMap::CheckMaterialRingShrinkStateDone(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    return work->cutsceneTimer >= 80;
}

void CViMap::AddDockToMap(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    CViMap::InitDecorations(work);

    work->mapBack.AddActiveImage(*HubConfig__GetMapBackDecorBackgroundConfig(id));
    work->mapBack.InitImageBlitter(*HubConfig__GetMapBackDecorBackgroundConfig(id));
    work->mapBack.BlitCanvasPixels((u8 *)VRAM_DB_BG + 0xC040, 0);
    work->mapBack.ReleaseImageBlitter();
}

void CViMap::AddDecorationToMap(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    const u16 *value = HubConfig__GetMapBackDecorID(id);
    if (HubConfig__CheckDecorConstructionIsBackground(id))
    {
        CViMap::InitDecorations(work);

        work->mapBack.AddActiveImage(*HubConfig__GetMapBackDecorBackgroundConfig(*value));
        work->mapBack.InitImageBlitter(*HubConfig__GetMapBackDecorBackgroundConfig(*value));
        work->mapBack.BlitCanvasPixels((u8 *)VRAM_DB_BG + 0xC040, 0);
        work->mapBack.ReleaseImageBlitter();

        if (id == 1)
            work->mapBack.SetDecorationActive(2);
    }
    else
    {
        work->mapBack.SetDecorationActive(*value);
    }
}

void CViMap::InitShipBuiltConstructCutsceneState(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::InitEngineBForConstructionFinishedCutscene();

    for (s32 i = 0; i < 8; i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    CViMap::LoadUnknown2056FDC(work, id);
    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void CViMap::InitDecorBuiltConstructCutsceneState(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::InitEngineBForConstructionFinishedCutscene();

    for (s32 i = 0; i < 8; i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    if (HubConfig__CheckDecorConstructionIsBackground(work->decorConstructionID))
    {
        u16 value = *HubConfig__GetMapBackDecorID(work->decorConstructionID);
        CViMap::LoadUnknown2056FDC(work, value);
        if (value == 1)
            work->mapBack.SetDecorationActive(2);
    }
    else
    {
        HubControl::InitEngineBForConstructionFinishedPulse();
        CViMap::InitConstructionCompletePulse(work);
    }

    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void CViMap::InitShipUpgradedConstructCutsceneState(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    HubControl::InitEngineBForConstructionFinishedCutscene();

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->sparklePos); i++)
    {
        work->sparklePos[i].x = FLOAT_TO_FX32(0.25);
        work->sparklePos[i].y = FLOAT_TO_FX32(0.25);
    }

    CViMap::LoadUnknown2056FDC(work, id);
    work->cutsceneState = 4;
    work->cutsceneTimer = 0;
}

void CViMap::InitAllFinishedConstructCutsceneState(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    CViMap::ReleaseUnknown2056FDC(work);
    work->cutsceneState = 6;
    work->cutsceneTimer = 0;
    ReleaseHubBGCircleEffect(&work->bgCircleEffect);

    CViMap::ReleaseConstructionCompletePulse(work);
    HubControl::InitEngineBForAllConstructionFinishedCutscene();
}

void CViMap::InitMapIcons(void)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.InitIcons();
}

void CViMap::EnableMapIcons(BOOL enabled)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_ISLAND_ICONS, enabled);
}

void CViMap::DrawMapCursor(s16 x, s16 y)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);

    work->mapIcon.DrawCursor(x, y);
}

void CViMapPaletteAnimation::Create()
{
    CViMapPaletteAnimation::Destroy();

    mapPaletteAnimationTaskSingleton = TaskCreate(CViMapPaletteAnimation::Main, CViMapPaletteAnimation::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1041,
                                                  TASK_GROUP(16), CViMapPaletteAnimation);

    CViMapPaletteAnimation *work = TaskGetWork(mapPaletteAnimationTaskSingleton, CViMapPaletteAnimation);

    work->aniPaletteFile = FSRequestFileSync("bpa/vi_map.bpa", FSREQ_AUTO_ALLOC_HEAD);
    for (s32 i = 0; i < 3; i++)
    {
        InitPaletteAnimator(&work->aniPalette[i], work->aniPaletteFile, i, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SUB_BG, NULL);
    }
}

void CViMapPaletteAnimation::Destroy()
{
    if (mapPaletteAnimationTaskSingleton != NULL)
    {
        DestroyTask(mapPaletteAnimationTaskSingleton);
        mapPaletteAnimationTaskSingleton = NULL;
    }
}

AnimatorSprite *CViMap::GetMaterialIconAnimator(u16 id)
{
    CViMap *work = TaskGetWork(mapTaskSingleton, CViMap);
    return &work->aniMaterialIcon[id];
}

void CViMap::InitMapBack(CViMap *work)
{
    work->mapBack.LoadAssets();
    work->mapBack.UpdateCanvasVRAMPalette(PALETTE_ROW_0, 0);
    work->mapBack.UpdateCanvasVRAMMappings((u8 *)VRAM_DB_BG + 0xA000, 1);
    work->mapBack.LoadAllImages();
    CViMap::InitDecorations(work);
    work->mapBack.LoadSortedImagesOntoCanvas();
    work->mapBack.BlitCanvasPixels((u8 *)VRAM_DB_BG + 0xC040, 0);
    work->mapBack.ReleaseImageBlitter();
}

void CViMap::InitMapIcon(CViMap *work)
{
    work->mapIcon.Init(GRAPHICS_ENGINE_B);
    work->mapIcon.WarpToArea(MAPAREA_BASE);
    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_PLAYER_ICON, TRUE);
    work->mapIcon.Configure(CViMapIcon::FLAG_SHOW_ISLAND_ICONS, TRUE);
}

void CViMap::InitIslandBackgrounds(CViMap *work)
{
    CViMap::WarpToIconPosition(work);
    work->mapBack.DrawIslandBackgrounds(work->mapPos.x, work->mapPos.y);
}

void CViMap::InitSprites(CViMap *work)
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

void CViMap::Release(CViMap *work)
{
    s32 i;

    ReleaseHubBGCircleEffect(&work->bgCircleEffect);
    CViMap::ReleaseUnknown2056FDC(work);

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
    work->mapBack.Release();
}

void CViMap::Main_Moving(void)
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
        CViMap::ClampPosToMapBounds(x, y, &x, &y);
        CViMap::TravelToPosition(x, y, 32);
        PlayHubSfx(HUB_SFX_CURSOL);
    }

    CViMap::ProcessMapPosMove(work);
    work->mapBack.ProcessDecorationAnims();
    work->mapBack.DrawAllSpriteDecorations(FALSE);
    work->mapIcon.SetWorldPosition(work->mapPos.x, work->mapPos.y);
    work->mapIcon.ProcessPlayerIcon();
    work->mapIcon.Draw();
}

void CViMap::Main_Idle(void)
{
    CViMap *work = TaskGetWorkCurrent(CViMap);

    CViMap::ProcessMapPosMove(work);

    work->mapBack.ProcessDecorationAnims();
    work->mapBack.DrawAllSpriteDecorations(FALSE);

    work->mapIcon.SetWorldPosition(work->mapPos.x, work->mapPos.y);
    work->mapIcon.ProcessPlayerIcon();
    work->mapIcon.Draw();
}

void CViMap::Main_ConstructionCutscene(void)
{
    CViMap *work;
    GXRgb color;
    const CViMapAreaConfig *config;
    BOOL flag = FALSE;
    u16 progress;
    s16 scale;
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
                scale    = FLOAT_TO_FX32(2.0) - (FX32_FROM_WHOLE(work->cutsceneTimer) >> 7);
                progress = work->cutsceneTimer >> 4;
            }
            else
            {
                scale    = FLOAT_TO_FX32(1.0);
                progress = 8;
            }
            CViMap::ProcessBGCircleEffect(work, scale, progress);
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
            CViMap::ProcessBGCircleEffect(work, FLOAT_TO_FX32(1.0), 8);
            CViMap::DrawConstructionMaterials(work);
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

            CViMap::ProcessBGCircleEffect(work, FLOAT_TO_FX32(1.0), 8);
            CViMap::DrawConstructionMaterials(work);
            break;

        case 4:
            if ((work->cutsceneTimer & 7) == 0)
                CViMap::SpawnConstructionSparkle(work);

            CViMap::DrawConstructionSparkles(work);

            brightness = work->cutsceneTimer & 0x3F;
            if (brightness >= 0x20)
                brightness = 0x3F - brightness;

            color = GX_RGB(brightness >> 1, brightness >> 1, brightness >> 1);

            if (work->shipConstructionID < CViMap::CONSTRUCT_SHIP_COUNT || work->shipUpgradeID < CViMap::UPGRADE_SHIP_COUNT
                || HubConfig__CheckDecorConstructionIsBackground(work->decorConstructionID))
            {
                CViMap::ProcessUnknown2056FDC(work, color);
            }
            else
            {
                work->mapBack.DrawNewlyConstructedSpriteDecoration(work->decorConstructionID, &work->constructionPos.x, &work->constructionPos.y, TRUE, TRUE);
                flag = TRUE;
            }
            break;
    }

    work->cutsceneTimer++;

    CViMap::ProcessMapPosMove(work);
    work->mapBack.ProcessDecorationAnims();

    if (flag)
        CViMap::DrawConstructionCompletePulse(work, color);

    if (work->decorConstructionID == CVIMAP_DECOR_WHALE)
        work->mapBack.DrawAllSpriteDecorations(TRUE);
    else
        work->mapBack.DrawAllSpriteDecorations(FALSE);
}

void CViMap::Destructor(Task *task)
{
    CViMap *work = TaskGetWork(task, CViMap);

    CViMap::Release(work);

    // TODO: use 'HubTaskDestroy' when CViMap::DestructorInternal matches
    // HubTaskDestroy<CViMap>(task);
    CViMap::DestructorInternal(task);

    mapTaskSingleton = NULL;
}

// TODO: should match when destructors are decompiled for 'CViMapIcon' & 'CViMapBack'
NONMATCH_FUNC void CViMap::DestructorInternal(Task *task)
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

void CViMapPaletteAnimation::Main(void)
{
    CViMapPaletteAnimation *work = TaskGetWorkCurrent(CViMapPaletteAnimation);

    for (s32 i = 0; i < 3; i++)
    {
        AnimatePalette(&work->aniPalette[i]);
        DrawAnimatedPalette(&work->aniPalette[i]);
    }
}

void CViMapPaletteAnimation::Destructor(Task *task)
{
    s32 i;

    CViMapPaletteAnimation *work = TaskGetWork(task, CViMapPaletteAnimation);

    for (i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
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

void CViMap::WarpToIconPosition(CViMap *work)
{
    u16 y, x;
    work->mapIcon.GetIconPosition(work->mapIcon.GetCurrentArea(), &x, &y);

    x += 8;
    y += 8;
    CViMap::ClampPosToMapBounds(x, y, &x, &y);
    CViMap::WarpToPosition(x, y);
}

void CViMap::ClampPosToMapBounds(u16 x, u16 y, u16 *outX, u16 *outY)
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

void CViMap::ProcessMapPosMove(CViMap *work)
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

    work->mapBack.DrawIslandBackgrounds(work->mapPos.x, work->mapPos.y);
}

void CViMap::InitDecorations(CViMap *work)
{
    work->mapBack.AddActiveImage(0);
    work->mapBack.AddActiveImage(1);

    for (s32 i = 0; i < CViMap::CONSTRUCT_SHIP_COUNT; i++)
    {
        if (HubControl::CheckShipConstructed(i))
        {
            const CViMapAreaConfig *config = HubConfig__GetDockMapConfig(i);

            work->mapBack.AddActiveImage(*HubConfig__GetMapBackDecorBackgroundConfig(HubConfig__GetDockMapIconConfig(config->mapArea)->dockImageID));
        }
    }

    for (s32 i = 0; i < CVIMAP_DECOR_COUNT; i++)
    {
        if (HubControl::CheckDecorConstructed(i))
        {
            const u16 *value = HubConfig__GetMapBackDecorID(i);
            if (HubConfig__CheckDecorConstructionIsBackground(i))
            {
                work->mapBack.AddActiveImage(*HubConfig__GetMapBackDecorBackgroundConfig(*value));
            }
            else
            {
                work->mapBack.SetDecorationActive(*value);
            }
        }
    }
}

void CViMap::ProcessBGCircleEffect(CViMap *work, fx32 scale, s32 progress)
{
    SetHubBGCircleEffectPosition(&work->bgCircleEffect, work->constructionPos.x, work->constructionPos.y);
    SetHubBGCircleEffectScale(&work->bgCircleEffect, scale);
    SetHubBGCircleEffectBrightness(&work->bgCircleEffect, FX_DivS32(FX32_FROM_WHOLE(progress), 16));
    ProcessHubBGCircleEffect(&work->bgCircleEffect);
}

NONMATCH_FUNC void CViMap::DrawConstructionMaterials(CViMap *work)
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

void CViMap::SpawnConstructionSparkle(CViMap *work)
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

void CViMap::DrawConstructionSparkles(CViMap *work)
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

void CViMap::InitUnknown2056FDC(CViMap *work)
{
    work->unknownStartX = 0;
    work->unknownStartY = 0;
    Unknown2056FDC__Init(&work->unknown);
}

void CViMap::LoadUnknown2056FDC(CViMap *work, u16 id)
{
    CViMap::ReleaseUnknown2056FDC(work);
    CViMap::InitDecorations(work);

    work->mapBack.AddActiveImage(*HubConfig__GetMapBackDecorBackgroundConfig(id));
    work->mapBack.InitImageBlitterForHighPriorityImage(*HubConfig__GetMapBackDecorBackgroundConfig(id));

    u16 canvasStartX;
    u16 canvasStartY;
    u16 canvasWidth;
    u16 canvasHeight;
    work->mapBack.GetImageSize(*HubConfig__GetMapBackDecorBackgroundConfig(id), &canvasStartX, &canvasStartY, &canvasWidth, &canvasHeight);

    work->unknownStartX = TILE_SIZE * canvasStartX;
    work->unknownStartY = TILE_SIZE * canvasStartY;

    void *canvasPixels = HeapAllocTail(HEAP_USER, canvasHeight * (canvasWidth * sizeof(GXCharFmt256)));
    work->mapBack.CopyToCanvas(canvasPixels, 0, 0, canvasWidth, canvasHeight);
    work->mapBack.ReleaseImageBlitter();

    Unknown2056FDC__Func_2057004(&work->unknown, GRAPHICS_ENGINE_B, TRUE, canvasPixels, canvasWidth, canvasHeight, work->mapBack.GetCanvasPalette(), 256);
    work->unknown.work.flags1 |= 0x8;
    work->unknown.work.flags1 |= 0x4;
    work->unknown.work.paletteBank = PALETTE_ROW_15;
    work->unknown.work.priority    = SPRITE_PRIORITY_2;
    work->unknown.work.order       = SPRITE_ORDER_31;
    work->unknown.work.mode        = 0;
    Unknown2056FDC__Func_2057484(&work->unknown);

    HeapFree(HEAP_USER, canvasPixels);
}

void CViMap::ProcessUnknown2056FDC(CViMap *work, GXRgb color)
{
    s16 x;
    s16 y;
    work->mapBack.GetIslandPos(&x, &y);

    work->unknown.work.mode = 1;
    MI_CpuFill16(work->unknown.work.palettePtr, color, 2 * work->unknown.work.colorCount);

    Unknown2056FDC__Func_2057460(&work->unknown, FALSE, TRUE);
    work->unknown.work.x1 = work->unknownStartX - x + 24;
    work->unknown.work.y1 = work->unknownStartY - y + 16;

    Unknown2056FDC__Func_2057484(&work->unknown);
    Unknown2056FDC__Func_2057614(&work->unknown);
}

void CViMap::ReleaseUnknown2056FDC(CViMap *work)
{
    work->unknownStartX = 0;
    work->unknownStartY = 0;
    Unknown2056FDC__Release(&work->unknown);
}

void CViMap::InitUnknown(CViMap *work)
{
    // Nothing to do.
}

void CViMap::InitConstructionCompletePulse(CViMap *work)
{
    InitHubConstructionCompletePulse(&work->constructionCompletePulse, 0, GRAPHICS_ENGINE_B, BACKGROUND_2, PALETTE_ROW_0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG2);
}

void CViMap::DrawConstructionCompletePulse(CViMap *work, GXRgb color)
{
    DrawHubConstructionCompletePulse(&work->constructionCompletePulse, color);
    work->mapBack.DrawSingleSpriteDecoration(work->decorConstructionID, 1);
}

void CViMap::ReleaseConstructionCompletePulse(CViMap *work)
{
    // Nothing to do.
}