#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/util/spriteButton.h>

// Objects
#include <seaMap/objects/seaMapIslandIcon.h>
#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <seaMap/objects/seaMapBoatIcon.h>
#include <seaMap/objects/seaMapStylusIcon.h>
#include <seaMap/objects/seaMapCoralCaveIcon.h>
#include <seaMap/objects/seaMapDSPopup.h>
#include <seaMap/objects/seaMapJohnnyIcon.h>
#include <seaMap/objects/seaMapSkyBabylonIcon.h>
#include <seaMap/objects/seaMapTargetFlagIcon.h>
#include <seaMap/objects/seaMapUnknownEncounter.h>
#include <seaMap/objects/seaMapSparkles.h>

// --------------------
// CONSTANTS
// --------------------

#define SEAMAPOBJECT_DESTROYED 0xFFFF

#define SEAMAPOBJECT_TYPE_MASK_ACTIVE 0x8000

// --------------------
// VARIABLES
// --------------------

Task *gSeaMapEventManagerTaskSingleton;

static const s32 sIslandUnlockList[42] = {
    [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND,
    [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM,
    [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH,
    [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = SEAMAPMANAGER_DISCOVER_CORAL_CAVE,
    [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP,
    [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS,
    [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = SEAMAPMANAGER_DISCOVER_SKY_BABYLON,
    [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND,
    [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = SEAMAPMANAGER_DISCOVER_BIG_SWELL,
    [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = SEAMAPMANAGER_DISCOVER_DEEP_CORE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2,
    [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND,
    [SEAMAPMANAGER_DISCOVER_13]                = SEAMAPMANAGER_DISCOVER_13,
    [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5,
    [SEAMAPMANAGER_DISCOVER_18]                = SEAMAPMANAGER_DISCOVER_18,
    [SEAMAPMANAGER_DISCOVER_19]                = SEAMAPMANAGER_DISCOVER_19,
    [SEAMAPMANAGER_DISCOVER_20]                = SEAMAPMANAGER_DISCOVER_20,
    [SEAMAPMANAGER_DISCOVER_21]                = SEAMAPMANAGER_DISCOVER_21,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_33]                = SEAMAPMANAGER_DISCOVER_33,
    [SEAMAPMANAGER_DISCOVER_34]                = SEAMAPMANAGER_DISCOVER_34,
    [SEAMAPMANAGER_DISCOVER_35]                = SEAMAPMANAGER_DISCOVER_35,
    [SEAMAPMANAGER_DISCOVER_36]                = SEAMAPMANAGER_DISCOVER_36,
    [SEAMAPMANAGER_DISCOVER_37]                = SEAMAPMANAGER_DISCOVER_37,
    [SEAMAPMANAGER_DISCOVER_38]                = SEAMAPMANAGER_DISCOVER_38,
    [SEAMAPMANAGER_DISCOVER_39]                = SEAMAPMANAGER_DISCOVER_39,
    [SEAMAPMANAGER_DISCOVER_40]                = SEAMAPMANAGER_DISCOVER_40,
    [SEAMAPMANAGER_DISCOVER_41]                = SEAMAPMANAGER_DISCOVER_41,
};

static const SaveProgress sIslandProgressUnlockList[45] = { [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = SAVE_PROGRESS_0,
                                                            [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = SAVE_PROGRESS_1,
                                                            [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = SAVE_PROGRESS_2,
                                                            [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = SAVE_PROGRESS_3,
                                                            [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = SAVE_PROGRESS_4,
                                                            [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = SAVE_PROGRESS_5,
                                                            [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = SAVE_PROGRESS_6,
                                                            [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = SAVE_PROGRESS_7,
                                                            [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = SAVE_PROGRESS_8,
                                                            [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = SAVE_PROGRESS_10,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = SAVE_PROGRESS_11,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = SAVE_PROGRESS_12,
                                                            [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = SAVE_PROGRESS_13,
                                                            [SEAMAPMANAGER_DISCOVER_13]                = SAVE_PROGRESS_14,
                                                            [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = SAVE_PROGRESS_14,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = SAVE_PROGRESS_15,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = SAVE_PROGRESS_16,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = SAVE_PROGRESS_17,
                                                            [SEAMAPMANAGER_DISCOVER_18]                = SAVE_PROGRESS_19,
                                                            [SEAMAPMANAGER_DISCOVER_19]                = SAVE_PROGRESS_20,
                                                            [SEAMAPMANAGER_DISCOVER_20]                = SAVE_PROGRESS_21,
                                                            [SEAMAPMANAGER_DISCOVER_21]                = SAVE_PROGRESS_23,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = SAVE_PROGRESS_24,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = SAVE_ZONE5_PROGRESS_2,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = SAVE_ZONE5_PROGRESS_3,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = SAVE_ZONE5_PROGRESS_4,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = SAVE_ZONE6_PROGRESS_3,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = SAVE_ZONE6_PROGRESS_4,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = SAVE_ZONE6_PROGRESS_4,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = SAVE_ZONE6_PROGRESS_5,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = SAVE_ZONE6_PROGRESS_6,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = SAVE_PROGRESS_25,
                                                            [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = SAVE_PROGRESS_27,
                                                            [SEAMAPMANAGER_DISCOVER_33]                = SAVE_PROGRESS_28,
                                                            [SEAMAPMANAGER_DISCOVER_34]                = SAVE_PROGRESS_29,
                                                            [SEAMAPMANAGER_DISCOVER_35]                = SAVE_PROGRESS_30,
                                                            [SEAMAPMANAGER_DISCOVER_36]                = SAVE_PROGRESS_31,
                                                            [SEAMAPMANAGER_DISCOVER_37]                = SAVE_PROGRESS_33,
                                                            [SEAMAPMANAGER_DISCOVER_38]                = SAVE_PROGRESS_34,
                                                            [SEAMAPMANAGER_DISCOVER_39]                = SAVE_PROGRESS_35,
                                                            [SEAMAPMANAGER_DISCOVER_40]                = SAVE_PROGRESS_35,
                                                            [SEAMAPMANAGER_DISCOVER_41]                = SAVE_PROGRESS_36,
                                                            [SEAMAPMANAGER_DISCOVER_42]                = SAVE_PROGRESS_37,
                                                            [SEAMAPMANAGER_DISCOVER_43]                = SAVE_PROGRESS_38,
                                                            [SEAMAPMANAGER_DISCOVER_44]                = SAVE_PROGRESS_39 };

const SeaMapLayoutObjectType gSeaMapObjectTypeList[SEAMAPOBJECT_COUNT] = {
    [SEAMAPOBJECT_ISLAND_DRAW_ICON] =
    {
        .animID        = SEAMAP_CHCOM_ANI_42,
        .palette       = PALETTE_ROW_4,
        .viewBounds    = { 16, 16 },
        .createFunc    = CreateSeaMapIslandDrawIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_UNUSED] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 0, 0 },
        .createFunc    = 0,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_ISLAND_ICON_ELIPSE] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 64, 64 },
        .createFunc    = CreateSeaMapIslandIcon,
        .arrivalCheck  = SeaMapIslandIcon_ArrivalCheck,
    },

    [SEAMAPOBJECT_ISLAND_ICON_RECT] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 64, 64 },
        .createFunc    = CreateSeaMapIslandIcon,
        .arrivalCheck  = SeaMapIslandIcon_ArrivalCheck,
    },

    [SEAMAPOBJECT_JOHNNY_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 16, 16 },
        .createFunc    = CreateSeaMapJohnnyIcon,
        .arrivalCheck  = SeaMapJohnnyIcon_ArrivalCheck,
    },

    [SEAMAPOBJECT_UNKNOWN_ENCOUNTER] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 16, 16 },
        .createFunc    = CreateSeaMapUnknownEncounter,
        .arrivalCheck  = SeaMapUnknownEncounter_ArrivalCheck,
    },

    [SEAMAPOBJECT_CORAL_CAVE_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_128,
        .palette       = PALETTE_ROW_8,
        .viewBounds    = { 28, 36 },
        .createFunc    = CreateSeaMapCoralCaveIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_SKY_BABYLON_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_130,
        .palette       = PALETTE_ROW_9,
        .viewBounds    = { 28, 36 },
        .createFunc    = CreateSeaMapSkyBabylonIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_TARGET_FLAG_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_139,
        .palette       = PALETTE_ROW_4,
        .viewBounds    = { 32, 32 },
        .createFunc    = CreateSeaMapTargetFlagIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_BOAT_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_14,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapBoatIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_STYLUS_PROMPT] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_14,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapStylusIcon,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_DS_POPUP] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_2,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapDSPopup,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_SPARKLES_MAJOR_ISLAND] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_5,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapSparkles,
        .arrivalCheck  = NULL,
    },

    [SEAMAPOBJECT_SPARKLES_MINOR_ISLAND] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_5,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapSparkles,
        .arrivalCheck  = NULL,
    },
};

// --------------------
// FUNCTION DECLS
// --------------------

extern void SeaMapCoralCaveIcon_State_BeginAppearing(SeaMapCoralCaveIcon *work);

// --------------------
// FUNCTIONS
// --------------------

BOOL SeaMapEventManager_CheckIslandUnlocked(u32 id)
{
    switch (id)
    {
        default:
            return SeaMapManager__GetSaveFlag(sIslandUnlockList[id]);

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
    }
}

void CreateSeaMapEventManager(void)
{
    Task *task = TaskCreate(SeaMapEventManager_Main, SeaMapEventManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x110, TASK_GROUP(0), SeaMapEventManager);
    gSeaMapEventManagerTaskSingleton = task;

    SeaMapEventManager *work = TaskGetWork(task, SeaMapEventManager);
    TaskInitWork16(work);

    SeaMapEventManager_ClearLastTouchedIcon();

    for (s32 i = 0; i < SEAMAPEVENTMANAGER_CREATE_OBJECT_LIST_SIZE; i++)
    {
        work->objectList[i].type = SEAMAPOBJECT_DESTROYED;
    }

    SeaMapManager *manager = SeaMapManager__GetWork();

    AnimatorSprite *aniJohnny = &work->aniJohnny;
    AnimatorSprite__Init(aniJohnny, manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_137, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_137)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    aniJohnny->cParam.palette = PALETTE_ROW_6;
    AnimatorSprite__ProcessAnimationFast(aniJohnny);

    AnimatorSprite *aniJohnnyDefeated = &work->aniJohnnyDefeated;
    AnimatorSprite__Init(aniJohnnyDefeated, manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_138, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_138)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    aniJohnnyDefeated->cParam.palette = PALETTE_ROW_6;
    AnimatorSprite__ProcessAnimationFast(aniJohnnyDefeated);

    AnimatorSprite *aniTargetFlag = &work->aniTargetFlag;
    AnimatorSprite__Init(aniTargetFlag, manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_139, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING,
                         manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_139)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    aniTargetFlag->cParam.palette = PALETTE_ROW_4;
    AnimatorSprite__ProcessAnimationFast(aniTargetFlag);
    aniTargetFlag->flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    SeaMapEventManager_SpawnInitialObjects();
}

void DestroySeaMapEventManager(void)
{
    if (gSeaMapEventManagerTaskSingleton == NULL)
        return;

    DestroyTaskGroup(TASK_GROUP(1));
    DestroyTask(gSeaMapEventManagerTaskSingleton);
}

SeaMapObject *SeaMapEventManager_CreateObject(s32 type, s16 x, s16 y, u8 flags, HitboxRect *box, s16 id)
{
    SeaMapEventManager *work                 = GetSeaMapEventManagerWork();
    const SeaMapLayoutObjectType *objectType = &gSeaMapObjectTypeList[type];

    SeaMapLayoutObject *mapObject = NULL;
    s32 i                         = 0;
    for (; i < SEAMAPEVENTMANAGER_CREATE_OBJECT_LIST_SIZE; i++)
    {
        if (work->objectList[i].type == SEAMAPOBJECT_DESTROYED)
        {
            mapObject = &work->objectList[i];
            break;
        }
    }

    MI_CpuClear16(mapObject, sizeof(*mapObject));
    mapObject->type       = type;
    mapObject->position.x = x;
    mapObject->position.y = y;
    mapObject->sysFlags   = SEAMAPLAYOUTOBJECT_SYSFLAG_NON_MAP_OBJECT;
    mapObject->usrFlags   = flags;
    if (box)
        MI_CpuCopy16(box, &mapObject->box, sizeof(mapObject->box));
    mapObject->id = id;
    return objectType->createFunc(objectType, mapObject);
}

SeaMapEventManager *GetSeaMapEventManagerWork2(void)
{
    return GetSeaMapEventManagerWork();
}

void SeaMapEventManager_ClearLastTouchedIcon(void)
{
    SeaMapEventManager *work = GetSeaMapEventManagerWork2();

    work->lastTouchedIconType = -1;
    work->lastTouchedIcon     = NULL;
}

void SeaMapEventManager_ClearDrawIconButtonState(SeaMapIslandDrawIcon *icon)
{
    SetSpriteButtonState(&icon->aniDrawIcon, SPRITE_BUTTON_STATE_IDLE);
}

SeaMapLayoutObject *SeaMapEventManager_GetObjectFromID(u32 id)
{
    SeaMapObjectLayout *layout = SeaMapManager__GetWork()->assets.objectLayout;

    SeaMapLayoutObject *mapObjectList        = layout->objectList;
    SeaMapObjectLayoutDrawIconList *iconList = (SeaMapObjectLayoutDrawIconList *)&layout->objectList[layout->count];
    for (u16 i = 0; i < iconList->count; i++)
    {
        SeaMapLayoutObject *mapObject = &mapObjectList[iconList->iconList[i]];

        if (mapObject->id == id)
            return mapObject;
    }

    return NULL;
}

void SeaMapEventManager_FindVisibleIslands(fx32 shipX, fx32 shipY, fx32 distanceThreshold, SeaMapVoyageVisibleIsland *islandList, u16 *islandCount)
{
    SeaMapObjectLayout *layout = SeaMapManager__GetWork()->assets.objectLayout;

    *islandCount                             = 0;
    SeaMapLayoutObject *mapObjectList        = layout->objectList;
    SeaMapObjectLayoutDrawIconList *iconList = (SeaMapObjectLayoutDrawIconList *)&layout->objectList[layout->count];
    for (u16 i = 0; i < iconList->count; i++)
    {
        SeaMapLayoutObject *mapObject = &mapObjectList[iconList->iconList[i]];

        switch (mapObject->id)
        {
            case SEAMAPMANAGER_DISCOVER_CORAL_CAVE:
                if (SeaMapManager__GetSaveFlag(SEAMAPMANAGER_DISCOVER_CORAL_CAVE) == FALSE)
                    continue;
                break;

            case SEAMAPMANAGER_DISCOVER_SKY_BABYLON:
                continue;

            default:
                break;
        }

        fx32 localY = FX32_FROM_WHOLE(mapObject->position.y) - shipY;
        fx32 localX = FX32_FROM_WHOLE(mapObject->position.x) - shipX;
        localX      = MATH_ABS(localX);
        localY      = MATH_ABS(localY);

        fx32 radius;
        if (localX > localY)
        {
            fx32 x = MultiplyFX(localX, FLOAT_TO_FX32(0.96045));
            fx32 y = MultiplyFX(localY, FLOAT_TO_FX32(0.397705078125));
            radius = x + y;
        }
        else
        {
            fx32 y = MultiplyFX(localY, FLOAT_TO_FX32(0.96045));
            fx32 x = MultiplyFX(localX, FLOAT_TO_FX32(0.397705078125));
            radius = y + x;
        }

        if (radius <= distanceThreshold)
        {
            islandList[*islandCount].object = mapObject;
            islandList[*islandCount].radius = radius;
            (*islandCount)++;
        }
    }
}

u32 SeaMapEventManager_GetObjectType(SeaMapLayoutObject *mapObject)
{
    return mapObject->type & ~SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

BOOL SeaMapEventManager__IsObjectActive(SeaMapLayoutObject *mapObject)
{
    return (mapObject->type & SEAMAPOBJECT_TYPE_MASK_ACTIVE) == 0;
}

u32 SeaMapEventManager_GetDiscoverableIslandID(s16 id)
{
    switch (id)
    {
        default:
        case SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND:
            return SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND;

        case SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM:
            return SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM;

        case SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH:
            return SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH;

        case SEAMAPMANAGER_DISCOVER_CORAL_CAVE:
            return SEAMAPMANAGER_DISCOVER_CORAL_CAVE;

        case SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP:
            return SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP;

        case SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS:
            return SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS;

        case SEAMAPMANAGER_DISCOVER_SKY_BABYLON:
            return SEAMAPMANAGER_DISCOVER_SKY_BABYLON;

        case SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND:
            return SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND;

        case SEAMAPMANAGER_DISCOVER_BIG_SWELL:
            return SEAMAPMANAGER_DISCOVER_BIG_SWELL;

        case SEAMAPMANAGER_DISCOVER_DEEP_CORE:
            return SEAMAPMANAGER_DISCOVER_DEEP_CORE;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2;

        case SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND:
            return SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND;

        case SEAMAPMANAGER_DISCOVER_13:
            return SEAMAPMANAGER_DISCOVER_13;

        case SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND:
            return SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5;

        case SEAMAPMANAGER_DISCOVER_18:
            return SEAMAPMANAGER_DISCOVER_18;

        case SEAMAPMANAGER_DISCOVER_19:
            return SEAMAPMANAGER_DISCOVER_19;

        case SEAMAPMANAGER_DISCOVER_20:
            return SEAMAPMANAGER_DISCOVER_20;

        case SEAMAPMANAGER_DISCOVER_21:
            return SEAMAPMANAGER_DISCOVER_21;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16;

        case SEAMAPMANAGER_DISCOVER_33:
            return SEAMAPMANAGER_DISCOVER_33;

        case SEAMAPMANAGER_DISCOVER_34:
            return SEAMAPMANAGER_DISCOVER_34;

        case SEAMAPMANAGER_DISCOVER_35:
            return SEAMAPMANAGER_DISCOVER_35;

        case SEAMAPMANAGER_DISCOVER_36:
            return SEAMAPMANAGER_DISCOVER_36;

        case SEAMAPMANAGER_DISCOVER_37:
            return SEAMAPMANAGER_DISCOVER_37;

        case SEAMAPMANAGER_DISCOVER_38:
            return SEAMAPMANAGER_DISCOVER_38;

        case SEAMAPMANAGER_DISCOVER_39:
            return SEAMAPMANAGER_DISCOVER_39;

        case SEAMAPMANAGER_DISCOVER_40:
            return SEAMAPMANAGER_DISCOVER_40;

        case SEAMAPMANAGER_DISCOVER_41:
            return SEAMAPMANAGER_DISCOVER_41;
    }
}

u32 SeaMapEventManager_GetLandableIslandID(u32 id)
{
    switch (id)
    {
        default:
        case SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND:
            return SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND;

        case SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM:
            return SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM;

        case SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH:
            return SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH;

        case SEAMAPMANAGER_DISCOVER_CORAL_CAVE:
            return SEAMAPMANAGER_DISCOVER_CORAL_CAVE;

        case SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP:
            return SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP;

        case SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS:
            return SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS;

        case SEAMAPMANAGER_DISCOVER_SKY_BABYLON:
            return SEAMAPMANAGER_DISCOVER_SKY_BABYLON;

        case SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND:
            return SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND;

        case SEAMAPMANAGER_DISCOVER_BIG_SWELL:
            return SEAMAPMANAGER_DISCOVER_BIG_SWELL;

        case SEAMAPMANAGER_DISCOVER_DEEP_CORE:
            return SEAMAPMANAGER_DISCOVER_DEEP_CORE;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2;

        case SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND:
            return SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND;

        case SEAMAPMANAGER_DISCOVER_13:
            return SEAMAPMANAGER_DISCOVER_13;

        case SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND:
            return SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15;

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16:
            return SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16;
    }
}

void SeaMapEventManager_SetBoatDirection(SeaMapBoatIcon *boat, BOOL facingLeft)
{
    if (facingLeft)
        boat->aniBoat.flags &= ~ANIMATOR_FLAG_FLIP_X;
    else
        boat->aniBoat.flags |= ANIMATOR_FLAG_FLIP_X;
}

SeaMapObject *CreateSeaMapEventManagerStylusIcon(fx32 startX, fx32 startY, fx32 endX, fx32 endY, s16 speed)
{
    SeaMapStylusIcon *icon = (SeaMapStylusIcon *)SeaMapEventManager_CreateObject(SEAMAPOBJECT_STYLUS_PROMPT, 0, 0, 0, NULL, 0);
    icon->startPos.x       = startX;
    icon->startPos.y       = startY;
    icon->endPos.x         = endX;
    icon->endPos.y         = endY;
    icon->speed            = speed;

    return &icon->objWork;
}

void DestroySeaMapEventManagerStylusIcon(SeaMapObject *work)
{
    if (work->task != NULL)
    {
        DestroyTask(work->task);
        work->task = NULL;
    }
}

void CreateSeaMapEventManagerDSPopup(void)
{
    if (GetSeaMapEventManagerWork()->dsPopup == NULL)
        SeaMapEventManager_CreateObject(SEAMAPOBJECT_DS_POPUP, HW_LCD_CENTER_X, HW_LCD_CENTER_Y, 0, NULL, 0);
}

void DestroySeaMapEventManagerDSPopup(void)
{
    if (GetSeaMapEventManagerWork()->dsPopup != NULL)
        DestroyTask(GetSeaMapEventManagerWork()->dsPopup);
}

void SeaMapEventManager_UnlockCoralCave(void)
{
    if (GetSeaMapEventManagerWork()->coralCaveIcon == NULL)
        return;

    SeaMapCoralCaveIcon *icon = TaskGetWork(GetSeaMapEventManagerWork()->coralCaveIcon, SeaMapCoralCaveIcon);
    icon->state               = SeaMapCoralCaveIcon_State_BeginAppearing;
}

void SeaMapEventManager_UnlockSkyBabylon(void)
{
    if (GetSeaMapEventManagerWork()->skyBabylonIcon == NULL)
        return;

    SeaMapSkyBabylonIcon *icon = TaskGetWork(GetSeaMapEventManagerWork()->skyBabylonIcon, SeaMapSkyBabylonIcon);
    icon->state                = SeaMapSkyBabylonIcon_State_BeginAppear;
}

void SeaMapEventManager_ProcessAnimator(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    u16 i = RenderCore_GetTargetVBlankCount() + 1;
    while (i--)
    {
        AnimatorSprite__ProcessAnimation(animator, callback, userData);
    }
}

BOOL SeaMapEventManager_CheckIslandDiscovered(u32 id)
{
    s32 progress = sIslandProgressUnlockList[id];

    switch (id)
    {
        default:
            return progress <= SaveGame__GetGameProgress();

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9:
            return progress <= SaveGame__GetZone5Progress();

        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13:
        case SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14:
            return progress <= SaveGame__GetZone6Progress();
    }
}

SeaMapEventManager *GetSeaMapEventManagerWork(void)
{
    return TaskGetWork(gSeaMapEventManagerTaskSingleton, SeaMapEventManager);
}

void SeaMapEventManager_SpawnInitialObjects(void)
{
    SeaMapObjectLayout *layout = SeaMapManager__GetWork()->assets.objectLayout;

    for (u16 i = 0; i < layout->count; i++)
    {
        SeaMapLayoutObject *mapObject = &layout->objectList[i];

        if (SeaMapEventManager__IsObjectActive(mapObject))
        {
            const SeaMapLayoutObjectType *objectType = &gSeaMapObjectTypeList[mapObject->type];

            if ((mapObject->sysFlags & SEAMAPLAYOUTOBJECT_SYSFLAG_SPAWN_INSTANTLY) != 0)
                objectType->createFunc(objectType, &layout->objectList[i]);
        }
    }
}

void SeaMapEventManager_Main(void)
{
    SeaMapEventManager *work;
    SeaMapObjectLayout *layout;
    u16 i;
    SeaMapLayoutObject *mapObject;
    const SeaMapLayoutObjectType *objectType;

    work = TaskGetWorkCurrent(SeaMapEventManager);

    layout = SeaMapManager__GetWork()->assets.objectLayout;

    for (i = 0; i < layout->count; i++)
    {
        mapObject = &layout->objectList[i];

        if (SeaMapEventManager__IsObjectActive(mapObject))
        {
            objectType = &gSeaMapObjectTypeList[mapObject->type];

            if (SeaMapEventManager_CheckVisible(&mapObject->position, objectType->viewBounds))
                objectType->createFunc(objectType, mapObject);
        }
    }

    SeaMapEventManager_ProcessAnimator(&work->aniTargetFlag, NULL, NULL);
}

void SeaMapEventManager_Destructor(Task *task)
{
    SeaMapEventManager *work = TaskGetWork(task, SeaMapEventManager);

    AnimatorSprite__Release(&work->aniJohnny);
    AnimatorSprite__Release(&work->aniJohnnyDefeated);
    AnimatorSprite__Release(&work->aniTargetFlag);

    gSeaMapEventManagerTaskSingleton = NULL;
}

void InitSeaMapEventManagerObject(SeaMapObject *work, Task *task, const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    work->task       = task;
    work->objectType = objectType;
    work->mapObject  = mapObject;
    work->position.x = mapObject->position.x;
    work->position.y = mapObject->position.y;
}

void DestroySeaMapEventManagerObject(SeaMapObject *work)
{
    SeaMapLayoutObject *mapObject = work->mapObject;

    if ((mapObject->sysFlags & SEAMAPLAYOUTOBJECT_SYSFLAG_NON_MAP_OBJECT) != 0)
        mapObject->type = SEAMAPOBJECT_DESTROYED;
}

NONMATCH_FUNC BOOL SeaMapEventManager_CheckVisible(Vec2Fx16 *objPos, const s8 *viewBounds)
{
    // https://decomp.me/scratch/eq7RZ -> 64.52%
#ifdef NON_MATCHING
    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    fx32 zoomScale = SeaMapManager__GetZoomInScale();
    fx16 mapLeft   = FX32_TO_WHOLE(SeaMapManager__GetXPos());
    fx16 mapTop    = FX32_TO_WHOLE(SeaMapManager__GetYPos());
    fx16 mapRight  = mapLeft + FX32_TO_WHOLE(zoomScale * HW_LCD_WIDTH);
    fx16 mapBottom = mapTop + HW_LCD_HEIGHT + FX32_TO_WHOLE(zoomScale * HW_LCD_HEIGHT);

    fx16 boundSizeX = FX32_TO_WHOLE(viewBounds[0] * SeaMapManager__GetZoomInScale());
    fx16 boundSizeY = FX32_TO_WHOLE(viewBounds[1] * SeaMapManager__GetZoomInScale());

    if (objPos->x >= (fx16)(mapLeft - boundSizeX) && objPos->x < (fx16)(mapRight + boundSizeX) && objPos->y >= (fx16)(mapTop - boundSizeY)
        && objPos->y < (fx16)(mapBottom + boundSizeY))
    {
        return TRUE;
    }

    return FALSE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	bl SeaMapManager__GetZoomInScale
	mov r4, r0
	bl SeaMapManager__GetXPos
	mov r8, r0, lsl #4
	bl SeaMapManager__GetYPos
	mov r1, #0xc0
	mov r0, r0, lsl #4
	mov r5, r0, asr #0x10
	mov r0, r4, lsl #8
	mov r0, r0, asr #0xc
	add r2, r0, r8, asr #16
	mul r0, r4, r1
	add r1, r5, #0xc0
	add r0, r1, r0, asr #12
	mov r9, r2, lsl #0x10
	mov r10, r0, lsl #0x10
	bl SeaMapManager__GetZoomInScale
	ldrsb r1, [r6, #0]
	mul r0, r1, r0
	mov r0, r0, lsl #4
	mov r4, r0, asr #0x10
	bl SeaMapManager__GetZoomInScale
	ldrsb r1, [r6, #1]
	rsb r6, r4, r8, asr #16
	add r4, r4, r9, asr #16
	mul r0, r1, r0
	mov r0, r0, lsl #4
	mov r2, r0, asr #0x10
	sub r0, r5, r0, asr #16
	mov r1, r0, lsl #0x10
	add r3, r2, r10, asr #16
	ldrsh r2, [r7, #0]
	mov r0, r6, lsl #0x10
	mov r5, r1, asr #0x10
	cmp r2, r0, asr #16
	mov r0, r4, lsl #0x10
	mov r1, r3, lsl #0x10
	blt _020474F4
	cmp r2, r0, asr #16
	bge _020474F4
	ldrsh r0, [r7, #2]
	cmp r5, r0
	bgt _020474F4
	cmp r0, r1, asr #16
	movlt r0, #1
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020474F4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void SeaMapEventManager_GetMapLocalPosition(Vec2Fx16 *worldPosition, Vec2Fx16 *mapLocalPosition)
{
    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    mapLocalPosition->x = FX32_TO_WHOLE(zoomScale * (worldPosition->x - FX32_TO_WHOLE(SeaMapManager__GetXPos())));
    mapLocalPosition->y = FX32_TO_WHOLE(zoomScale * (worldPosition->y - FX32_TO_WHOLE(SeaMapManager__GetYPos())));
}

void SeaMapEventManager_SetObjectAsActive(SeaMapObject *work)
{
    work->mapObject->type |= SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

void SeaMapEventManager_SetObjectAsInactive(SeaMapObject *work)
{
    work->mapObject->type &= ~SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

BOOL SeaMapEventManager_CheckObjectPosDiscoveredOnMap(SeaMapLayoutObject *mapObject)
{
    u16 y;
    u16 x;

    SeaMapManager__ConvertWorldPosToMapPos(FX32_FROM_WHOLE(mapObject->position.x), FX32_FROM_WHOLE(mapObject->position.y), &x, &y);
    return SeaMapManager__GetMapPixel(x, y) == SEAMAPMANAGER_PIXEL_DISCOVERED;
}

void SeaMapEventManager_GetViewElipse(HitboxRect *rect, fx32 x, fx32 y, s32 *centerX, s32 *centerY, s32 *width, s32 *height)
{
    *width   = ((rect->right - rect->left) << (FX32_SHIFT - 1));
    *height  = ((rect->bottom - rect->top) << (FX32_SHIFT - 1));
    *centerX = FX32_FROM_WHOLE(x + ((rect->left + rect->right) >> 1));
    *centerY = FX32_FROM_WHOLE(y + ((rect->top + rect->bottom) >> 1));
}

void SeaMapEventManager_GetViewRect(HitboxRect *rect, fx32 x, fx32 y, ViewRect *viewRect)
{
    viewRect->left   = FX32_FROM_WHOLE(x + rect->left);
    viewRect->top    = FX32_FROM_WHOLE(y + rect->top);
    viewRect->right  = FX32_FROM_WHOLE(x + rect->right);
    viewRect->bottom = FX32_FROM_WHOLE(y + rect->bottom);
}

BOOL SeaMapEventManager_PointInViewElipse(s32 centerX, s32 centerY, s32 width, s32 height, fx32 x, fx32 y)
{
    fx32 distX1  = x - centerX;
    fx32 radiusX = MATH_ABS(distX1);

    fx32 distY1  = y - centerY;
    fx32 radiusY = MATH_ABS(distY1);

    if (radiusX >= radiusY)
        radiusY = radiusX;

    if (radiusY > width && radiusY > height)
        return FALSE;

    return FX_Div(MultiplyFX(distX1, distX1), MultiplyFX(width, width)) + FX_Div(MultiplyFX(distY1, distY1), MultiplyFX(height, height)) <= FLOAT_TO_FX32(1.0);
}

BOOL SeaMapEventManager_PointInViewRect(s32 left, s32 top, s32 right, s32 bottom, fx32 x, fx32 y)
{
    return left <= x && x <= right && top <= y && y <= bottom;
}

BOOL SeaMapEventManager_ViewRectCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y)
{
    ViewRect viewRect;

    SeaMapEventManager_GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
    return SeaMapEventManager_PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y) != FALSE;
}

BOOL SeaMapEventManager_ViewElipseCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y)
{
    s32 centerY;
    s32 centerX;
    s32 height;
    s32 width;

    SeaMapEventManager_GetViewElipse(&mapObject->box, mapObject->position.x, mapObject->position.y, &centerX, &centerY, &width, &height);
    return SeaMapEventManager_PointInViewElipse(centerX, centerY, width, height, x, y) != FALSE;
}

// --------------------
// OBJECTS
// --------------------

#include "objects/seaMapIslandDrawIcon.c"
#include "objects/seaMapIslandIcon.c"
#include "objects/seaMapJohnnyIcon.c"
#include "objects/seaMapUnknownEncounter.c"
#include "objects/seaMapTargetFlagIcon.c"
#include "objects/seaMapBoatIcon.c"
#include "objects/seaMapStylusIcon.c"
#include "objects/seaMapDSPopup.c"
#include "objects/seaMapCoralCaveIcon.c"
#include "objects/seaMapSkyBabylonIcon.c"
#include "objects/seaMapSparkles.c"