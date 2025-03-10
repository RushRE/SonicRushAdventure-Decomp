#include <sail/sailVoyageManager.h>
#include <sail/sailManager.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapEventTrigger.h>
#include <sail/sailPlayer.h>
#include <sail/sailCommonObjects.h>
#include <game/object/obj.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _ull_mul(void);

// --------------------
// TEMP
// --------------------

const u32 shipStepTable[SHIP_COUNT] = {
    [SHIP_JET] = FLOAT_TO_FX32(4.0), [SHIP_BOAT] = FLOAT_TO_FX32(14.0), [SHIP_HOVER] = FLOAT_TO_FX32(8.0), [SHIP_SUBMARINE] = FLOAT_TO_FX32(6.0)
};

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

SailVoyageManager *SailVoyageManager__Create(void)
{
    SailManager *manager = SailManager__GetWork();

    GameState *state = GetGameState();

    Task *task = TaskCreate(SailVoyageManager__Main, SailVoyageManager__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_END - 1, TASK_GROUP(4), SailVoyageManager);

    SailVoyageManager *work = TaskGetWork(task, SailVoyageManager);
    TaskInitWork16(work);

    if (manager->isRivalRace != 0)
        work->segmentList = HeapAllocHead(HEAP_USER, SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE * sizeof(SailVoyageSegment));
    else
        work->segmentList = HeapAllocHead(HEAP_SYSTEM, SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE * sizeof(SailVoyageSegment));

    MI_CpuClear16(work->segmentList, SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE * sizeof(SailVoyageSegment));

    if (SailManager__GetShipType() == SHIP_BOAT)
        work->targetSeaAngle = FLOAT_DEG_TO_IDX(84.375);

    if (manager->isRivalRace != 0 || manager->missionType != 0)
        return work;

    if (state->seaMapNodeList.nodes.numObjects != 0)
    {
        SeaMapManager__Func_2045BF8(work->unknownDistance, &work->targetUnknownX, &work->targetUnknownZ);
        work->unknownX = work->targetUnknownX;
        work->unknownZ = work->targetUnknownZ;
    }

    return work;
}

void SailVoyageManager__Destructor(Task *task)
{
    SailManager *manager = SailManager__GetWork();

    SailVoyageManager *work = TaskGetWork(task, SailVoyageManager);

    if (work->segmentList != NULL)
    {
        if (manager->isRivalRace)
            HeapFree(HEAP_USER, work->segmentList);
        else
            HeapFree(HEAP_SYSTEM, work->segmentList);
    }

    work->segmentList = NULL;
}

NONMATCH_FUNC void SailVoyageManager__Func_21574B4(SailVoyageManager *work)
{
    // https://decomp.me/scratch/YfV9t -> 94.56%
#ifdef NON_MATCHING
    SailManager *manager = SailManager__GetWork();

    fx32 currentDistance = FLOAT_TO_FX32(0.0);
    fx32 shipMove        = shipStepTable[SailManager__GetShipType()];

    work->totalDistance = SeaMapManager__GetTotalDistance();
    if (manager->isRivalRace == FALSE)
    {
        GameState *state = GetGameState();
        if (state->sailUnknown1 != 0)
        {
            currentDistance = state->sailUnknown1;
        }
    }

    fx32 currentX;
    fx32 currentY;
    fx32 startX;
    fx32 startY;
    SeaMapManager__Func_2045BF8(currentDistance, &startX, &startY);

    if (currentDistance + FLOAT_TO_FX32(4.0) > work->totalDistance)
        SeaMapManager__Func_2045BF8(work->totalDistance, &currentX, &currentY);
    else
        SeaMapManager__Func_2045BF8(currentDistance + FLOAT_TO_FX32(4.0), &currentX, &currentY);
    work->angle = FX_Atan2Idx(startX - currentX, startY - currentY);

    u16 id          = 0;
    work->prevAngle = work->angle;
    u16 angle       = work->angle;

    while (TRUE)
    {
        SeaMapManager__Func_2045BF8(currentDistance, &startX, &startY);

        currentDistance += shipMove;
        if (currentDistance >= work->totalDistance)
            currentDistance = work->totalDistance;

        SeaMapManager__Func_2045BF8(currentDistance, &currentX, &currentY);

        s16 angleTurn = FX_Atan2Idx(startX - currentX, startY - currentY);
        angleTurn -= angle;

        work->segmentList[id].turn = angleTurn;

        angle += work->segmentList[id].turn;

        if (work->segmentList[id].turn > FLOAT_DEG_TO_IDX(45.0))
        {
            work->segmentList[id].turn = FLOAT_DEG_TO_IDX(45.0);
        }

        if (work->segmentList[id].turn < -FLOAT_DEG_TO_IDX(45.0))
        {
            work->segmentList[id].turn = -FLOAT_DEG_TO_IDX(45.0);
        }

        if (work->totalDistance <= currentDistance)
            break;

        id++;
    }
    work->segmentCount = id;

    SailVoyageManager__Func_2157628();

    if (work->segmentCount != 0)
    {
        if (work->segmentList[work->segmentCount - 1].type < SAILVOYAGESEGMENT_TYPE_14)
        {
            work->segmentList[work->segmentCount - 1].type           = SAILVOYAGESEGMENT_TYPE_20;
            work->segmentList[work->segmentCount].type               = SAILVOYAGESEGMENT_TYPE_21;
            work->segmentList[work->segmentCount - 1].targetSeaAngle = 0;
            work->segmentList[work->segmentCount].targetSeaAngle     = 0;
        }
    }
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	bl SailManager__GetWork
	mov r6, r0
	mov r4, #0
	bl SailManager__GetShipType
	lsl r1, r0, #2
	ldr r0, =shipStepTable
	ldr r0, [r0, r1]
	str r0, [sp]
	bl SeaMapManager__GetTotalDistance
	str r0, [r5, #0x50]
	ldr r0, [r6, #0xc]
	cmp r0, #0
	bne _021574E8
	ldr r0, =gameState+0x00000080
	ldr r1, =gameState
	ldr r0, [r0, #0x28]
	cmp r0, #0
	beq _021574E8
	add r1, #0xa8
	ldr r4, [r1, #0]
_021574E8:
	mov r0, r4
	add r1, sp, #8
	add r2, sp, #4
	bl SeaMapManager__Func_2045BF8
	mov r1, #1
	lsl r1, r1, #0xe
	ldr r0, [r5, #0x50]
	add r1, r4, r1
	cmp r1, r0
	add r2, sp, #0xc
	ble _02157508
	add r1, sp, #0x10
	bl SeaMapManager__Func_2045BF8
	b _02157510
_02157508:
	mov r0, r1
	add r1, sp, #0x10
	bl SeaMapManager__Func_2045BF8
_02157510:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #4]
	sub r0, r1, r0
	ldr r1, [sp, #0xc]
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r5, #0x34]
	ldrh r0, [r5, #0x34]
	mov r6, #0
	strh r0, [r5, #0x36]
	ldrh r7, [r5, #0x34]
_0215752A:
	mov r0, r4
	add r1, sp, #8
	add r2, sp, #4
	bl SeaMapManager__Func_2045BF8
	ldr r0, [sp]
	add r4, r4, r0
	ldr r0, [r5, #0x50]
	cmp r4, r0
	blt _02157540
	mov r4, r0
_02157540:
	mov r0, r4
	add r1, sp, #0x10
	add r2, sp, #0xc
	bl SeaMapManager__Func_2045BF8
	ldr r1, [sp, #8]
	ldr r0, [sp, #0x10]
	ldr r2, [sp, #4]
	sub r0, r1, r0
	ldr r1, [sp, #0xc]
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r2, r5
	add r2, #0xc0
	mov r1, #0x28
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	ldr r2, [r2, #0]
	mul r1, r6
	sub r0, r0, r7
	add r2, r2, r1
	strh r0, [r2, #4]
	mov r0, r5
	add r0, #0xc0
	ldr r0, [r0, #0]
	add r2, r0, r1
	mov r0, #4
	ldrsh r3, [r2, r0]
	add r0, r7, r3
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	cmp r3, r0
	ble _0215758A
	strh r0, [r2, #4]
_0215758A:
	mov r0, r5
	add r0, #0xc0
	ldr r0, [r0, #0]
	add r0, r0, r1
	mov r1, #4
	ldrsh r2, [r0, r1]
	ldr r1, =0xFFFFE000
	cmp r2, r1
	bge _0215759E
	strh r1, [r0, #4]
_0215759E:
	ldr r0, [r5, #0x50]
	cmp r0, r4
	ble _021575AC
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _0215752A
_021575AC:
	mov r0, r5
	add r0, #0xb8
	strh r6, [r0]
	bl SailVoyageManager__Func_2157628
	mov r0, r5
	add r0, #0xb8
	ldrh r1, [r0, #0]
	cmp r1, #0
	beq _02157614
	mov r0, r5
	add r0, #0xc0
	ldr r3, [r0, #0]
	sub r0, r1, #1
	mov r2, #0x28
	mov r1, r0
	mul r1, r2
	ldrb r0, [r3, r1]
	cmp r0, #0xe
	bhs _02157614
	mov r0, #0x14
	strb r0, [r3, r1]
	mov r0, r5
	add r0, #0xc0
	ldr r3, [r0, #0]
	mov r0, r5
	add r0, #0xb8
	ldrh r0, [r0, #0]
	mov r4, #0x15
	mov r1, r0
	mul r1, r2
	strb r4, [r3, r1]
	mov r1, r5
	add r1, #0xc0
	ldr r4, [r1, #0]
	mov r1, r5
	add r1, #0xb8
	ldrh r1, [r1, #0]
	mov r0, #0
	sub r1, r1, #1
	mov r3, r1
	mul r3, r2
	add r1, r4, r3
	strh r0, [r1, #0xa]
	mov r1, r5
	add r1, #0xc0
	add r5, #0xb8
	ldr r3, [r1, #0]
	ldrh r1, [r5, #0]
	mul r2, r1
	add r1, r3, r2
	strh r0, [r1, #0xa]
_02157614:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailVoyageManager__Func_2157628(void)
{
    // https://decomp.me/scratch/FUsrz -> 97.20%
#ifdef NON_MATCHING
    SailManager *manager;
    SailVoyageManager *work;
    u8 unknown;
    u8 type;
    s32 denominator;
    u16 unknown4;
    fx32 distance;
    u16 id;

    manager = SailManager__GetWork();

    unknown  = 0;
    type     = 0;
    distance = -1;

    denominator = shipStepTable[SailManager__GetShipType()];

    work = SailManager__GetWork()->voyageManager;

    GameState *state = GetGameState();

    unknown4 = 0;
    id       = 0;
    if (manager->isRivalRace == FALSE && state->sailUnknown1 != 0 && state->sailUnknown4 != 0)
    {
        unknown4 = state->sailUnknown4;
        distance = state->sailUnknown1;
    }

    u32 i;
    for (i = SeaMapVoyagePathConfig_GetNodeCount(); unknown4 < i; unknown4++, i = SeaMapVoyagePathConfig_GetNodeCount())
    {
        SeaMapVoyagePathConfigNodeLink *link = SeaMapVoyagePathConfig_GetNode(unknown4);

        if (link->node.distance > distance)
        {
            u16 count = FX_DivS32(link->node.distance - distance, denominator);
            if (id < count)
            {
                for (; id < count; id++)
                {
                    work->segmentList[id].type    = type;
                    work->segmentList[id].unknown = unknown;
                }
            }

            if (id == count)
            {
                work->segmentList[id].type    = type;
                work->segmentList[id].unknown = unknown;
            }

            switch (link->node.type)
            {
                case SEAMAPVOYAGEPATHCONFIGNODE_TYPE_0:
                    break;

                case SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1:
                    SailVoyageManager__SeaMapObjectUnknownType1(link, id);
                    break;

                case SEAMAPVOYAGEPATHCONFIGNODE_TYPE_2:
                    type = SailVoyageManager__SeaMapObjectUnknownType2(link);
                    break;

                case SEAMAPVOYAGEPATHCONFIGNODE_TYPE_3:
                    unknown = SailVoyageManager__SeaMapObjectUnknownType3(link);
                    break;

                case SEAMAPVOYAGEPATHCONFIGNODE_TYPE_4:
                    SailVoyageManager__SeaMapObjectUnknownType4(link, id);

                    if ((link->node.type4.chevRef->flags2 & 1) != 0)
                    {
                        state->sailUnknown4 = unknown4;
                    }
                    else
                    {
                        state->sailUnknown4 = unknown4 + 1;
                    }
                    break;
            }

            if (link->node.type == SEAMAPVOYAGEPATHCONFIGNODE_TYPE_1 || link->node.type == SEAMAPVOYAGEPATHCONFIGNODE_TYPE_4)
                break;
        }
    }
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	bl SailManager__GetWork
	mov r7, #0
	str r0, [sp, #0x10]
	sub r0, r7, #1
	mov r6, r7
	str r0, [sp, #4]
	bl SailManager__GetShipType
	lsl r1, r0, #2
	ldr r0, =shipStepTable
	ldr r0, [r0, r1]
	str r0, [sp]
	bl SailManager__GetWork
	add r0, #0x98
	ldr r5, [r0, #0]
	mov r4, r7
	ldr r0, [sp, #0x10]
	str r4, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _02157672
	ldr r0, =gameState
	add r0, #0xa8
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02157672
	ldr r1, =gameState
	add r1, #0xb6
	ldrh r1, [r1, #0]
	cmp r1, #0
	beq _02157672
	str r1, [sp, #8]
	str r0, [sp, #4]
_02157672:
	bl SeaMapVoyagePathConfig_GetNodeCount
	ldr r1, [sp, #8]
	cmp r1, r0
	bhs _02157760
_0215767C:
	ldr r0, [sp, #8]
	bl SeaMapVoyagePathConfig_GetNode
	str r0, [sp, #0xc]
	ldr r0, [r0, #8]
	ldr r1, [sp, #4]
	cmp r0, r1
	ble _0215774C
	sub r0, r0, r1
	ldr r1, [sp]
	bl FX_DivS32
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r4, r1
	bhs _021576C2
	cmp r4, r1
	bhs _021576C2
	mov r3, #0x28
_021576A2:
	mov r2, r5
	add r2, #0xc0
	mov r0, r4
	ldr r2, [r2, #0]
	mul r0, r3
	strb r6, [r2, r0]
	mov r2, r5
	add r2, #0xc0
	ldr r2, [r2, #0]
	add r0, r2, r0
	strb r7, [r0, #1]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, r1
	blo _021576A2
_021576C2:
	cmp r4, r1
	bne _021576DC
	mov r1, r5
	add r1, #0xc0
	mov r0, #0x28
	ldr r1, [r1, #0]
	mul r0, r4
	strb r6, [r1, r0]
	mov r1, r5
	add r1, #0xc0
	ldr r1, [r1, #0]
	add r0, r1, r0
	strb r7, [r0, #1]
_021576DC:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0xc]
	cmp r0, #4
	bhi _02157740
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021576F0: // jump table
    // .hword _02157740 - _021576F0 - 2 // case 0
    // .hword _021576FA - _021576F0 - 2 // case 1
    // .hword _02157704 - _021576F0 - 2 // case 2
    // .hword _0215770E - _021576F0 - 2 // case 3
    // .hword _02157718 - _021576F0 - 2 // case 4
	DCD 0x8004E
	DCD 0x1C0012
	DCD 0x98030026
// _021576FA:
	// ldr r0, [sp, #0xc]
	mov r1, r4
	bl SailVoyageManager__SeaMapObjectUnknownType1
	b _02157740
_02157704:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__SeaMapObjectUnknownType2
	mov r6, r0
	b _02157740
_0215770E:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__SeaMapObjectUnknownType3
	mov r7, r0
	b _02157740
_02157718:
	ldr r0, [sp, #0xc]
	mov r1, r4
	bl SailVoyageManager__SeaMapObjectUnknownType4
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0x14]
	ldrb r1, [r0, #7]
	mov r0, #1
	tst r0, r1
	beq _02157736
	ldr r1, =gameState
	ldr r0, [sp, #8]
	add r1, #0xb6
	strh r0, [r1]
	b _02157740
_02157736:
	ldr r0, [sp, #8]
	add r1, r0, #1
	ldr r0, =gameState
	add r0, #0xb6
	strh r1, [r0]
_02157740:
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0xc]
	cmp r0, #1
	beq _02157760
	cmp r0, #4
	beq _02157760
_0215774C:
	ldr r0, [sp, #8]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	bl SeaMapVoyagePathConfig_GetNodeCount
	ldr r1, [sp, #8]
	cmp r1, r0
	blo _0215767C
_02157760:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SailVoyageManager__SeaMapObjectUnknownType1(SeaMapVoyagePathConfigNodeLink *work, u32 segmentCount)
{
    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (segmentCount <= 1)
    {
        voyageManager->segmentList[1].type = voyageManager->segmentList[segmentCount].type;
        voyageManager->segmentList[2].type = voyageManager->segmentList[segmentCount].type;

        segmentCount = 2;
    }

    s32 prevSegment;
    switch (work->node.type1.type)
    {
        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_END:
            prevSegment                 = segmentCount - 1;
            voyageManager->segmentCount = segmentCount;

            voyageManager->segmentList[prevSegment].type  = SAILVOYAGESEGMENT_TYPE_26;
            voyageManager->segmentList[segmentCount].type = SAILVOYAGESEGMENT_TYPE_27;
            voyageManager->unknownObjectDistance          = work->node.distance;
            break;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_GOAL:
            prevSegment                 = segmentCount - 1;
            voyageManager->segmentCount = segmentCount;

            voyageManager->segmentList[prevSegment].type  = SAILVOYAGESEGMENT_TYPE_14;
            voyageManager->segmentList[segmentCount].type = SAILVOYAGESEGMENT_TYPE_15;

            voyageManager->unknownObjectDistance = work->node.distance;
            manager->field_4                     = work->node.type1.unlockID;
            break;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE1TYPE_COLLISION:
            voyageManager->segmentCount          = segmentCount;
            voyageManager->unknownObjectDistance = work->node.distance;

            s32 type;
            switch (voyageManager->segmentList[segmentCount].type)
            {
                case SAILVOYAGESEGMENT_TYPE_0:
                case SAILVOYAGESEGMENT_TYPE_4:
                default:
                    type = SAILVOYAGESEGMENT_TYPE_21;
                    break;

                case SAILVOYAGESEGMENT_TYPE_1:
                case SAILVOYAGESEGMENT_TYPE_2:
                    type = SAILVOYAGESEGMENT_TYPE_17;
                    break;

                case SAILVOYAGESEGMENT_TYPE_3:
                case SAILVOYAGESEGMENT_TYPE_5:
                    type = SAILVOYAGESEGMENT_TYPE_19;
                    break;
            }

            prevSegment                                   = segmentCount - 1;
            voyageManager->segmentList[prevSegment].type  = type - 1;
            voyageManager->segmentList[segmentCount].type = type;
            break;
    }

    prevSegment                                             = segmentCount - 1;
    voyageManager->segmentList[prevSegment].targetSeaAngle  = 0;
    voyageManager->segmentList[segmentCount].targetSeaAngle = 0;
    voyageManager->segmentList[prevSegment].turn            = 0;
    voyageManager->segmentList[segmentCount].turn           = 0;
}

void SailVoyageManager__SeaMapObjectUnknownType4(SeaMapVoyagePathConfigNodeLink *work, u32 segmentCount)
{
    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    if (segmentCount <= 1)
        segmentCount = 2;

    s32 prevSegment;
    switch (work->node.type4.type)
    {
        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_RIVAL_RACE:
            prevSegment                                   = segmentCount - 1;
            voyageManager->segmentCount                   = segmentCount;
            voyageManager->segmentList[prevSegment].type  = SAILVOYAGESEGMENT_TYPE_22;
            voyageManager->segmentList[segmentCount].type = SAILVOYAGESEGMENT_TYPE_23;

            manager->field_8                     = work->node.type4.chevRef->unlockID;
            voyageManager->unknownObjectDistance = work->node.distance;
            break;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE4TYPE_UNKNOWN:
            prevSegment                                   = segmentCount - 1;
            voyageManager->segmentCount                   = segmentCount;
            voyageManager->segmentList[prevSegment].type  = SAILVOYAGESEGMENT_TYPE_24;
            voyageManager->segmentList[segmentCount].type = SAILVOYAGESEGMENT_TYPE_25;

            voyageManager->unknownObjectDistance = work->node.distance;
            break;
    }

    prevSegment                                             = segmentCount - 1;
    voyageManager->segmentList[prevSegment].targetSeaAngle  = 0;
    voyageManager->segmentList[segmentCount].targetSeaAngle = 0;
    voyageManager->segmentList[prevSegment].turn            = 0;
    voyageManager->segmentList[segmentCount].turn           = 0;
}

u8 SailVoyageManager__SeaMapObjectUnknownType2(SeaMapVoyagePathConfigNodeLink *work)
{
    SailManager *manager = SailManager__GetWork();

    switch (work->node.type2.attribute)
    {
        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_0:
            return SAILVOYAGESEGMENT_TYPE_0;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_1:
            return SAILVOYAGESEGMENT_TYPE_5;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_2:
            return SAILVOYAGESEGMENT_TYPE_3;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_3:
            if (SailManager__GetShipType() == SHIP_HOVER)
                return SAILVOYAGESEGMENT_TYPE_2;
            else
                return SAILVOYAGESEGMENT_TYPE_1;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_4:
            return SAILVOYAGESEGMENT_TYPE_6;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE2TYPE_5:
            return SAILVOYAGESEGMENT_TYPE_4;
    }

    return SAILVOYAGESEGMENT_TYPE_0;
}

u8 SailVoyageManager__SeaMapObjectUnknownType3(SeaMapVoyagePathConfigNodeLink *work)
{
    SailManager *manager = SailManager__GetWork();

    switch (work->node.type3.lv)
    {
        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_0:
        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_1:
            return 0;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_2:
            return work->node.type3.lv - 1;

        case SEAMAPVOYAGEPATHCONFIGNODE_TYPE3TYPE_3:
            return work->node.type3.lv - 1;
    }

    return 0;
}

void SailVoyageManager__SetupVoyage(void)
{
    SailVoyageManager *voyageManager;
    SailManager *manager;
    GameState *state;

    manager       = SailManager__GetWork();
    state         = GetGameState();
    voyageManager = SailManager__GetWork()->voyageManager;

    if (manager->isRivalRace == FALSE && manager->missionType == MISSION_TYPE_NONE && state->seaMapNodeList.nodes.numObjects)
        SailVoyageManager__Func_21574B4(voyageManager);

    if (manager->missionType == MISSION_TYPE_REACH_GOAL)
    {
        voyageManager->segmentCount = 26;

        if (SailManager__GetShipType() == SHIP_BOAT)
            voyageManager->segmentCount = 18;

        if (SailManager__GetShipType() == SHIP_SUBMARINE)
            voyageManager->segmentCount = 30;

        for (u16 i = 0; i < voyageManager->segmentCount + 1; i++)
        {
            voyageManager->segmentList[i].unknown = manager->field_5DC;
        }

        s32 prevSegment                                              = voyageManager->segmentCount - 1;
        voyageManager->segmentList[prevSegment].type                 = SAILVOYAGESEGMENT_TYPE_26;
        voyageManager->segmentList[voyageManager->segmentCount].type = SAILVOYAGESEGMENT_TYPE_27;
    }

    if (SailManager__GetShipType() == SHIP_SUBMARINE)
    {
        voyageManager->angle     = FLOAT_DEG_TO_IDX(180.0);
        voyageManager->prevAngle = voyageManager->angle;

        for (u16 i = 0; i <= voyageManager->segmentCount; i++)
        {
            voyageManager->segmentList[i].turn = 0;
        }
    }

    SailEventManager__LoadLayout();
    SailVoyageManager__InitSegmentList(voyageManager);
    SailEventManager__LoadMapObjects(0, 0);
    SailEventManager__LoadMapObjects(1, 0);
}

s32 SailVoyageManager__GetVoyagePos(void)
{
    SailManager *manager = SailManager__GetWork();

    return manager->voyageManager->voyagePos;
}

VecFx32 *SailVoyageManager__GetVoyageVelocity(void)
{
    SailManager *manager = SailManager__GetWork();

    return &manager->voyageManager->velocity;
}

u16 SailVoyageManager__GetVoyageAngle(void)
{
    SailManager *manager = SailManager__GetWork();

    return manager->voyageManager->angle;
}

s32 SailVoyageManager__GetSegmentSize(SailVoyageSegment *segment)
{
    return FLOAT_TO_FX32(128.0);
}

void SailVoyageManager__Main(void)
{
    SailVoyageManager *work = TaskGetWorkCurrent(SailVoyageManager);

    SailManager *manager = SailManager__GetWork();

    SailVoyageManager__Func_2157C34(work);

    if (work->field_BC != 0)
    {
        work->field_BC -= FLOAT_TO_FX32(0.25);
        if (work->field_BC < FLOAT_TO_FX32(0.0))
            work->field_BC = FLOAT_TO_FX32(0.0);
    }

    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        u16 segmentID     = FX32_TO_WHOLE(work->voyagePos) >> 7;
        u16 prevSegmentID = FX32_TO_WHOLE(work->prevVoyagePos) >> 7;

        switch (work->segmentList[segmentID].type)
        {
            case SAILVOYAGESEGMENT_TYPE_5:
            case SAILVOYAGESEGMENT_TYPE_12:
            case SAILVOYAGESEGMENT_TYPE_18:
            case SAILVOYAGESEGMENT_TYPE_19:
                work->field_BA |= 2;
                break;

            default:
                if (manager->cloudType == 3)
                    manager->cloudType = 2;
                break;

            case SAILVOYAGESEGMENT_TYPE_11:
            case SAILVOYAGESEGMENT_TYPE_4:
                if (prevSegmentID == 0 || (work->segmentList[prevSegmentID].type != SAILVOYAGESEGMENT_TYPE_4 && work->segmentList[prevSegmentID].type != SAILVOYAGESEGMENT_TYPE_11))
                {
                    manager->cloudType = 3;
                }
                break;
        }

        if (work->segmentList[segmentID].type == SAILVOYAGESEGMENT_TYPE_0)
            work->field_BA &= ~2;

        if ((work->field_BA & 2) != 0)
        {
            work->field_BC += FLOAT_TO_FX32(0.5);
            if (work->field_BC > FLOAT_TO_FX32(10.0))
                work->field_BC = FLOAT_TO_FX32(10.0);
        }
    }
}

void SailVoyageManager__Func_2157C34(SailVoyageManager *work)
{
    fx32 speed = 0;

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;
    UNUSED(voyageManager);

    StageTask *player        = SailManager__GetWork()->sailPlayer;
    SailPlayer *playerWorker = NULL;
    SailManager *manager     = SailManager__GetWork();

    GameState *state = GetGameState();

    VecFx32 unknown = { 0, 1, 0 };

    if (player != NULL)
        playerWorker = GetStageTaskWorker(SailManager__GetWork()->sailPlayer, SailPlayer);

    SailVoyageSegment *segment = &work->segmentList[work->curSegment];

    if (playerWorker != NULL)
    {
        speed = playerWorker->speed;
        if (SailManager__GetShipType() == SHIP_JET || SailManager__GetShipType() == SHIP_HOVER)
        {
            if (player->hitstopTimer != 0)
                speed = FLOAT_TO_FX32(0.0);
        }
    }

    work->prevVoyagePos = work->voyagePos;
    work->voyagePos += speed;
    work->segmentPos += speed;

    work->prevPosition = work->position;
    work->field_70     = 0;
    work->field_74     = 0;
    work->prevAngle    = work->angle;

    if ((SailManager__GetShipType() == SHIP_JET || SailManager__GetShipType() == SHIP_HOVER) && player && player->hitstopTimer)
    {
        work->velocity.x = 0;
        work->velocity.y = 0;
        work->velocity.z = 0;
        work->angleMove  = 0;
    }
    else
    {
        if (playerWorker != 0)
        {
            if ((manager->flags & SAILMANAGER_FLAG_1) == 0 && (manager->flags & SAILMANAGER_FLAG_2) == 0)
            {
                if (SailPlayer__HasRetired(player) || work->segmentList[FX32_TO_WHOLE(work->voyagePos) >> 7].type >= 14)
                    work->targetSeaAngle = FLOAT_DEG_TO_IDX(0.0);

                s16 angle = playerWorker->seaAngle2;
                if (angle != work->targetSeaAngle)
                {
                    work->field_40 = ObjSpdUpSet(work->field_40, 8, 288);

                    playerWorker->seaAngle2 = ObjRoopMove16((u16)playerWorker->seaAngle2, (u16)work->targetSeaAngle, work->field_40);
                    if (playerWorker->seaAngle2 == angle)
                        work->field_40 = 0;
                }
            }
        }

        // advance segment
        if (work->segmentCount > work->curSegment && work->segmentPos >= SailVoyageManager__GetSegmentSize(segment))
        {
            work->segmentPos -= SailVoyageManager__GetSegmentSize(segment);
            if (work->field_6E != 0 && work->curSegment + 1 == work->field_6E)
            {
                SailVoyageManager__Func_2158888(segment + 1, FX_Div(work->segmentPos, SailVoyageManager__GetSegmentSize(segment + 1)), &unknown.x, &unknown.z);
                unknown.y        = 0;
                work->curSegment = work->field_6C;

                segment        = &work->segmentList[work->curSegment];
                work->field_74 = -(work->field_6E - work->field_6C) * SailVoyageManager__GetSegmentSize(segment);
                work->prevVoyagePos += work->field_74;
                work->voyagePos += work->field_74;
            }
            else
            {
                segment++;
                work->curSegment++;
            }

            work->angle      = segment->angle;
            work->position.x = segment->position.x;
            work->position.z = segment->position.y;
            work->angle2     = work->angle;

            work->voyageStartPos     = work->position;
            work->prevTargetSeaAngle = work->targetSeaAngle;
            work->targetSeaAngle     = segment->targetSeaAngle;

            if (segment->type >= SAILVOYAGESEGMENT_TYPE_14 && player != NULL)
            {
                SailVoyageManager__LoadSegment(work, segment->type);
                SailEventManager__LoadMapObjects(work->curSegment + 1, work->voyagePos);
                manager->field_5E = 0;
                manager->field_60++;
            }
            else
            {
                if (segment->type < SAILVOYAGESEGMENT_TYPE_7)
                {
                    if (manager->missionID == MISSION_TYPE_NONE && manager->isRivalRace != TRUE && SailManager__GetShipType() != SHIP_BOAT
                        && (segment->header2EntryID < 3 || SailManager__GetShipType() == SHIP_SUBMARINE))
                    {
                        manager->flags ^= SAILMANAGER_FLAG_4;
                    }
                    manager->field_5E = 0;
                    manager->field_60++;
                }

                if (work->field_6E != 0 && work->curSegment + 1 == work->field_6E)
                {
                    work->field_70 = SailVoyageManager__GetSegmentSize(segment) * (work->field_6E - work->field_6C);
                    SailEventManager__LoadMapObjects(work->field_6C, work->voyagePos);
                }
                else
                {
                    SailEventManager__LoadMapObjects(work->curSegment + 1, work->voyagePos);
                }
                SailVoyageManager__Func_2158234(work);
            }
        }

        s32 segmentPos     = FX_Div(work->segmentPos, SailVoyageManager__GetSegmentSize(segment));
        work->angle = SailVoyageManager__GetAngleForSegmentPos(segment, segmentPos);
        SailVoyageManager__Func_2158888(segment, segmentPos, &work->position.x, &work->position.z);
        work->angleMove = work->angle - work->prevAngle;

        if (unknown.y == 0)
            VEC_Subtract(&unknown, &work->prevPosition, &work->velocity);
        else
            VEC_Subtract(&work->position, &work->prevPosition, &work->velocity);

        SetSailSeaVoyageAngle(work->angle);
        MoveSailSea(speed);

        if (manager->isRivalRace == FALSE && manager->missionType == MISSION_TYPE_NONE)
        {
            if (state->seaMapNodeList.nodes.numObjects)
            {
                if ((manager->flags & SAILMANAGER_FLAG_8) == 0)
                {
                    if (segment->type < SAILVOYAGESEGMENT_TYPE_14 || (segment->type & 1) == 0)
                    {
                        fx32 move = shipStepTable[SailManager__GetShipType()];
                        fx32 max  = 512;
                        fx32 min  = 128;

                        work->unknownDistance = MultiplyFX(FX_Div(work->voyagePos, FLOAT_TO_FX32(128.0)), move);
                        work->unknownDistance += state->sailUnknown1;

                        SeaMapManager__Func_2045BF8(work->unknownDistance, &work->targetUnknownX, &work->targetUnknownZ);

                        if (SailManager__GetShipType() == SHIP_BOAT)
                        {
                            max -= 64;
                            min = max;
                        }

                        if (work->targetUnknownX != work->unknownX)
                            work->unknownX = ObjShiftSet(work->unknownX, work->targetUnknownX, 1, max, min);

                        if (work->targetUnknownZ != work->unknownZ)
                            work->unknownZ = ObjShiftSet(work->unknownZ, work->targetUnknownZ, 1, max, min);
                    }
                }
            }
        }
    }
}

void SailVoyageManager__LoadSegment(SailVoyageManager *work, u8 type)
{
    SailManager *manager = SailManager__GetWork();

    GameState *state = GetGameState();

    StageTask *player = SailManager__GetWork()->sailPlayer;

    SailPlayer *playerWorker = NULL;
    if (player != NULL)
    {
        playerWorker = GetStageTaskWorker(SailManager__GetWork()->sailPlayer, SailPlayer);
    }

    if ((manager->flags & SAILMANAGER_FLAG_8) == 0)
    {
        switch (type)
        {
            case SAILVOYAGESEGMENT_TYPE_22:
                manager->flags |= SAILMANAGER_FLAG_200;
                break;

            case SAILVOYAGESEGMENT_TYPE_14: {
                SBBObject sbbObject;
                MtxFx33 mtx;
                VecFx32 offset = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(320.0) };

                MTX_RotY33(&mtx, SinFX(work->angle), CosFX(work->angle));
                MTX_MultVec33(&offset, &mtx, &offset);

                sbbObject.unknown = work->position;
                VEC_Add(&sbbObject.unknown, &offset, &sbbObject.unknown);

                sbbObject.type      = SAILMAPOBJECT_NONE;
                sbbObject.viewRange = 0x180;
                sbbObject.field_14  = manager->field_4;
                SailEventManager__LoadObject(&sbbObject);
            }
                // fallthrough

            case SAILVOYAGESEGMENT_TYPE_16:
            case SAILVOYAGESEGMENT_TYPE_18:
            case SAILVOYAGESEGMENT_TYPE_20:
            case SAILVOYAGESEGMENT_TYPE_26: {
                if (manager->isRivalRace == FALSE)
                    SailGoalText__Create((work->voyagePos & ~0x7FFFF) + 0x80000);
                else
                    SailChaosEmerald__Create((work->voyagePos & ~0x7FFFF) + 0x80000);

                SailGoal__Create((work->voyagePos & ~0x7FFFF) + 0x80000);

                manager->flags |= SAILMANAGER_FLAG_200;
            }
            break;

            case SAILVOYAGESEGMENT_TYPE_15:
            case SAILVOYAGESEGMENT_TYPE_24:
            case SAILVOYAGESEGMENT_TYPE_25:
            default: {
                work->unknownDistance = work->unknownObjectDistance;
                NNS_SndPlayerStopSeq(&defaultTrackPlayer, 0);
                PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SAIL_SEQ_SEQ_DISCOVER);
                manager->flags |= SAILMANAGER_FLAG_20;
                SailPlayer__Action_ReachedGoal(player);

                s32 unlockID = SeaMapEventManager__Func_2046CE8((s16)manager->field_4);
                if ((manager->flags & SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER) == 0)
                {
                    if (!SeaMapEventManager__CheckFeatureUnlocked(unlockID))
                        manager->flags |= SAILMANAGER_FLAG_80000;

                    SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_TYPE_7, INT_TO_VOID(manager->field_4), 0);
                }
            }
            break;

            case SAILVOYAGESEGMENT_TYPE_17:
            case SAILVOYAGESEGMENT_TYPE_19:
            case SAILVOYAGESEGMENT_TYPE_21:
                work->unknownDistance = work->unknownObjectDistance;
                manager->flags |= SAILMANAGER_FLAG_40;
                SailPlayer__Action_ReachedGoal(player);
                if (playerWorker != NULL)
                {
                    state->sailStoredShipHealth = playerWorker->health;
                }
                break;

            case SAILVOYAGESEGMENT_TYPE_23:
                work->unknownDistance = work->unknownObjectDistance;
                manager->flags |= SAILMANAGER_FLAG_4000;
                SailPlayer__Action_ReachedGoal(player);
                if (playerWorker != NULL)
                {
                    state->sailStoredShipHealth = playerWorker->health;
                }

                state->sailUnknown1 = work->unknownDistance;
                break;

            case SAILVOYAGESEGMENT_TYPE_27:
                manager->flags |= SAILMANAGER_FLAG_2000000;

                if (manager->isRivalRace && state->sailStoredShipType == SHIP_JET && playerWorker != NULL)
                {
                    manager->field_2C           = state->sailStoredShipHealth;
                    state->sailStoredShipHealth = playerWorker->health;
                }

                work->unknownDistance = work->unknownObjectDistance;
                SailPlayer__Action_ReachedGoal(player);
                break;
        }
    }
}

NONMATCH_FUNC void SailVoyageManager__Func_2158234(SailVoyageManager *work)
{
    // https://decomp.me/scratch/gTH8W -> 98.45%
#ifdef NON_MATCHING
    u16 i;
    u16 k;
    BOOL flag;

    SailManager *manager = SailManager__GetWork();

    if (SailManager__GetShipType() != SHIP_SUBMARINE && manager->isRivalRace == 0 && manager->missionType == MISSION_TYPE_NONE)
    {
        for (i = 0; i < work->field_FE; i++)
        {
            work->field_F4[i] = work->field_CC[i].object->unlockID;
        }
        work->field_FE = 5;

        SeaMapEventManager__Func_2046B14(work->targetUnknownX, work->targetUnknownZ, FLOAT_TO_FX32(64.0), work->field_CC, &work->field_FE);

        for (i = 0; i < work->field_FE; i++)
        {
            flag = TRUE;

            for (k = 0; k < work->field_FE; k++)
            {
                if (work->field_F4[k] == work->field_CC[i].object->unlockID)
                    flag = FALSE;

                if (manager->field_4 == work->field_CC[i].object->unlockID)
                    flag = FALSE;
            }

            if (flag)
            {
                SBBObject sbbObject;

                VecFx32 position = { 0 };

                sbbObject.unknown   = work->position;
                sbbObject.type      = SAILMAPOBJECT_NONE;
                sbbObject.viewRange = 0x180;
                sbbObject.field_14  = work->field_CC[i].object->unlockID;
                SailEventManager__LoadObject(&sbbObject);
            }
        }
    }
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	mov r5, r0
	bl SailManager__GetWork
	str r0, [sp, #8]
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02158340
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _02158340
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	bne _02158340
	mov r1, r5
	add r1, #0xfe
	ldrh r4, [r1, #0]
	mov r0, #0
	cmp r4, #0
	bls _02158288
	mov r2, #0x10
_02158266:
	lsl r1, r0, #3
	add r1, r5, r1
	add r1, #0xcc
	ldr r1, [r1, #0]
	ldrsh r3, [r1, r2]
	lsl r1, r0, #1
	add r1, r5, r1
	add r1, #0xf4
	strh r3, [r1]
	mov r1, r5
	add r1, #0xfe
	add r0, r0, #1
	lsl r0, r0, #0x10
	ldrh r4, [r1, #0]
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _02158266
_02158288:
	mov r0, r5
	mov r1, #5
	add r0, #0xfe
	strh r1, [r0]
	mov r0, r5
	add r0, #0xfe
	str r0, [sp]
	mov r2, #1
	mov r3, r5
	ldr r0, [r5, #0x5c]
	ldr r1, [r5, #0x60]
	lsl r2, r2, #0x12
	add r3, #0xcc
	bl SeaMapEventManager__Func_2046B14
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r0, [r0, #0]
	cmp r0, #0
	bls _02158340
_021582B4:
	mov r1, #1
	mov r0, #0
	cmp r4, #0
	bls _021582EE
	ldr r2, [sp, #4]
	mov r7, r0
	lsl r2, r2, #3
	add r2, r5, r2
	add r2, #0xcc
	ldr r3, [r2, #0]
	mov r2, #0x10
	ldrsh r2, [r3, r2]
	ldr r3, [sp, #8]
	ldr r3, [r3, #4]
_021582D0:
	lsl r6, r0, #1
	add r6, r5, r6
	add r6, #0xf4
	ldrh r6, [r6, #0]
	cmp r6, r2
	bne _021582DE
	mov r1, r7
_021582DE:
	cmp r3, r2
	bne _021582E4
	mov r1, #0
_021582E4:
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	cmp r0, r4
	blo _021582D0
_021582EE:
	cmp r1, #0
	beq _0215832A
	add r0, sp, #0xc
	mov r7, #0
	str r7, [r0]
	str r7, [r0, #4]
	add r3, sp, #0x18
	mov r6, r5
	str r7, [r0, #8]
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	mov r1, #6
	str r0, [r3]
	add r0, sp, #0xc
	strh r7, [r0, #0x18]
	lsl r1, r1, #6
	strh r1, [r0, #0x1c]
	ldr r0, [sp, #4]
	lsl r0, r0, #3
	add r0, r5, r0
	add r0, #0xcc
	ldr r1, [r0, #0]
	mov r0, #0x10
	ldrsh r0, [r1, r0]
	str r0, [sp, #0x2c]
	mov r0, r2
	bl SailEventManager__LoadObject
_0215832A:
	ldr r0, [sp, #4]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #4]
	mov r0, r5
	add r0, #0xfe
	ldrh r1, [r0, #0]
	ldr r0, [sp, #4]
	cmp r0, r1
	blo _021582B4
_02158340:
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void SailVoyageManager__InitSegmentList(SailVoyageManager *work)
{
    Vec2Fx32 a2 = { 0, 0 };
    Vec2Fx32 a4 = { 0, 0 };

    SailVoyageSegment *firstSegment = work->segmentList;
    firstSegment->position.x        = work->voyageStartPos.x;
    firstSegment->position.y        = work->voyageStartPos.z;
    firstSegment->startPos          = firstSegment->position;
    firstSegment->angle             = work->angle;
    firstSegment->turn              = FLOAT_DEG_TO_IDX(0.0);
    firstSegment->field_24          = FLOAT_TO_FX32(0.0);

    a2.x                   = MultiplyFX(-SailVoyageManager__GetSegmentSize(firstSegment), SinFX(firstSegment->angle));
    a2.y                   = MultiplyFX(-SailVoyageManager__GetSegmentSize(firstSegment), CosFX(firstSegment->angle));
    firstSegment->endPos.x = firstSegment->position.x + a2.x;
    firstSegment->endPos.y = firstSegment->position.y + a2.y;

    a2.x >>= 1;
    a2.y >>= 1;
    firstSegment->startPos.x = firstSegment->position.x + a2.x;
    firstSegment->startPos.y = firstSegment->position.y + a2.y;

    for (u16 i = 1; i < SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE; i++)
    {
        s32 prevSlot                   = i - 1;
        SailVoyageSegment *prevSegment = &work->segmentList[prevSlot];
        SailVoyageSegment *segment     = &work->segmentList[(s32)i];

        segment->field_24 = prevSegment->field_24;
        segment->angle    = prevSegment->angle;
        segment->position = prevSegment->endPos;
        segment->field_24 += SailVoyageManager__GetSegmentSize(prevSegment);
        segment->angle += prevSegment->turn;

        a2.x              = MultiplyFX(-SailVoyageManager__GetSegmentSize(segment), SinFX((s32)(u16)(segment->angle + (segment->turn >> 1))));
        a2.y              = MultiplyFX(-SailVoyageManager__GetSegmentSize(segment), CosFX((s32)(u16)(segment->angle + (segment->turn >> 1))));
        segment->endPos.x = segment->position.x + a2.x;
        segment->endPos.y = segment->position.y + a2.y;

        if (segment->turn == FLOAT_DEG_TO_IDX(0.0) || segment->turn == FLOAT_DEG_TO_IDX(180.0))
        {
            a2.x = MultiplyFX(-SailVoyageManager__GetSegmentSize(prevSegment), SinFX(segment->angle));
            a2.y = MultiplyFX(-SailVoyageManager__GetSegmentSize(prevSegment), CosFX(segment->angle));
            a2.x >>= 1;
            a2.y >>= 1;

            segment->startPos.x = segment->position.x + a2.x;
            segment->startPos.y = segment->position.y + a2.y;
        }
        else
        {
            a2.x = MultiplyFX(-SailVoyageManager__GetSegmentSize(prevSegment), SinFX(segment->angle));
            a2.y = MultiplyFX(-SailVoyageManager__GetSegmentSize(prevSegment), CosFX(segment->angle));
            a2.x += segment->position.x;
            a2.y += segment->position.y;

            a4.x = MultiplyFX(-SailVoyageManager__GetSegmentSize(segment), SinFX((s32)(u16)(segment->angle + segment->turn)));
            a4.y = MultiplyFX(-SailVoyageManager__GetSegmentSize(segment), CosFX((s32)(u16)(segment->angle + segment->turn)));

            a4.x += segment->endPos.x;
            a4.y += segment->endPos.y;
            SailVoyageManager__Func_215868C(&segment->position, &a2, &segment->endPos, &a4, &segment->startPos);
        }

        if (i == work->segmentCount + 1)
            break;
    }
}

NONMATCH_FUNC void SailVoyageManager__Func_215868C(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, Vec2Fx32 *a5){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	mov r6, r2
	ldr r2, [r0, #4]
	ldr r0, [r0, #0]
	asr r5, r2, #4
	ldr r2, [r1, #4]
	str r3, [sp]
	asr r2, r2, #4
	sub r2, r2, r5
	str r2, [sp, #0x20]
	asr r2, r0, #4
	ldr r0, [r1, #0]
	asr r3, r2, #0x1f
	asr r0, r0, #4
	sub r0, r2, r0
	str r0, [sp, #0x24]
	asr r0, r0, #0x1f
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x20]
	ldr r4, [sp, #0x60]
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x2c]
	mov r7, r1
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	mov r5, #0
	lsl r0, r0, #0xa
	add r0, r1, r0
	adc r7, r5
	lsl r1, r7, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	mov r1, #2
	lsl r1, r1, #0xa
	add r2, r2, r1
	adc r3, r5
	lsl r1, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r1
	sub r0, r0, r2
	str r0, [sp, #0x18]
	ldr r0, [r6, #4]
	asr r5, r0, #4
	ldr r0, [sp]
	ldr r0, [r0, #4]
	asr r0, r0, #4
	sub r0, r0, r5
	str r0, [sp, #0x1c]
	ldr r0, [r6, #0]
	asr r2, r0, #4
	ldr r0, [sp]
	asr r3, r2, #0x1f
	ldr r0, [r0, #0]
	asr r0, r0, #4
	sub r6, r2, r0
	ldr r0, [sp, #0x1c]
	asr r7, r6, #0x1f
	neg r0, r0
	asr r1, r0, #0x1f
	bl _ull_mul
	str r0, [sp, #0x30]
	str r1, [sp, #0x10]
	mov r0, r6
	mov r1, r7
	asr r3, r5, #0x1f
	mov r2, r5
	bl _ull_mul
	mov r2, #2
	ldr r3, [sp, #0x30]
	lsl r2, r2, #0xa
	mov r5, #0
	add r3, r3, r2
	ldr r2, [sp, #0x10]
	adc r2, r5
	str r2, [sp, #0x10]
	lsl r2, r2, #0x14
	lsr r3, r3, #0xc
	orr r3, r2
	mov r2, #2
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r5
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	sub r5, r3, r0
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x28]
	asr r0, r0, #0x1f
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x24]
	ldr r3, [sp, #0x38]
	bl _ull_mul
	str r0, [sp, #0x3c]
	str r1, [sp, #8]
	ldr r2, [sp, #0x20]
	ldr r3, [sp, #0x34]
	mov r0, r6
	mov r1, r7
	bl _ull_mul
	mov ip, r0
	mov r3, r1
	mov r0, #2
	ldr r1, [sp, #0x3c]
	lsl r0, r0, #0xa
	add r2, r1, r0
	ldr r1, [sp, #8]
	ldr r0, =0x00000000
	adc r1, r0
	str r1, [sp, #8]
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #2
	lsl r0, r0, #0xa
	mov r2, ip
	add r2, r2, r0
	ldr r0, =0x00000000
	adc r3, r0
	lsl r0, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	sub r0, r1, r2
	str r0, [sp, #0x14]
	beq _0215884A
	asr r0, r5, #0x1f
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x18]
	mov r2, r6
	asr r0, r0, #0x1f
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x44]
	mov r3, r7
	bl _ull_mul
	mov r6, r1
	mov r7, r0
	ldr r1, [sp, #0x40]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x28]
	mov r0, r5
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	ldr r3, =0x00000000
	add r2, r7, r2
	adc r6, r3
	lsl r3, r6, #0x14
	lsr r2, r2, #0xc
	orr r2, r3
	mov r3, #2
	lsl r3, r3, #0xa
	add r3, r0, r3
	ldr r0, =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	sub r0, r2, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x34]
	ldr r3, [sp, #0x40]
	mov r2, r5
	bl _ull_mul
	mov r6, r0
	mov r5, r1
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x38]
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x44]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r6, r6, r2
	adc r5, r3
	lsl r5, r5, #0x14
	lsr r6, r6, #0xc
	orr r6, r5
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	sub r0, r6, r1
	ldr r1, [sp, #0x14]
	bl FX_Div
	str r0, [r4, #4]
	ldr r0, [r4, #0]
	lsl r0, r0, #4
	str r0, [r4]
	ldr r0, [r4, #4]
	lsl r0, r0, #4
	str r0, [r4, #4]
_0215884A:
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

u16 SailVoyageManager__GetAngleForSegmentPos(SailVoyageSegment *segment, s32 segmentPos)
{
    SailManager *manager = SailManager__GetWork();

    return segment->angle + MultiplyFX(segmentPos, segment->turn);
}

NONMATCH_FUNC void SailVoyageManager__Func_2158888(SailVoyageSegment *segment, s32 a2, fx32 *x, fx32 *z)
{
    // https://decomp.me/scratch/dlMlT -> 74.04%
#ifdef NON_MATCHING
    SailManager *manager = SailManager__GetWork();

    s32 rangeCenter = MultiplyFX(FLOAT_TO_FX32(1.0) - range, FLOAT_TO_FX32(1.0) - range);
    s32 rangeStart  = MultiplyFX(2 * range, FLOAT_TO_FX32(1.0) - range);
    s32 rangeEnd    = MultiplyFX(range, range);

    if (rangeEnd + rangeCenter + rangeStart != FLOAT_TO_FX32(1.0))
        rangeStart = FLOAT_TO_FX32(1.0) - (rangeEnd + rangeCenter);

    s32 x1 = MultiplyFX(rangeEnd, segment->endPos.x);
    s32 x2 = MultiplyFX(rangeCenter, segment->position.x);
    s32 x3 = MultiplyFX(rangeStart, segment->startPos.x);

    s32 posX = x1 + x2 + x3;

    s32 z1 = MultiplyFX(rangeEnd, segment->endPos.y);
    s32 z2 = MultiplyFX(rangeCenter, segment->position.y);
    s32 z3 = MultiplyFX(rangeStart, segment->startPos.y);

    s32 posZ = z1 + z2 + z3;

    if (x != NULL)
        *x = posX;

    if (z != NULL)
        *z = posZ;
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x40
	mov r4, r0
	mov r7, r1
	str r2, [sp]
	str r3, [sp, #4]
	bl SailManager__GetWork
	mov r0, #1
	lsl r0, r0, #0xc
	sub r0, r0, r7
	asr r5, r0, #0x1f
	mov r1, r5
	mov r2, r0
	mov r3, r5
	str r0, [sp, #0x18]
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsr r6, r2, #0xc
	lsl r0, r1, #0x14
	orr r6, r0
	lsl r0, r7, #1
	ldr r2, [sp, #0x18]
	asr r1, r0, #0x1f
	mov r3, r5
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r5, r2, #0xc
	asr r1, r7, #0x1f
	orr r5, r0
	mov r0, r7
	mov r2, r7
	mov r3, r1
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r0, r0, r2
	adc r1, r3
	lsr r0, r0, #0xc
	lsl r1, r1, #0x14
	str r0, [sp, #0x14]
	orr r0, r1
	add r1, r6, r5
	str r0, [sp, #0x14]
	add r1, r0, r1
	lsl r0, r2, #1
	cmp r1, r0
	beq _02158906
	sub r0, r0, r1
	add r5, r5, r0
_02158906:
	asr r0, r5, #0x1f
	str r0, [sp, #0x1c]
	asr r0, r6, #0x1f
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x14]
	ldr r2, [r4, #0x1c]
	asr r0, r0, #0x1f
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0xc]
	str r1, [sp, #0xc]
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x14]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x2c]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov ip, r0
	mov r7, r1
	mov r0, #2
	ldr r1, [sp, #0x28]
	lsl r0, r0, #0xa
	add r0, r1, r0
	ldr r2, [sp, #0xc]
	ldr r1, =0x00000000
	adc r2, r1
	str r2, [sp, #0xc]
	lsl r1, r2, #0x14
	lsr r2, r0, #0xc
	orr r2, r1
	mov r0, #2
	ldr r1, [sp, #0x2c]
	lsl r0, r0, #0xa
	add r3, r1, r0
	ldr r1, =0x00000000
	ldr r0, [sp, #0x3c]
	adc r0, r1
	str r0, [sp, #0x3c]
	lsr r1, r3, #0xc
	lsl r0, r0, #0x14
	orr r1, r0
	mov r0, #2
	mov r3, ip
	lsl r0, r0, #0xa
	add r3, r3, r0
	ldr r0, =0x00000000
	adc r7, r0
	lsl r0, r7, #0x14
	lsr r3, r3, #0xc
	orr r3, r0
	add r0, r1, r3
	add r0, r2, r0
	ldr r2, [r4, #0x20]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r1, [sp, #0x24]
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x10]
	mov r7, r1
	str r0, [sp, #0x30]
	ldr r1, [sp, #0x20]
	mov r0, r6
	asr r3, r2, #0x1f
	bl _ull_mul
	ldr r2, [r4, #0x18]
	mov r6, r1
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x1c]
	mov r0, r5
	asr r3, r2, #0x1f
	bl _ull_mul
	mov r3, r0
	mov r0, #2
	mov r4, r1
	ldr r2, [sp, #0x30]
	mov r1, #0
	lsl r0, r0, #0xa
	add r2, r2, r0
	adc r7, r1
	lsl r5, r7, #0x14
	lsr r2, r2, #0xc
	orr r2, r5
	ldr r5, [sp, #0x34]
	add r5, r5, r0
	adc r6, r1
	lsl r6, r6, #0x14
	lsr r5, r5, #0xc
	orr r5, r6
	add r3, r3, r0
	adc r4, r1
	lsl r0, r4, #0x14
	lsr r1, r3, #0xc
	orr r1, r0
	add r0, r5, r1
	add r2, r2, r0
	ldr r0, [sp]
	cmp r0, #0
	beq _021589EE
	ldr r1, [sp, #0x10]
	str r1, [r0]
_021589EE:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _021589F6
	str r2, [r0]
_021589F6:
	add sp, #0x40
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

#include <nitro/codereset.h>