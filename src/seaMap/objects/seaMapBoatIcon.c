#include <seaMap/objects/seaMapBoatIcon.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapBoatIcon_Main(void);
static void SeaMapBoatIcon_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapBoatIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapBoatIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task = TaskCreate(SeaMapBoatIcon_Main, SeaMapBoatIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapBoatIcon);

    work = TaskGetWork(task, SeaMapBoatIcon);
    TaskInitWork16(work);

    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);

    u16 shipAnimIDs[SHIP_COUNT_DRILL] = {
        [SHIP_JET]       = SEAMAP_CHCOM_ANI_0, // Jetski animation
        [SHIP_BOAT]      = SEAMAP_CHCOM_ANI_1, // Sailboat animation
        [SHIP_HOVER]     = SEAMAP_CHCOM_ANI_2, // Hovercraft animation
        [SHIP_SUBMARINE] = SEAMAP_CHCOM_ANI_3, // Submarine animation
        [SHIP_MENU]      = SEAMAP_CHCOM_ANI_0  // Menu ship animation
    };

    s32 shipType = SeaMapManager__GetWork()->shipType;
    if (shipType >= SHIP_MENU)
        shipType = mapObject->id;
    u16 animID = shipAnimIDs[shipType];

    // Init island sprite
    AnimatorSprite__Init(&work->aniBoat, manager->assets.sprChCommon, animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_7);

    work->aniBoat.pos.x          = mapObject->position.x;
    work->aniBoat.pos.y          = mapObject->position.y;
    work->aniBoat.cParam.palette = objectType->palette;

    AnimatorSprite__ProcessAnimationFast(&work->aniBoat);

    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapBoatIcon_Main(void)
{
    SeaMapBoatIcon *work = TaskGetWorkCurrent(SeaMapBoatIcon);

    SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &work->aniBoat.pos);
    AnimatorSprite__DrawFrame(&work->aniBoat);
}

void SeaMapBoatIcon_Destructor(Task *task)
{
    SeaMapBoatIcon *work = TaskGetWork(task, SeaMapBoatIcon);

    AnimatorSprite__Release(&work->aniBoat);

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}
