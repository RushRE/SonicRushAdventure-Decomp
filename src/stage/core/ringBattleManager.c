#include <stage/core/ringBattleManager.h>
#include <stage/core/ringManager.h>
#include <stage/objects/ringButtonSfxManager.h>

// --------------------
// VARIABLES
// --------------------

static Task *ringBattleManagerTask;

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_left mapObject->left
#define mapObjectParam_top mapObject->top
#define mapObjectParam_height mapObject->height

// --------------------
// FUNCTION DECLS
// --------------------

static void RingBattleManager_Destructor(Task *task);
static void RingBattleManager_Main(void);
static void HandleRingBattleManagerButtons(RingBattleManager *work);
static void HandleRingBattleManagerItemBoxes(RingBattleManager *work);
static void CreateRingsForRingSwitch(fx32 x, fx32 y, s32 type);

// --------------------
// INLINE FUNCTIONS
// --------------------

#define ADVANCE_RINGBATTLE_RAND_SEED(seed) 1663525 * (s32)(seed) + 1013904223

RUSH_INLINE u16 GetRingBattleRand(u32 *seed)
{
    *seed = (u32)ADVANCE_RINGBATTLE_RAND_SEED(*seed);
    return (u16)(*seed >> 16);
}

// --------------------
// FUNCTIONS
// --------------------

void CreateRingBattleManager(void)
{
    if (ringBattleManagerTask != NULL)
        return;

    Task *task = TaskCreate(RingBattleManager_Main, RingBattleManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFFF, TASK_SCOPE_3, RingBattleManager);
    if (task == HeapNull)
        return;

    ringBattleManagerTask = task;

    RingBattleManager *work = TaskGetWork(task, RingBattleManager);
    TaskInitWork8(work);

    work->ringButtonRandSeed   = _mt_math_rand;
    work->itemBoxRandSeed      = ADVANCE_RINGBATTLE_RAND_SEED(_mt_math_rand);
    work->activateButtonCount  = 1;
    work->activateItemBoxCount = 1;
    work->inactiveItemBoxCount = 1;
    work->buttonActivateDelay  = 1;
}

void AddButtonToRingBattleManager(RingButton *button)
{
    RingBattleManager *work = TaskGetWork(ringBattleManagerTask, RingBattleManager);

    if (work->ringButtonCount < RINGBATTLEMANAGER_ITEM_LIST_SIZE)
    {
        if (button != NULL)
        {
            work->ringButtonList[work->ringButtonCount] = button;
            work->ringButtonCount++;
        }
    }
}

void AddItemBoxToRingBattleManager(ItemBox *itemBox)
{
    RingBattleManager *work = TaskGetWork(ringBattleManagerTask, RingBattleManager);

    if (work->itemBoxCount < RINGBATTLEMANAGER_ITEM_LIST_SIZE)
    {
        if (itemBox != NULL)
        {
            work->itemBoxList[work->itemBoxCount] = itemBox;
            work->itemBoxCount++;
        }
    }
}

void RingBattleManager_OnButtonActivated(RingButton *button)
{
    RingBattleManager *manager = TaskGetWork(ringBattleManagerTask, RingBattleManager);

    s32 type;
    if (button->gameWork.mapObject->id == MAPOBJECT_256)
    {
        if ((button->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            type = 3;
        else
            type = 1;
    }
    else
    {
        if ((button->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            type = 2;
        else
            type = 0;
    }

    CreateRingsForRingSwitch(button->gameWork.objWork.position.x, button->gameWork.objWork.position.y, type);
    HandleRingBattleManagerItemBoxes(manager);
}

GameObjectTask *CreateRingBattleManagerObject(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (ringBattleManagerTask != NULL)
    {
        RingBattleManager *work = TaskGetWork(ringBattleManagerTask, RingBattleManager);

        work->activateButtonCount = mapObjectParam_left;
        if (work->activateButtonCount < 1)
            work->activateButtonCount = 1;

        work->activateItemBoxCount = mapObjectParam_top;
        if (work->activateItemBoxCount < 1)
            work->activateItemBoxCount = 1;

        work->inactiveItemBoxCount = mapObjectParam_height;
        if (work->inactiveItemBoxCount < 1)
            work->inactiveItemBoxCount = 1;

        work->buttonActivateDelayOffset = mapObject->flags & 7;
    }

    DestroyMapObject(mapObject);

    return NULL;
}

void RingBattleManager_Destructor(Task *task)
{
    ringBattleManagerTask = NULL;
}

void RingBattleManager_Main(void)
{
    RingBattleManager *work = TaskGetWorkCurrent(RingBattleManager);

    HandleRingBattleManagerButtons(work);
}

void HandleRingBattleManagerButtons(RingBattleManager *work)
{
    if (work->buttonActivateDelay != 0 || --work->buttonActivateDelay == 0)
    {
        for (s32 i = 0; i < work->ringButtonCount; i++)
        {
            if (RingButtonSfxManager__timerTable[work->ringButtonList[i]->gameWork.RingButton_mapObjectParam_id] == 0)
            {
                return;
            }
        }

        work->timer++;
        if (work->timer >= 60)
        {
            u16 id = 0;
            while (id < work->activateButtonCount && id < work->ringButtonCount)
            {
                u16 buttonID = work->ringButtonList[(u16)FX_ModS32(GetRingBattleRand(&work->ringButtonRandSeed), work->ringButtonCount)]->gameWork.RingButton_mapObjectParam_id;
                if (RingButtonSfxManager__timerTable[buttonID] != 0)
                {
                    RingButtonSfxManager__timerTable[buttonID] = 0;
                    id++;
                }
            }

            work->buttonActivateDelay = ((work->buttonActivateDelayOffset & GetRingBattleRand(&work->ringButtonRandSeed)) << 8) + 300;
            work->timer               = 0;
        }
    }
}

void HandleRingBattleManagerItemBoxes(RingBattleManager *work)
{
    s32 i            = 0;
    u16 itemBoxCount = 0;
    u16 itemBoxList[RINGBATTLEMANAGER_ITEM_LIST_SIZE];

    for (; i < work->itemBoxCount; i++)
    {
        if ((work->itemBoxList[i]->gameWork.objWork.displayFlag & DISPLAY_FLAG_NO_DRAW) != 0)
        {
            itemBoxList[itemBoxCount] = i;
            itemBoxCount++;
        }
    }

    u16 inactiveItemBoxCount = work->itemBoxCount - itemBoxCount;
    u16 id                   = 0;
    while (id < work->activateItemBoxCount && id < itemBoxCount && inactiveItemBoxCount < work->inactiveItemBoxCount)
    {
        u16 itemBoxID = itemBoxList[(u16)FX_ModS32(GetRingBattleRand(&work->itemBoxRandSeed), itemBoxCount)];

        if ((work->itemBoxList[itemBoxID]->gameWork.objWork.displayFlag & DISPLAY_FLAG_NO_DRAW) != 0)
        {
            work->itemBoxList[itemBoxID]->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            work->itemBoxList[itemBoxID]->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;

            inactiveItemBoxCount++;
            id++;
        }
    }
}

void CreateRingsForRingSwitch(fx32 x, fx32 y, s32 type)
{
    static fx32 velocityTable[] = { FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(3.5), FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(1.0) };

    s32 i;

    u16 angle = -FLOAT_DEG_TO_IDX(101.25);
    angle += (FX32_FROM_WHOLE(type) << 2);

    for (i = 0; i < 5; i++)
    {
        Ring *ring  = CreateSpillRing(x, y, 0, (velocityTable[type] >> 6) * (SinFX((s32)angle) >> 6), (velocityTable[type] >> 6) * (CosFX((s32)angle) >> 6), RING_FLAG_USE_PLANE_B);
        ring->timer = 236;
        angle += FLOAT_DEG_TO_IDX(5.625);
    }
}
