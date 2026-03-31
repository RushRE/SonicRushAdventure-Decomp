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
#include <seaMap/objects/seaMapUnknown5.h>
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

NOT_DECOMPILED const u16 SeaMapStylusIcon_AnimIDs[];
NOT_DECOMPILED const u16 SeaMapSparkles__AnimIDs1[];
NOT_DECOMPILED const u16 SeaMapSparkles__AnimIDs2[];
NOT_DECOMPILED const u32 SeaMapBoatIcon__shipAnimIDs[];

const s32 sIslandFeatureUnlockList[] = {
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
};

const SaveProgress sIslandProgressUnlockList[] = { SAVE_PROGRESS_0,  SAVE_PROGRESS_1,  SAVE_PROGRESS_2,  SAVE_PROGRESS_3,  SAVE_PROGRESS_4,  SAVE_PROGRESS_5,  SAVE_PROGRESS_6,
                                                   SAVE_PROGRESS_7,  SAVE_PROGRESS_8,  SAVE_PROGRESS_10, SAVE_PROGRESS_11, SAVE_PROGRESS_12, SAVE_PROGRESS_13, SAVE_PROGRESS_14,
                                                   SAVE_PROGRESS_14, SAVE_PROGRESS_15, SAVE_PROGRESS_16, SAVE_PROGRESS_17, SAVE_PROGRESS_19, SAVE_PROGRESS_20, SAVE_PROGRESS_21,
                                                   SAVE_PROGRESS_23, SAVE_PROGRESS_24, SAVE_PROGRESS_2,  SAVE_PROGRESS_3,  SAVE_PROGRESS_4,  SAVE_PROGRESS_3,  SAVE_PROGRESS_4,
                                                   SAVE_PROGRESS_4,  SAVE_PROGRESS_5,  SAVE_PROGRESS_6,  SAVE_PROGRESS_25, SAVE_PROGRESS_27, SAVE_PROGRESS_28, SAVE_PROGRESS_29,
                                                   SAVE_PROGRESS_30, SAVE_PROGRESS_31, SAVE_PROGRESS_33, SAVE_PROGRESS_34, SAVE_PROGRESS_35, SAVE_PROGRESS_35, SAVE_PROGRESS_36,
                                                   SAVE_PROGRESS_37, SAVE_PROGRESS_38, SAVE_PROGRESS_39 };

const CHEVObjectType gSeaMapObjectTypeList[SEAMAPOBJECT_COUNT] = {
    [SEAMAPOBJECT_ISLAND_DRAW_ICON] =
    {
        .animID        = SEAMAP_CHCOM_ANI_42,
        .palette       = PALETTE_ROW_4,
        .viewBounds    = { 16, 16 },
        .createFunc    = SeaMapIslandDrawIcon__Create,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_UNUSED] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 0, 0 },
        .createFunc    = 0,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_ISLAND_ICON_1] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 64, 64 },
        .createFunc    = SeaMapIslandIcon__Create,
        .viewCheckFunc = SeaMapIslandIcon__ViewCheck,
    },

    [SEAMAPOBJECT_ISLAND_ICON_2] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 64, 64 },
        .createFunc    = SeaMapIslandIcon__Create,
        .viewCheckFunc = SeaMapIslandIcon__ViewCheck,
    },

    [SEAMAPOBJECT_JOHNNY_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 16, 16 },
        .createFunc    = CreateSeaMapJohnnyIcon,
        .viewCheckFunc = SeaMapJohnnyIcon_ViewCheck,
    },

    [SEAMAPOBJECT_UNKNOWN] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_0,
        .viewBounds    = { 16, 16 },
        .createFunc    = CreateSeaMapUnknown5,
        .viewCheckFunc = SeaMapUnknown5_ViewCheck,
    },

    [SEAMAPOBJECT_CORAL_CAVE_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_128,
        .palette       = PALETTE_ROW_8,
        .viewBounds    = { 28, 36 },
        .createFunc    = CreateSeaMapCoralCaveIcon,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_SKY_BABYLON_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_130,
        .palette       = PALETTE_ROW_9,
        .viewBounds    = { 28, 36 },
        .createFunc    = CreateSeaMapSkyBabylonIcon,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_TARGET_FLAG_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_139,
        .palette       = PALETTE_ROW_4,
        .viewBounds    = { 32, 32 },
        .createFunc    = CreateSeaMapTargetFlagIcon,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_BOAT_ICON] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_14,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapBoatIcon,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_STYLUS_PROMPT] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_14,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapStylusIcon,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_DS_POPUP] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_2,
        .viewBounds    = { 0, 0 },
        .createFunc    = CreateSeaMapDSPopup,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_SPARKLES_1] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_5,
        .viewBounds    = { 0, 0 },
        .createFunc    = SeaMapSparkles__Create,
        .viewCheckFunc = NULL,
    },

    [SEAMAPOBJECT_SPARKLES_2] = 
    {
        .animID        = SEAMAP_CHCOM_ANI_0,
        .palette       = PALETTE_ROW_5,
        .viewBounds    = { 0, 0 },
        .createFunc    = SeaMapSparkles__Create,
        .viewCheckFunc = NULL,
    },
};

// --------------------
// FUNCTION DECLS
// --------------------

extern void SeaMapCoralCaveIcon_State_BeginAppearing(SeaMapCoralCaveIcon *work);

// --------------------
// FUNCTIONS
// --------------------

BOOL SeaMapEventManager__CheckFeatureUnlocked(u32 id)
{
    switch (id)
    {
        default:
            return SeaMapManager__GetSaveFlag(sIslandFeatureUnlockList[id]);

        case 0:
            return TRUE;

        case 1:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_3;

        case 3:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_14;

        case 6:
            return SaveGame__GetZone6Progress() >= SAVE_ZONE6_PROGRESS_4;

        case 8:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_35;
    }
}

void SeaMapEventManager__Create(void)
{
    Task *task = TaskCreate(SeaMapEventManager_Main, SeaMapEventManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x110, TASK_GROUP(0), SeaMapEventManager);
    gSeaMapEventManagerTaskSingleton = task;

    SeaMapEventManager *work = TaskGetWork(task, SeaMapEventManager);
    TaskInitWork16(work);

    SeaMapEventManager__Func_2046A78();

    for (s32 i = 0; i < 16; i++)
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

void SeaMapEventManager__Destroy(void)
{
    if (gSeaMapEventManagerTaskSingleton == NULL)
        return;

    DestroyTaskGroup(TASK_GROUP(1));
    DestroyTask(gSeaMapEventManagerTaskSingleton);
}

SeaMapObject *SeaMapEventManager__CreateObject(s32 type, s16 x, s16 y, u8 flags, HitboxRect *box, s16 unlockID)
{
    SeaMapEventManager *work         = SeaMapEventManager__GetWork();
    const CHEVObjectType *objectType = &gSeaMapObjectTypeList[type];

    CHEVObject *mapObject = NULL;
    s32 i                 = 0;
    for (; i < 16; i++)
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
    mapObject->flags1     = 0x80;
    mapObject->flags2     = flags;
    if (box)
        MI_CpuCopy16(box, &mapObject->box, sizeof(mapObject->box));
    mapObject->unlockID = unlockID;
    return objectType->createFunc(objectType, mapObject);
}

SeaMapEventManager *SeaMapEventManager__GetWork2(void)
{
    return SeaMapEventManager__GetWork();
}

void SeaMapEventManager__Func_2046A78(void)
{
    SeaMapEventManager *work = SeaMapEventManager__GetWork2();

    work->lastTouchedIconType = -1;
    work->lastTouchedIcon     = 0;
}

void SeaMapEventManager__Func_2046A94(void *a1)
{
    // TODO: what is this type?
    SetSpriteButtonState((SpriteButtonAnimator *)((u8 *)a1 + 16), SPRITE_BUTTON_STATE_IDLE);
}

CHEVObject *SeaMapEventManager__GetObjectFromID(u32 id)
{
    CHEV *layout = SeaMapManager__GetWork()->assets.objectLayout;

    CHEVObject *mapObjectList = layout->entries;
    u16 *indexCount           = (u16 *)&layout->entries[layout->count];
    for (u16 i = 0; i < *indexCount; i++)
    {
        CHEVObject *mapObject = &mapObjectList[indexCount[i + 1]];

        if (mapObject->unlockID == id)
            return mapObject;
    }

    return NULL;
}

void SeaMapEventManager__FindVisibleIslands(fx32 shipX, fx32 shipY, fx32 distanceThreshold, SeaMapVoyageVisibleIsland *islandList, u16 *islandCount)
{
    CHEV *layout = SeaMapManager__GetWork()->assets.objectLayout;

    *islandCount              = 0;
    CHEVObject *mapObjectList = layout->entries;
    u16 *indexCount           = (u16 *)&layout->entries[layout->count];
    for (u16 i = 0; i < *indexCount; i++)
    {
        CHEVObject *mapObject = &mapObjectList[indexCount[i + 1]];

        switch (mapObject->unlockID)
        {
            case 3:
                if (SeaMapManager__GetSaveFlag(3) == FALSE)
                    continue;
                break;

            case 6:
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
            fx32 x = MultiplyFX(localX, 0xF5E);
            fx32 y = MultiplyFX(localY, 0x65D);
            radius = x + y;
        }
        else
        {
            fx32 y = MultiplyFX(localY, 0xF5E);
            fx32 x = MultiplyFX(localX, 0x65D);
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

u32 SeaMapEventManager__GetObjectType(CHEVObject *mapObject)
{
    return mapObject->type & ~SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

BOOL SeaMapEventManager__ObjectIsActive(CHEVObject *mapObject)
{
    return (mapObject->type & SEAMAPOBJECT_TYPE_MASK_ACTIVE) == 0;
}

u32 SeaMapEventManager__Func_2046CE8(s16 id)
{
    switch (id)
    {
        default:
        case 0:
            return 0;

        case 1:
            return 1;

        case 2:
            return 2;

        case 3:
            return 3;

        case 4:
            return 4;

        case 5:
            return 5;

        case 6:
            return 6;

        case 7:
            return 7;

        case 8:
            return 8;

        case 9:
            return 9;

        case 10:
            return 10;

        case 11:
            return 11;

        case 12:
            return 12;

        case 13:
            return 13;

        case 14:
            return 14;

        case 15:
            return 15;

        case 16:
            return 16;

        case 17:
            return 17;

        case 18:
            return 18;

        case 19:
            return 19;

        case 20:
            return 20;

        case 21:
            return 21;

        case 22:
            return 22;

        case 23:
            return 23;

        case 24:
            return 24;

        case 25:
            return 25;

        case 26:
            return 26;

        case 27:
            return 27;

        case 28:
            return 28;

        case 29:
            return 29;

        case 30:
            return 30;

        case 31:
            return 31;

        case 32:
            return 32;

        case 33:
            return 33;

        case 34:
            return 34;

        case 35:
            return 35;

        case 36:
            return 36;

        case 37:
            return 37;

        case 38:
            return 38;

        case 39:
            return 39;

        case 40:
            return 40;

        case 41:
            return 41;
    }
}

u32 SeaMapEventManager__Func_2046EEC(u32 id)
{
    switch (id)
    {
        default:
        case 0:
            return 0;

        case 1:
            return 1;

        case 2:
            return 2;

        case 3:
            return 3;

        case 4:
            return 4;

        case 5:
            return 5;

        case 6:
            return 6;

        case 7:
            return 7;

        case 8:
            return 8;

        case 9:
            return 9;

        case 10:
            return 10;

        case 11:
            return 11;

        case 12:
            return 12;

        case 13:
            return 13;

        case 14:
            return 14;

        case 15:
            return 15;

        case 16:
            return 16;

        case 17:
            return 17;

        case 22:
            return 22;

        case 23:
            return 23;

        case 24:
            return 24;

        case 25:
            return 25;

        case 26:
            return 26;

        case 27:
            return 27;

        case 28:
            return 28;

        case 29:
            return 29;

        case 30:
            return 30;

        case 31:
            return 31;

        case 32:
            return 32;
    }
}

void SeaMapEventManager__SetBoatFlipX(SeaMapBoatIcon *boat, BOOL enabled)
{
    if (enabled)
        boat->aniBoat.flags &= ~ANIMATOR_FLAG_FLIP_X;
    else
        boat->aniBoat.flags |= ANIMATOR_FLAG_FLIP_X;
}

SeaMapObject *SeaMapEventManager__CreateStylusIcon(fx32 startX, fx32 startY, fx32 endX, fx32 endY, s16 speed)
{
    SeaMapStylusIcon *icon = (SeaMapStylusIcon *)SeaMapEventManager__CreateObject(SEAMAPOBJECT_STYLUS_PROMPT, 0, 0, 0, NULL, 0);
    icon->startPos.x       = startX;
    icon->startPos.y       = startY;
    icon->endPos.x         = endX;
    icon->endPos.y         = endY;
    icon->speed            = speed;

    return &icon->objWork;
}

void SeaMapEventManager__DestroyStylusIcon(SeaMapObject *work)
{
    if (work->task != NULL)
    {
        DestroyTask(work->task);
        work->task = NULL;
    }
}

void SeaMapEventManager__CreateDSPopup(void)
{
    if (SeaMapEventManager__GetWork()->dsPopup == NULL)
        SeaMapEventManager__CreateObject(SEAMAPOBJECT_DS_POPUP, HW_LCD_CENTER_X, HW_LCD_CENTER_Y, 0, NULL, 0);
}

void SeaMapEventManager__DestroyDSPopup(void)
{
    if (SeaMapEventManager__GetWork()->dsPopup != NULL)
        DestroyTask(SeaMapEventManager__GetWork()->dsPopup);
}

void SeaMapEventManager__UnlockCoralCave(void)
{
    if (SeaMapEventManager__GetWork()->coralCaveIcon == NULL)
        return;

    SeaMapCoralCaveIcon *icon = TaskGetWork(SeaMapEventManager__GetWork()->coralCaveIcon, SeaMapCoralCaveIcon);
    icon->state               = SeaMapCoralCaveIcon_State_BeginAppearing;
}

void SeaMapEventManager__UnlockSkyBabylon(void)
{
    if (SeaMapEventManager__GetWork()->skyBabylonIcon == NULL)
        return;

    SeaMapSkyBabylonIcon *icon = TaskGetWork(SeaMapEventManager__GetWork()->skyBabylonIcon, SeaMapSkyBabylonIcon);
    icon->state                = SeaMapSkyBabylonIcon_State_BeginAppear;
}

NONMATCH_FUNC void SeaMapEventManager__Func_20471B8(AnimatorSprite *animator, SpriteFrameCallback callback, void *userData)
{
    // https://decomp.me/scratch/wzkRm -> 81.82%
#ifdef NON_MATCHING
    u16 new_var3;
    u16 count = 1 + RenderCore_GetTargetVBlankCount();

    u16 i    = count - 1;
    new_var3 = i;
    while (new_var3)
    {
        new_var3 = i;
        AnimatorSprite__ProcessAnimation(animator, callback, userData);
        i--;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl RenderCore_GetTargetVBlankCount
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_020471E8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	sub r0, r7, #1
	mov r0, r0, lsl #0x10
	cmp r7, #0
	mov r7, r0, lsr #0x10
	bne _020471E8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

BOOL SeaMapEventManager__IslandEnabled(u32 id)
{
    s32 progress = sIslandProgressUnlockList[id];

    switch (id)
    {
        default:
            return progress <= SaveGame__GetGameProgress();

        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_7:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_8:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_9:
            return progress <= SaveGame__GetZone5Progress();

        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_10:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_11:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_12:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_13:
        case CH_ISLANDDRAWICON_UNKNOWN_HIDDEN_ISLAND_14:
            return progress <= SaveGame__GetZone6Progress();
    }
}

SeaMapEventManager *SeaMapEventManager__GetWork(void)
{
    return TaskGetWork(gSeaMapEventManagerTaskSingleton, SeaMapEventManager);
}

void SeaMapEventManager_SpawnInitialObjects(void)
{
    CHEV *layout = SeaMapManager__GetWork()->assets.objectLayout;

    for (u16 i = 0; i < layout->count; i++)
    {
        CHEVObject *mapObject = &layout->entries[i];

        if (SeaMapEventManager__ObjectIsActive(mapObject))
        {
            const CHEVObjectType *objectType = &gSeaMapObjectTypeList[mapObject->type];

            if ((mapObject->flags1 & 1) != 0)
                objectType->createFunc(objectType, &layout->entries[i]);
        }
    }
}

NONMATCH_FUNC void SeaMapEventManager_Main(void)
{
    // https://decomp.me/scratch/Cn2jV -> 98.88% minor register mismatches
#ifdef NON_MATCHING
    SeaMapEventManager *work;
    CHEV *layout;
    u16 i;
    CHEVObject *mapObject;
    const CHEVObjectType *objectType;

    work = TaskGetWorkCurrent(SeaMapEventManager);

    layout = SeaMapManager__GetWork()->assets.objectLayout;

    for (i = 0; i < layout->count; i++)
    {
        mapObject = &layout->entries[i];

        if (SeaMapEventManager__ObjectIsActive(mapObject))
        {
            objectType = &gSeaMapObjectTypeList[mapObject->type];

            if (SeaMapEventManager__ObjectInBounds(&mapObject->position, objectType->viewBounds))
                objectType->createFunc(objectType, &layout->entries[i]);
        }
    }

    SeaMapEventManager__Func_20471B8(&work->aniTargetFlag, NULL, NULL);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r11, r0
	bl SeaMapManager__GetWork
	ldr r7, [r0, #0x160]
	mov r8, #0
	ldrh r0, [r7, #0]
	cmp r0, #0
	bls _020473A8
	ldr r5, =gSeaMapObjectTypeList
	add r6, r7, #2
	mov r4, #0x12
_02047350:
	mla r9, r8, r4, r6
	mov r0, r9
	bl SeaMapEventManager__ObjectIsActive
	cmp r0, #0
	beq _02047390
	ldrh r1, [r9, #0]
	add r0, r9, #2
	add r10, r5, r1, lsl #4
	add r1, r10, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	beq _02047390
	ldr r2, [r10, #8]
	mov r0, r10
	mov r1, r9
	blx r2
_02047390:
	ldrh r1, [r7, #0]
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02047350
_020473A8:
	mov r1, #0
	mov r2, r1
	add r0, r11, #0x1f0
	bl SeaMapEventManager__Func_20471B8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SeaMapEventManager_Destructor(Task *task)
{
    SeaMapEventManager *work = TaskGetWork(task, SeaMapEventManager);

    AnimatorSprite__Release(&work->aniJohnny);
    AnimatorSprite__Release(&work->aniJohnnyDefeated);
    AnimatorSprite__Release(&work->aniTargetFlag);

    gSeaMapEventManagerTaskSingleton = NULL;
}

void SeaMapEventManager__InitMapObject(SeaMapObject *work, Task *task, const CHEVObjectType *objectType, CHEVObject *mapObject)
{
    work->task       = task;
    work->objectType = objectType;
    work->mapObject  = mapObject;
    work->position.x = mapObject->position.x;
    work->position.y = mapObject->position.y;
}

void SeaMapEventManager__DestroyObject(SeaMapObject *work)
{
    CHEVObject *mapObject = work->mapObject;

    if ((mapObject->flags1 & 0x80) != 0)
        mapObject->type = SEAMAPOBJECT_DESTROYED;
}

NONMATCH_FUNC BOOL SeaMapEventManager__ObjectInBounds(Vec2Fx16 *objPos, const s8 *viewBounds)
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

void SeaMapEventManager__Func_20474FC(Vec2Fx16 *pos1, Vec2Fx16 *pos2)
{
    fx32 zoomScale = SeaMapManager__GetZoomOutScale();

    pos2->x = FX32_TO_WHOLE(zoomScale * (pos1->x - FX32_TO_WHOLE(SeaMapManager__GetXPos())));
    pos2->y = FX32_TO_WHOLE(zoomScale * (pos1->y - FX32_TO_WHOLE(SeaMapManager__GetYPos())));
}

void SeaMapEventManager__SetObjectAsActive(SeaMapObject *work)
{
    work->mapObject->type |= SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

void SeaMapEventManager__SetObjectAsInactive(SeaMapObject *work)
{
    work->mapObject->type &= ~SEAMAPOBJECT_TYPE_MASK_ACTIVE;
}

BOOL SeaMapEventManager__Func_204756C(CHEVObject *mapObject)
{
    u16 y;
    u16 x;

    SeaMapManager__Func_2043A80(FX32_FROM_WHOLE(mapObject->position.x), FX32_FROM_WHOLE(mapObject->position.y), &x, &y);
    return SeaMapManager__GetMapPixel(x, y) == 0;
}

void SeaMapEventManager__GetViewRect2(HitboxRect *rect, fx32 x, fx32 y, s32 *startX, s32 *startY, s32 *width, s32 *height)
{
    *width  = ((rect->right - rect->left) << (FX32_SHIFT - 1));
    *height = ((rect->bottom - rect->top) << (FX32_SHIFT - 1));
    *startX = FX32_FROM_WHOLE(x + ((rect->left + rect->right) >> 1));
    *startY = FX32_FROM_WHOLE(y + ((rect->top + rect->bottom) >> 1));
}

void SeaMapEventManager__GetViewRect(HitboxRect *rect, fx32 x, fx32 y, ViewRect *viewRect)
{
    viewRect->left   = FX32_FROM_WHOLE(x + rect->left);
    viewRect->top    = FX32_FROM_WHOLE(y + rect->top);
    viewRect->right  = FX32_FROM_WHOLE(x + rect->right);
    viewRect->bottom = FX32_FROM_WHOLE(y + rect->bottom);
}

BOOL SeaMapEventManager__PointInViewRect2(s32 startX, s32 startY, s32 width, s32 height, fx32 x, fx32 y)
{
    fx32 distX1  = x - startX;
    fx32 radiusX = MATH_ABS(distX1);

    fx32 distY1  = y - startY;
    fx32 radiusY = MATH_ABS(distY1);

    if (radiusX >= radiusY)
        radiusY = radiusX;

    if (radiusY > width && radiusY > height)
        return FALSE;

    return FX_Div(MultiplyFX(distX1, distX1), MultiplyFX(width, width)) + FX_Div(MultiplyFX(distY1, distY1), MultiplyFX(height, height)) <= FLOAT_TO_FX32(1.0);
}

BOOL SeaMapEventManager__PointInViewRect(s32 left, s32 top, s32 right, s32 bottom, fx32 x, fx32 y)
{
    return left <= x && x <= right && top <= y && y <= bottom;
}

BOOL SeaMapEventManager__ViewRectCheck(CHEVObject *mapObject, fx32 x, fx32 y)
{
    ViewRect viewRect;

    SeaMapEventManager__GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
    return SeaMapEventManager__PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y) != FALSE;
}

BOOL SeaMapEventManager__ViewRectCheck2(CHEVObject *mapObject, fx32 x, fx32 y)
{
    s32 startY;
    s32 startX;
    s32 height;
    s32 width;

    SeaMapEventManager__GetViewRect2(&mapObject->box, mapObject->position.x, mapObject->position.y, &startX, &startY, &width, &height);
    return SeaMapEventManager__PointInViewRect2(startX, startY, width, height, x, y) != FALSE;
}
