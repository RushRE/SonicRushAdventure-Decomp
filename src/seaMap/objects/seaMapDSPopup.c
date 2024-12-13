#include <seaMap/objects/seaMapDSPopup.h>
#include <seaMap/seaMapManager.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/util/spriteButton.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapDSPopup_Main(void);
static void SeaMapDSPopup_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapDSPopup(CHEVObjectType *objectType, CHEVObject *mapObject)
{
    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task = TaskCreate(SeaMapDSPopup_Main, SeaMapDSPopup_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapDSPopup);
    SeaMapEventManager__GetWork()->dsPopup = task;

    SeaMapDSPopup *work = TaskGetWork(task, SeaMapDSPopup);
    TaskInitWork16(work);

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);
    work->timer = 384;

    AnimatorSprite__Init(&work->aniSprite, GetSpriteButtonTouchpadSprite(), objectType->animID, ANIMATOR_FLAG_DISABLE_LOOPING, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(GetSpriteButtonTouchpadSprite(), objectType->animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);

    work->aniSprite.pos.x   = mapObject->position.x;
    work->aniSprite.pos.y   = mapObject->position.y;
    work->aniSprite.palette = objectType->palette;
    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapDSPopup_Main(void)
{
    SeaMapDSPopup *work = TaskGetWorkCurrent(SeaMapDSPopup);

    if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags))
        work->timer = 0;

    if (work->timer == 379)
        PlaySystemSfx(SND_SYS_SEQARC_ARC_CHART, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ERIAL_SPIN);

    if (work->timer-- != 0)
    {
        SeaMapEventManager__Func_20471B8(&work->aniSprite, 0, 0);
        AnimatorSprite__DrawFrame(&work->aniSprite);
    }
    else
    {
        DestroyCurrentTask();
    }
}

void SeaMapDSPopup_Destructor(Task *task)
{
    SeaMapDSPopup *work = TaskGetWork(task, SeaMapDSPopup);

    NNS_SndPlayerStopSeqBySeqArcIdx(SND_SYS_SEQARC_ARC_CHART, SND_SYS_SEQARC_ARC_CHART_SEQ_SE_C_DS, 0);

    AnimatorSprite__Release(&work->aniSprite);
    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);

    if (SeaMapEventManager__Singleton != NULL)
        SeaMapEventManager__GetWork()->dsPopup = NULL;
}