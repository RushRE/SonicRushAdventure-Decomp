#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <seaMap/objects/seaMapIslandIcon.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapView.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapIslandDrawIconFlags
{
    SEAMAPISLANDDRAWICON_FLAG_NONE = 0x00,

    // Determine which ships can begin voyages from this icon
    SEAMAPISLANDDRAWICON_FLAG_ALLOW_JET = 1 << SHIP_JET,
    SEAMAPISLANDDRAWICON_FLAG_ALLOW_BOAT = 1 << SHIP_BOAT,
    SEAMAPISLANDDRAWICON_FLAG_ALLOW_HOVER = 1 << SHIP_HOVER,
    SEAMAPISLANDDRAWICON_FLAG_ALLOW_SUBMARINE = 1 << SHIP_SUBMARINE,

    // Prevent any voyages from starting at this icon
    SEAMAPISLANDDRAWICON_FLAG_ALLOW_NOTHING = 1 << 7,
};

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL CanDrawFromSeaMapIslandDrawIcon(SeaMapLayoutObject *mapObject);
static BOOL IsSeaMapIslandDrawIconActive(SeaMapIslandDrawIcon *work);
static BOOL IsSeaMapIslandDrawIconEnabled(SeaMapLayoutObject *mapObject);

static void SeaMapIslandDrawIcon_Main(void);
static void SeaMapIslandDrawIcon_Destructor(Task *task);
static void SeaMapIslandDrawIcon_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData);

// --------------------
// FUNCTIONS
// --------------------

BOOL CanDrawFromSeaMapIslandDrawIcon(SeaMapLayoutObject *mapObject)
{
    BOOL canDrawFrom;

    if (SeaMapManager__GetWork()->shipType == SHIP_MENU)
        return FALSE;

    if ((mapObject->usrFlags & SEAMAPISLANDDRAWICON_FLAG_ALLOW_NOTHING) != 0)
        return FALSE;

    if ((mapObject->usrFlags & (1 << SeaMapManager__GetWork()->shipType)) != 0)
        return FALSE;

    canDrawFrom = TRUE;
    switch (mapObject->id)
    {
        default:
            canDrawFrom = FALSE;
            break;

        case SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND:
            canDrawFrom = TRUE;
            break;

        case SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_5;
            break;

        case SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_8;
            break;

        case SEAMAPMANAGER_DISCOVER_CORAL_CAVE:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_16;
            break;

        case SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_18;
            break;

        case SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_21;
            break;

        case SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_35;
            break;

        case SEAMAPMANAGER_DISCOVER_BIG_SWELL:
            canDrawFrom = SaveGame__GetGameProgress() >= SAVE_PROGRESS_36;
            break;

        case SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS:
            canDrawFrom = SaveGame__GetZone5Progress() >= SAVE_ZONE5_PROGRESS_4;
            break;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2:
            canDrawFrom = SaveGame__GetZone6Progress() >= SAVE_ZONE6_PROGRESS_6;
            break;

        case SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND:
            canDrawFrom = SaveGame__GetZone6Progress() >= SAVE_ZONE6_PROGRESS_2;
            break;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16:
            canDrawFrom = SaveGame__GetIslandProgress(&saveGame.stage.progress, SAVE_ISLAND_HIDDEN_ISLAND_16) >= SAVE_ISLAND_STATE_BEATEN;
            break;
    }

    return canDrawFrom;
}

BOOL IsSeaMapIslandDrawIconActive(SeaMapIslandDrawIcon *work)
{
    u16 targetAnim;
    if (CanDrawFromSeaMapIslandDrawIcon(work->objWork.mapObject))
        targetAnim = SEAMAP_CHCOM_ANI_44;
    else
        targetAnim = SEAMAP_CHCOM_ANI_41;

    return work->aniDrawIcon.animator.animID == targetAnim;
}

BOOL IsSeaMapIslandDrawIconEnabled(SeaMapLayoutObject *mapObject)
{
    switch (mapObject->id)
    {
        case SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND:
            return TRUE;

        case SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_3;

        case SEAMAPMANAGER_DISCOVER_CORAL_CAVE:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_14;

        case SEAMAPMANAGER_DISCOVER_SKY_BABYLON:
            return SaveGame__GetZone6Progress() >= SAVE_ZONE6_PROGRESS_4;

        case SEAMAPMANAGER_DISCOVER_BIG_SWELL:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_35;

        case SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH) != 0;

        case SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP) != 0;

        case SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS) != 0;

        case SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2) != 0;

        case SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND) != 0;

        case SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15) != 0;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16) != 0;

        case SEAMAPMANAGER_DISCOVER_33:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_33) != 0;

        case SEAMAPMANAGER_DISCOVER_34:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_34) != 0;

        case SEAMAPMANAGER_DISCOVER_35:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_35) != 0;

        case SEAMAPMANAGER_DISCOVER_36:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_36) != 0;

        case SEAMAPMANAGER_DISCOVER_37:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_37) != 0;

        case SEAMAPMANAGER_DISCOVER_38:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_38) != 0;

        case SEAMAPMANAGER_DISCOVER_39:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_39) != 0;

        case SEAMAPMANAGER_DISCOVER_40:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_40) != 0;

        case SEAMAPMANAGER_DISCOVER_41:
            return SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_41) != 0;
    }

    return FALSE;
}

SeaMapObject *CreateSeaMapIslandDrawIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    Task *task;
    SeaMapIslandDrawIcon *work;
    SeaMapManager *manager;
    void *sprChCommon;
    SpriteButtonAnimator *aniDrawIcon;

    manager = SeaMapManager__GetWork();

    if (mapObject->id != SEAMAPMANAGER_DISCOVER_SKY_BABYLON && SeaMapEventManager_CheckObjectPosDiscoveredOnMap(mapObject) == FALSE)
        return NULL;

    if (IsSeaMapIslandDrawIconEnabled(mapObject) == FALSE)
        return NULL;

    task =
        TaskCreate(SeaMapIslandDrawIcon_Main, SeaMapIslandDrawIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapIslandDrawIcon);

    work = TaskGetWork(task, SeaMapIslandDrawIcon);
    TaskInitWork16(work);
    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);

    sprChCommon = manager->assets.sprChCommon;

    aniDrawIcon = &work->aniDrawIcon;
    if (CanDrawFromSeaMapIslandDrawIcon(mapObject))
        aniDrawIcon->animID = SEAMAP_CHCOM_ANI_42;
    else
        aniDrawIcon->animID = SEAMAP_CHCOM_ANI_39;

    for (u32 i = 0; i < 3; i++)
    {
        aniDrawIcon->paletteRow[i] = objectType->palette;
    }

    AnimatorSprite__Init(&aniDrawIcon->animator, sprChCommon, aniDrawIcon->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, manager->useEngineB,
                         PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(manager->useEngineB, GetSpriteButtonSpriteAllocSize(sprChCommon, aniDrawIcon->animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    aniDrawIcon->animator.cParam.palette = objectType->palette;
    aniDrawIcon->animator.pos.x          = mapObject->position.x;
    aniDrawIcon->animator.pos.y          = mapObject->position.y;
    AnimatorSprite__ProcessAnimationFast(&aniDrawIcon->animator);
    aniDrawIcon->animator.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    HitboxRect rect;
    fx32 radius;
    AnimatorSprite__GetBlockData(&aniDrawIcon->animator, 0, &rect);
    radius = FX32_FROM_WHOLE((rect.right - rect.left) >> 1);
    TouchField__InitAreaShape(&aniDrawIcon->touchArea, &aniDrawIcon->animator.pos, TouchField__PointInCircle, (TouchRectUnknown *)&radius, SeaMapIslandDrawIcon_TouchAreaCallback,
                              work);
    TouchField__AddArea(&manager->touchField, &aniDrawIcon->touchArea, 4);

    AnimatorSprite__ProcessAnimationFast(&aniDrawIcon->animator);

    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapIslandDrawIcon_Main(void)
{
    SeaMapIslandDrawIcon *work = TaskGetWorkCurrent(SeaMapIslandDrawIcon);

    work->aniDrawIcon.touchArea.responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;

    switch (GetSeaMapViewType())
    {
        case SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION:
            if (CanDrawFromSeaMapIslandDrawIcon(work->objWork.mapObject) == FALSE)
                work->aniDrawIcon.touchArea.responseFlags |= TOUCHAREA_RESPONSE_DISABLED;
            break;

        case SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING:
        case SEAMAPVIEW_TYPE_SAILING:
            work->aniDrawIcon.touchArea.responseFlags |= TOUCHAREA_RESPONSE_DISABLED;
            break;
    }

    if (IsSeaMapIslandDrawIconActive(work) == FALSE && SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        Vec2Fx16 drawPos;

        SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &drawPos);
        SetSpriteButtonPosition(&work->aniDrawIcon, drawPos.x, drawPos.y);
        SeaMapEventManager_ProcessAnimator(&work->aniDrawIcon.animator, NULL, NULL);
        AnimatorSprite__DrawFrame(&work->aniDrawIcon.animator);
    }
}

void SeaMapIslandDrawIcon_Destructor(Task *task)
{
    SeaMapIslandDrawIcon *work = TaskGetWork(task, SeaMapIslandDrawIcon);

    AnimatorSprite__Release(&work->aniDrawIcon.animator);
    if (SeaMapManager__IsActive())
        TouchField__RemoveArea(&SeaMapManager__GetWork()->touchField, &work->aniDrawIcon.touchArea);

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}

void SeaMapIslandDrawIcon_TouchAreaCallback(TouchAreaResponse *response, TouchArea *touchArea, void *userData)
{
    SeaMapIslandDrawIcon *work = (SeaMapIslandDrawIcon *)userData;

    TouchAreaResponseFlags areaFlags = touchArea->responseFlags;

    switch (GetSeaMapViewType())
    {
        case SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION:
        case SEAMAPVIEW_TYPE_CHART_COURSE_DRAWING:
            switch (response->flags)
            {
                case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
                    if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && GetSeaMapViewType() == SEAMAPVIEW_TYPE_CHART_COURSE_NAVIGATION)
                    {
                        SeaMapEventManager *eventManager = GetSeaMapEventManagerWork2();

                        eventManager->lastTouchedIconType = SeaMapEventManager_GetObjectType(work->objWork.mapObject);
                        eventManager->lastTouchedIcon     = work;

                        SetSpriteButtonState(&work->aniDrawIcon, SPRITE_BUTTON_STATE_SELECTED);

                        TouchField__Func_206EAC4(GetSeaMapViewTouchArea(), touchArea);
                    }
                    break;
            }
            break;

        default:
            switch (response->flags)
            {
                case TOUCHAREA_RESPONSE_ENTERED_AREA:
                case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
                    if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && IsSeaMapIslandDrawIconActive(work) == FALSE)
                    {
                        SetSpriteButtonState(&work->aniDrawIcon, SPRITE_BUTTON_STATE_HOVERED);
                    }
                    break;

                case TOUCHAREA_RESPONSE_EXITED_AREA:
                case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
                    if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && IsSeaMapIslandDrawIconActive(work) == FALSE)
                    {
                        SetSpriteButtonState(&work->aniDrawIcon, SPRITE_BUTTON_STATE_IDLE);
                    }
                    break;

                case TOUCHAREA_RESPONSE_40000:
                    if ((areaFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                    {
                        SeaMapEventManager *eventManager = GetSeaMapEventManagerWork2();

                        eventManager->lastTouchedIconType = SeaMapEventManager_GetObjectType(work->objWork.mapObject);
                        eventManager->lastTouchedIcon     = work;
                    }
                    break;
            }
            break;
    }
}