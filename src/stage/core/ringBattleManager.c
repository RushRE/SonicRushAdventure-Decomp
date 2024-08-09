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

NONMATCH_FUNC void HandleRingBattleManagerButtons(RingBattleManager *work)
{
    // https://decomp.me/scratch/7wg4v -> 93.21%
#ifdef NON_MATCHING
    if (work->buttonActivateDelay > 0)
    {
        work->buttonActivateDelay--;
        return;
    }

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
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, r0
	ldr r0, [r7, #8]
	cmp r0, #0
	bne _02187394
	subs r0, r0, #1
	str r0, [r7, #8]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02187394:
	ldrh r3, [r7, #0x10]
	mov r2, #0
	cmp r3, #0
	ble _021873D0
	ldr r1, =RingButtonSfxManager__timerTable
_021873A8:
	add r0, r7, r2, lsl #2
	ldr r0, [r0, #0x1c]
	ldr r0, [r0, #0x340]
	ldrsb r0, [r0, #6]
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r2, r2, #1
	cmp r2, r3
	blt _021873A8
_021873D0:
	ldr r0, [r7, #0xc]
	add r0, r0, #1
	str r0, [r7, #0xc]
	cmp r0, #0x3c
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r6, #0
	mov r4, r6
	ldr r5, =RingButtonSfxManager__timerTable
	ldr r8, =0x00196225
	ldr r9, =0x3C6EF35F
	b _0218744C
_021873FC:
	ldr r0, [r7]
	mla r1, r0, r8, r9
	mov r0, r1, lsr #0x10
	str r1, [r7]
	mov r0, r0, lsl #0x10
	ldrh r1, [r7, #0x10]
	mov r0, r0, lsr #0x10
	bl FX_ModS32
	mov r0, r0, lsl #0x10
	add r0, r7, r0, lsr #14
	ldr r0, [r0, #0x1c]
	ldr r0, [r0, #0x340]
	ldrsb r1, [r0, #6]
	ldr r0, [r5, r1, lsl #2]
	cmp r0, #0
	beq _0218744C
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	str r4, [r5, r1, lsl #2]
	mov r6, r0, lsr #0x10
_0218744C:
	ldrh r0, [r7, #0x14]
	cmp r6, r0
	ldrloh r0, [r7, #0x10]
	cmplo r6, r0
	blo _021873FC
	ldr r3, [r7]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	add r2, r7, #0x100
	mla r0, r3, r0, r1
	str r0, [r7]
	mov r0, r0, lsr #0x10
	ldrh r2, [r2, #0x1c]
	mov r0, r0, lsl #0x10
	mov r1, #0
	and r0, r2, r0, lsr #16
	mov r0, r0, lsl #8
	add r0, r0, #0x12c
	str r0, [r7, #8]
	str r1, [r7, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
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
            work->itemBoxList[itemBoxID]->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_2;

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
