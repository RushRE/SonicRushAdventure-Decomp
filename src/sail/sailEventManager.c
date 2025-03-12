#include <sail/sailEventManager.h>
#include <sail/sailManager.h>
#include <sail/sailPlayer.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/file/fsRequest.h>

// Objects
#include <sail/objects/sailIsland.h>
#include <sail/objects/sailCloud.h>
#include <sail/objects/sailBuoy.h>
#include <sail/objects/sailSeagull.h>
#include <sail/objects/sailRock.h>
#include <sail/objects/sailIce.h>
#include <sail/objects/sailFish.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailJetRaceGoalHUD__Create(s32 a1, s32 a2, BOOL isGoal);

// --------------------
// VARIABLES
// --------------------

const u16 _0218B9AC[SHIP_COUNT] = { [SHIP_JET] = 0xA0, [SHIP_BOAT] = 0x1200, [SHIP_HOVER] = 0xA0, [SHIP_SUBMARINE] = 0x400 };
const u16 _0218B9B4[SHIP_COUNT] = { [SHIP_JET] = 0xA0, [SHIP_BOAT] = 0x1200, [SHIP_HOVER] = 0xA0, [SHIP_SUBMARINE] = 0x400 };

static u8 _0218CD30[8][16] = {
    [0] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }, [1] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }, [2] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    [3] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 }, [4] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 }, [5] = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    [6] = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9 }, [7] = { 6, 6, 3, 3, 3, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 },
};

// --------------------
// FUNCTIONS
// --------------------

SailEventManager *SailEventManager__Create(void)
{
    SailEventManager *work;

    SailManager *manager = SailManager__GetWork();

    Task *task = TaskCreate(SailEventManager__Main, SailEventManager__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(4), SailEventManager);

    work = TaskGetWork(task, SailEventManager);
    TaskInitWork16(work);

    NNS_FND_INIT_LIST(&work->stageObjectList, SailEventManagerObject, link);
    NNS_FND_INIT_LIST(&work->tempObjectList, SailEventManagerObject, link);

    if (manager->isRivalRace)
        work->stageObjectEntries = HeapAllocHead(HEAP_USER, SAILEVENTMANAGER_STAGE_OBJ_LIST_SIZE * sizeof(SailEventManagerObject));
    else
        work->stageObjectEntries = HeapAllocHead(HEAP_SYSTEM, SAILEVENTMANAGER_STAGE_OBJ_LIST_SIZE * sizeof(SailEventManagerObject));

    MI_CpuClear16(work->stageObjectEntries, SAILEVENTMANAGER_STAGE_OBJ_LIST_SIZE * sizeof(SailEventManagerObject));

    work->tempObjectEntries = HeapAllocHead(HEAP_USER, SAILEVENTMANAGER_TEMP_OBJ_LIST_SIZE * sizeof(SailEventManagerObject));
    MI_CpuClear16(work->tempObjectEntries, SAILEVENTMANAGER_TEMP_OBJ_LIST_SIZE * sizeof(SailEventManagerObject));

    if (manager->missionID != 0)
    {
        char path[] = "sbb/sb_ms000.sbb";

        s32 digit1 = FX_DivS32(manager->missionID, 10);
        s32 digit2 = manager->missionID - 10 * digit1;
        path[11] += digit2;
        path[10] += digit1;
        work->sbbFile = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
    }
    else if (manager->isRivalRace == TRUE)
    {
        char path[] = "sbb/sb_joh00.sbb";

        s32 digit1 = FX_DivS32(manager->rivalRaceID, 10);
        s32 digit2 = manager->rivalRaceID - 10 * digit1;
        path[11] += digit2;
        path[10] += digit1;
        work->sbbFile = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_HEAD);
    }
    else
    {
        // this file does not exist?
        ObjDataLoad(GetObjectFileWork(OBJDATAWORK_51), "sb_jet.sbb", SailManager__GetArchive());
    }

    work->blockID = 0xFFFE;

    switch (SailManager__GetShipType())
    {
        case SHIP_JET:
        case SHIP_HOVER:
            work->field_24.x         = MultiplyFX(-FLOAT_TO_FX32(40.0), SinFX(FLOAT_DEG_TO_IDX(0.0)));
            work->field_24.z         = MultiplyFX(-FLOAT_TO_FX32(40.0), CosFX(FLOAT_DEG_TO_IDX(0.0)));
            work->baseViewRange      = FLOAT_TO_FX32(47.0);
            work->objDrawDistance    = FLOAT_TO_FX32(72.0);
            work->objDespawnDistance = -FLOAT_TO_FX32(3.0);
            break;

        case SHIP_BOAT:
            work->field_24.x         = MultiplyFX(-FLOAT_TO_FX32(48.0), SinFX(FLOAT_DEG_TO_IDX(0.0)));
            work->field_24.z         = MultiplyFX(-FLOAT_TO_FX32(48.0), CosFX(FLOAT_DEG_TO_IDX(0.0)));
            work->baseViewRange      = FLOAT_TO_FX32(144.0);
            work->objDrawDistance    = FLOAT_TO_FX32(104.0);
            work->objDespawnDistance = -FLOAT_TO_FX32(32.0);
            break;

        case SHIP_SUBMARINE:
            work->field_24.x         = MultiplyFX(-FLOAT_TO_FX32(104.0), SinFX(FLOAT_DEG_TO_IDX(0.0)));
            work->field_24.z         = MultiplyFX(-FLOAT_TO_FX32(104.0), CosFX(FLOAT_DEG_TO_IDX(0.0)));
            work->baseViewRange      = FLOAT_TO_FX32(112.0);
            work->objDrawDistance    = FLOAT_TO_FX32(104.0);
            work->objDespawnDistance = -FLOAT_TO_FX32(44.0);
            break;
    }

    return work;
}

NONMATCH_FUNC void SailEventManager__LoadLayout(void)
{
    // https://decomp.me/scratch/eU9jc -> 93.12%
#ifdef NON_MATCHING
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;
    SailVoyageManager *voyage      = SailManager__GetWork()->voyageManager;
    SailManager *manager           = SailManager__GetWork();

    u16 segmentID = 1;
    u16 unknownID = 0;

    SBBFile *sbbFile = GetObjectDataWork(OBJDATAWORK_51)->fileData;

    if (manager->isRivalRace == FALSE && manager->missionID == 0)
    {
        if (voyage->segmentCount < 1)
            return;

        if (SailManager__GetShipType() == SHIP_SUBMARINE)
        {
            segmentID += 1;
            unknownID += 9;

            if (voyage->segmentCount < 2)
                return;
        }
    }

    for (u16 i = 0; i < segmentID; i++)
    {
        voyage->segmentList[i].blockID = -1;
    }

    if (manager->isRivalRace == TRUE || manager->missionID != 0)
    {
        u16 v8 = 0;
        u16 id = 0;

        SBBUnknownHeader *unknownHeader = (SBBUnknownHeader *)((u8 *)eventManager->sbbFile + eventManager->sbbFile->headerSize);
        SBBSegment *blockList2          = (SBBSegment *)((u8 *)unknownHeader + unknownHeader->headerSize);
        voyage->segmentCount            = unknownHeader->entries[0].field_4 + 1;

        for (; id < SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE - 1; id++)
        {
            SBBSegment *block2 = &blockList2[id];

            SailVoyageSegment *segment2 = &voyage->segmentList[id];

            segment2->header2EntryID = 0;
            segment2->blockID        = id;

            if (SailManager__GetShipType() == SHIP_BOAT)
            {
                segment2->turn           = 0;
                segment2->targetSeaAngle = block2->field_A << 8;
            }
            else
            {
                segment2->targetSeaAngle = 0;
                segment2->turn           = block2->field_A << 8;
            }

            segment2->type = 0;

            if ((block2->flags & 4) != 0)
            {
                segment2->header2EntryID = 12;
                SailJetRaceGoalHUD__Create(v8, id, FALSE);
                v8 = id;
            }

            if (id == unknownHeader->entries[0].field_4)
                break;
        }

        SailJetRaceGoalHUD__Create(v8, id, TRUE);

        s32 prevSegment                       = id - 1;
        voyage->segmentList[prevSegment].turn = 0;
        voyage->segmentList[id].turn          = 0;
        voyage->segmentList[prevSegment].type = SAILVOYAGESEGMENT_TYPE_26;
        voyage->segmentList[id].type          = SAILVOYAGESEGMENT_TYPE_27;

        if ((manager->flags & SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER) != 0 && manager->missionQuota != 0)
        {
            voyage->segmentList[prevSegment].type = SAILVOYAGESEGMENT_TYPE_14;
            voyage->segmentList[id].type          = SAILVOYAGESEGMENT_TYPE_15;
        }
    }
    else
    {
        if (manager->missionType == MISSION_TYPE_REACH_GOAL)
        {
            SailJetRaceGoalHUD__Create(0, voyage->segmentCount, TRUE);
            voyage->segmentList[voyage->segmentCount - 1].turn = 0;
            voyage->segmentList[voyage->segmentCount].turn     = 0;
            voyage->segmentList[voyage->segmentCount - 1].type = SAILVOYAGESEGMENT_TYPE_26;
            voyage->segmentList[voyage->segmentCount].type     = SAILVOYAGESEGMENT_TYPE_27;
        }

        for (; segmentID < SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE; segmentID++)
        {
            if (segmentID == voyage->segmentCount)
                break;

            SailVoyageSegment *voyageSegment = &voyage->segmentList[segmentID];

            SBBUnknownHeader *unknownHeader = (SBBUnknownHeader *)&((u8 *)sbbFile)[sbbFile->headerSize];
            SBBSegment *blockList           = (SBBSegment *)((u8 *)unknownHeader + unknownHeader->headerSize);

            SBBUnknown *unknownEntryList = unknownHeader->entries;

            s32 blockID;
            if (eventManager->field_34)
            {
                eventManager->field_34++;
                blockID                = eventManager->field_34;
                eventManager->field_34 = 0;
            }
            else
            {
                if (SailManager__GetShipType() != SHIP_SUBMARINE)
                {
                    u16 v21 = eventManager->field_42;
                    if (SailManager__GetShipType() != SHIP_BOAT)
                        v21 >>= 1;

                    if (v21 > SHIP_COUNT)
                        v21 = SHIP_COUNT;

                    if (eventManager->field_44)
                    {
                        unknownID              = _0218CD30[6][mtMathRandRepeat(16)];
                        eventManager->field_44 = 0;
                    }
                    else
                    {
                        if (_0218CD30[v21][mtMathRandRepeat(16)])
                        {
                            if (v21 && _0218CD30[5][mtMathRandRepeat(16)] != 0)
                            {
                                unknownID = 3;
                            }
                            else
                            {
                                unknownID = 0;
                            }
                        }
                        else
                        {
                            unknownID = _0218CD30[7][mtMathRandRepeat(16)];
                        }
                    }

                    switch (unknownID)
                    {
                        case 0:
                            eventManager->field_42++;
                            break;

                        case 3:
                            eventManager->field_44 = 1;
                            // fallthrough

                        case 6:
                        case 9:
                            eventManager->field_42 = 0;
                            break;

                        case 1:
                        case 2:
                        case 4:
                        case 5:
                        case 7:
                        case 8:
                        default:
                            break;
                    }
                }

                SBBUnknown *unknown = &unknownEntryList[unknownID + voyageSegment->unknown];

                u16 i;
                do
                {
                    u16 value = mtMathRand();

                    s32 unknown2ID            = value - unknown->field_4 * FX_DivS32(value, unknown->field_4);
                    SBBUnknown2 *unknown2List = (SBBUnknown2 *)&((u8 *)sbbFile)[sbbFile->headerSize + unknown->offset];

                    i = 1;
                    while (TRUE)
                    {
                        SBBSegment *curBlock = &blockList[unknown2List[unknown2ID].field_0 + i - 1];
                        if ((curBlock->flags & 1) == 0)
                            break;

                        i++;
                    }

                } while ((s32)(segmentID + i) > voyage->segmentCount);
            }

            SBBSegment *segment = &blockList[blockID];
            if ((segment->flags & 1) != 0)
                eventManager->field_34 = blockID;

            if (voyageSegment->type < SAILVOYAGESEGMENT_TYPE_14 && (segment->flags & 1) != 0)
                voyageSegment->type += SAILVOYAGESEGMENT_TYPE_7;

            voyageSegment->header2EntryID = unknownID;
            voyageSegment->blockID        = blockID;
            voyageSegment->targetSeaAngle = segment->field_A << 8;

            if (SailManager__GetShipType() == SHIP_SUBMARINE)
            {
                unknownID += 3;
                if (unknownID >= 84)
                    unknownID = 0;
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	ldr r11, [r0, #0xa0]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetWork
	str r0, [sp, #8]
	mov r1, #0
	mov r0, #0x33
	mov r7, #1
	str r1, [sp, #4]
	bl GetObjectFileWork
	ldr r1, [sp, #8]
	ldr r6, [r0, #0]
	ldr r1, [r1, #0xc]
	cmp r1, #0
	ldreq r0, [sp, #8]
	ldreqh r0, [r0, #0x14]
	cmpeq r0, #0
	bne _02154F90
	ldrh r0, [r5, #0xb8]
	cmp r0, #1
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02154F90
	ldr r0, [sp, #4]
	ldrh r2, [r5, #0xb8]
	add r1, r0, #9
	add r3, r7, #1
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	cmp r2, #2
	str r0, [sp, #4]
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02154F90:
	cmp r7, #0
	mov r4, #0
	bls _02154FC4
	ldr r3, =0x0000FFFF
	mov r0, #0x28
_02154FA4:
	ldr r2, [r5, #0xc0]
	add r1, r4, #1
	mla r2, r4, r0, r2
	mov r1, r1, lsl #0x10
	strh r3, [r2, #6]
	cmp r7, r1, lsr #16
	mov r4, r1, lsr #0x10
	bhi _02154FA4
_02154FC4:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #1
	beq _02154FE4
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x14]
	cmp r0, #0
	beq _02155144
_02154FE4:
	ldr r2, [r11, #0x48]
	mov r10, #0
	ldr r1, [r2, #0]
	mov r9, r10
	add r4, r2, r1
	ldrh r0, [r4, #8]
	ldr r1, [r2, r1]
	mov r11, r10
	add r0, r0, #1
	strh r0, [r5, #0xb8]
	add r6, r4, r1
_02155010:
	mov r0, #0xc
	mla r7, r9, r0, r6
	ldr r1, [r5, #0xc0]
	mov r0, #0x28
	mla r8, r9, r0, r1
	mov r0, #0
	strh r0, [r8, #8]
	strh r9, [r8, #6]
	bl SailManager__GetShipType
	cmp r0, #1
	mov r0, #0
	bne _02155054
	strh r0, [r8, #4]
	ldrh r0, [r7, #0xa]
	mov r0, r0, lsl #8
	strh r0, [r8, #0xa]
	b _02155064
_02155054:
	strh r0, [r8, #0xa]
	ldrh r0, [r7, #0xa]
	mov r0, r0, lsl #8
	strh r0, [r8, #4]
_02155064:
	strb r11, [r8]
	ldrh r0, [r7, #6]
	tst r0, #4
	beq _02155090
	mov r0, #0xc
	strh r0, [r8, #8]
	mov r0, r10
	mov r1, r9
	mov r2, r11
	bl SailJetRaceGoalHUD__Create
	mov r10, r9
_02155090:
	ldrh r0, [r4, #8]
	cmp r9, r0
	beq _021550B0
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0xff
	blo _02155010
_021550B0:
	mov r0, r10
	mov r1, r9
	mov r2, #1
	bl SailJetRaceGoalHUD__Create
	mov r0, #0x28
	sub r2, r9, #1
	mul r1, r2, r0
	ldr r2, [r5, #0xc0]
	mul r0, r9, r0
	add r2, r2, r1
	mov r3, #0
	strh r3, [r2, #4]
	ldr r2, [r5, #0xc0]
	mov r4, #0x1a
	add r2, r2, r0
	strh r3, [r2, #4]
	ldr r2, [r5, #0xc0]
	mov r3, #0x1b
	strb r4, [r2, r1]
	ldr r2, [r5, #0xc0]
	strb r3, [r2, r0]
	ldr r2, [sp, #8]
	ldr r2, [r2, #0x24]
	tst r2, #0x1000
	ldrne r2, [sp, #8]
	ldrne r2, [r2, #0x18]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [r5, #0xc0]
	mov r3, #0xe
	strb r3, [r2, r1]
	ldr r1, [r5, #0xc0]
	mov r2, #0xf
	strb r2, [r1, r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02155144:
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x12]
	cmp r0, #6
	bne _021551BC
	ldrh r1, [r5, #0xb8]
	mov r0, #0
	mov r2, #1
	bl SailJetRaceGoalHUD__Create
	ldrh r1, [r5, #0xb8]
	ldr r3, [r5, #0xc0]
	mov r0, #0x28
	sub r2, r1, #1
	mla r1, r2, r0, r3
	mov r3, #0
	strh r3, [r1, #4]
	ldrh r2, [r5, #0xb8]
	ldr r1, [r5, #0xc0]
	mov r8, #0x1a
	mla r1, r2, r0, r1
	strh r3, [r1, #4]
	ldrh r1, [r5, #0xb8]
	ldr r4, [r5, #0xc0]
	mov r3, #0x1b
	sub r1, r1, #1
	mul r2, r1, r0
	strb r8, [r4, r2]
	ldrh r1, [r5, #0xb8]
	ldr r2, [r5, #0xc0]
	mul r0, r1, r0
	strb r3, [r2, r0]
_021551BC:
	cmp r7, #0x100
	addhs sp, sp, #0xc
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021551C8:
	ldrh r0, [r5, #0xb8]
	cmp r7, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r7, r0, r4
	ldr r2, [r6, #0]
	ldrh r1, [r11, #0x34]
	add r3, r6, r2
	ldr r2, [r6, r2]
	str r0, [sp]
	cmp r1, #0
	add r9, r3, r2
	add r8, r3, #4
	beq _02155220
	add r0, r1, #1
	strh r0, [r11, #0x34]
	ldrh r2, [r11, #0x34]
	mov r0, #0
	strh r0, [r11, #0x34]
	b _02155438
_02155220:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02155394
	ldrh r4, [r11, #0x42]
	bl SailManager__GetShipType
	cmp r0, #1
	movne r0, r4, lsl #0xf
	movne r4, r0, lsr #0x10
	cmp r4, #4
	ldrh r0, [r11, #0x44]
	movhi r4, #4
	cmp r0, #0
	beq _02155298
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r4, [r2, #0]
	ldr r1, =0x3C6EF35F
	ldr r3, =_0218CD30
	mla r0, r4, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r1, r3, r1
	ldrb r1, [r1, #0x60]
	str r1, [sp, #4]
	str r0, [r2]
	mov r0, #0
	strh r0, [r11, #0x44]
	b _0215533C
_02155298:
	ldr r3, =_mt_math_rand
	ldr r0, =_0218CD30
	ldr r2, [r3, #0]
	ldr lr, =0x00196225
	ldr ip, =0x3C6EF35F
	add r10, r0, r4, lsl #4
	mla r1, r2, lr, ip
	str r1, [r3]
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r2, r2, #0xf
	ldrb r2, [r2, r10]
	cmp r2, #0
	beq _02155318
	cmp r4, #0
	beq _0215530C
	mla r2, r1, lr, ip
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r0, r0, r1
	ldrb r0, [r0, #0x50]
	str r2, [r3]
	cmp r0, #0
	movne r0, #3
	strne r0, [sp, #4]
	bne _0215533C
_0215530C:
	mov r0, #0
	str r0, [sp, #4]
	b _0215533C
_02155318:
	mla r2, r1, lr, ip
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r0, r0, r1
	ldrb r0, [r0, #0x70]
	str r0, [sp, #4]
	str r2, [r3]
_0215533C:
	ldr r0, [sp, #4]
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _02155394
_0215534C: // jump table
	b _02155374 // case 0
	b _02155394 // case 1
	b _02155394 // case 2
	b _02155384 // case 3
	b _02155394 // case 4
	b _02155394 // case 5
	b _0215538C // case 6
	b _02155394 // case 7
	b _02155394 // case 8
	b _0215538C // case 9
_02155374:
	ldrh r0, [r11, #0x42]
	add r0, r0, #1
	strh r0, [r11, #0x42]
	b _02155394
_02155384:
	mov r0, #1
	strh r0, [r11, #0x44]
_0215538C:
	mov r0, #0
	strh r0, [r11, #0x42]
_02155394:
	ldr r0, [sp]
	mov r4, #0xc
	ldrb r1, [r0, #1]
	ldr r0, [sp, #4]
	add r0, r0, r1
	add r8, r8, r0, lsl #3
_021553AC:
	ldr r0, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r2, [r0, #0]
	ldr r0, =0x3C6EF35F
	mla r1, r2, r1, r0
	ldr r0, =_mt_math_rand
	str r1, [r0]
	mov r0, r1, lsr #0x10
	mov r10, r0, lsl #0x10
	ldrh r1, [r8, #4]
	mov r0, r10, lsr #0x10
	bl FX_DivS32
	ldrh r3, [r8, #4]
	ldr r2, [r6, #0]
	ldr r1, [r8, #0]
	mul r0, r3, r0
	add r2, r6, r2
	add r2, r2, #4
	rsb r0, r0, r10, lsr #16
	add r1, r1, r2
	ldr r2, [r1, r0, lsl #2]
	mov r1, #0xc
	mla r1, r2, r1, r9
	mov r0, #1
_0215540C:
	mla r3, r0, r4, r1
	ldrh r3, [r3, #-6]
	tst r3, #1
	addne r0, r0, #1
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	bne _0215540C
	add r1, r7, r0
	ldrh r0, [r5, #0xb8]
	cmp r1, r0
	bgt _021553AC
_02155438:
	mov r0, #0xc
	mla r9, r2, r0, r9
	ldrh r0, [r9, #6]
	tst r0, #1
	ldr r0, [sp]
	strneh r2, [r11, #0x34]
	ldrb r1, [r0, #0]
	cmp r1, #0xe
	bhs _02155470
	ldrh r0, [r9, #6]
	tst r0, #1
	ldrne r0, [sp]
	addne r1, r1, #7
	strneb r1, [r0]
_02155470:
	ldr r1, [sp, #4]
	ldr r0, [sp]
	strh r1, [r0, #8]
	strh r2, [r0, #6]
	ldrh r0, [r9, #0xa]
	mov r1, r0, lsl #8
	ldr r0, [sp]
	strh r1, [r0, #0xa]
	bl SailManager__GetShipType
	cmp r0, #3
	bne _021554BC
	ldr r0, [sp, #4]
	add r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	cmp r0, #0x54
	movhs r0, #0
	strhs r0, [sp, #4]
_021554BC:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x100
	blo _021551C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailEventManager__LoadMapObjects(u16 id, fx32 voyageDistance)
{
    // https://decomp.me/scratch/UOm4n -> 90.31%
#ifdef NON_MATCHING
    u16 shipType;
    SailManager *manager;
    SailEventManager *eventManager;
    SailVoyageManager *voyageManager;

    eventManager  = SailManager__GetWork()->eventManager;
    voyageManager = SailManager__GetWork()->voyageManager;
    shipType      = SailManager__GetShipType();
    manager       = SailManager__GetWork();

    VecFx32 vec = { 0 };

    SailVoyageSegment *voyageSegment = &voyageManager->segmentList[id];

    if (eventManager->blockID != 0xFFFE)
    {
        eventManager->blockID++;
        return;
    }

    {
        SBBFile *sbbFile;
        if (manager->isRivalRace == TRUE || manager->missionID != 0)
            sbbFile = eventManager->sbbFile;
        else
            sbbFile = GetObjectDataWork(OBJDATAWORK_51)->fileData;

        SBBUnknownHeader *unknownHeader = (SBBUnknownHeader *)&((u8 *)sbbFile)[sbbFile->headerSize];
        SBBSegment *blockList           = (SBBSegment *)&((u8 *)sbbFile)[sbbFile->headerSize + unknownHeader->headerSize];

        if (id < 0xFF)
        {
            if (manager->isRivalRace == TRUE || manager->missionID)
            {
                if (id == voyageManager->segmentCount - 2)
                {
                    CreateSailBuoyForGoal(voyageSegment);
                }
            }
            else
            {
                if (id == voyageManager->segmentCount - 1)
                {
                    CreateSailBuoyForGoal(voyageSegment);
                }
            }

            if (shipType == SHIP_SUBMARINE)
            {
                for (u16 i = 0; i < 5; i++)
                {
                    CreateSailRockForSegment(voyageSegment, 0);
                }

                if (ObjDispRandRepeat(4) == 0)
                {
                    for (u16 i = 0; i < 4; i++)
                    {
                        CreateSailFishForSegment(voyageSegment);
                    }
                }
            }
            else
            {
                switch (voyageSegment[1].header2EntryID)
                {
                    default:
                        if (shipType != SHIP_BOAT)
                        {
                            for (u16 i = 0; i < 3; i++)
                            {
                                if (ObjDispRandRepeat(2) != 0)
                                    CreateSailRockForSegment(voyageSegment, 0);
                            }

                            if (ObjDispRandRepeat(2) != 0)
                                CreateSailSeagullForSegment(voyageSegment);
                        }
                        break;

                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                    case 10:
                    case 11:
                        if (ObjDispRandRepeat(2) != 0)
                            CreateSailRockForSegment(voyageSegment, 0);

                        CreateSailBuoyForSegment(voyageSegment);
                        break;

                    case 12:
                        CreateSailBuoyForGoal(voyageSegment);
                        break;
                }
            }

            switch (voyageSegment->type)
            {
                case SAILVOYAGESEGMENT_TYPE_18:
                    if (SailManager__GetShipType() == SHIP_BOAT || SailManager__GetShipType() == SHIP_SUBMARINE)
                    {
                        for (u16 i = 0; i < 8; i++)
                        {
                            CreateSailRockForSegment(voyageSegment, 2);
                        }
                    }
                    break;

                case SAILVOYAGESEGMENT_TYPE_19:
                    if (SailManager__GetShipType() == SHIP_BOAT || SailManager__GetShipType() == SHIP_SUBMARINE)
                    {
                        for (u16 i = 0; i < 8; i++)
                        {
                            CreateSailRockForSegment(voyageSegment, 2);
                        }

                        for (u16 i = 0; i < 16; i++)
                        {
                            CreateSailRockForSegment(voyageSegment, 1);
                        }
                    }
                    break;

                case SAILVOYAGESEGMENT_TYPE_16:
                    if (SailManager__GetShipType() == SHIP_BOAT)
                    {
                        for (u16 i = 0; i < 3; i++)
                        {
                            CreateSailIceForSegment(voyageSegment, 0);
                        }
                    }
                    // fall through

                case SAILVOYAGESEGMENT_TYPE_1:
                case SAILVOYAGESEGMENT_TYPE_2:
                case SAILVOYAGESEGMENT_TYPE_8:
                case SAILVOYAGESEGMENT_TYPE_9:
                    if (SailManager__GetShipType() != SHIP_BOAT)
                    {
                        for (u16 i = 0; i < 8; i++)
                        {
                            CreateSailIceForSegment(voyageSegment, 0);
                        }
                    }

                    if (voyageSegment->type == SAILVOYAGESEGMENT_TYPE_16)
                        return;

                    break;

                case SAILVOYAGESEGMENT_TYPE_17:
                    for (u16 i = 0; i < 8; i++)
                    {
                        CreateSailIceForSegment(voyageSegment, 0);
                    }

                    for (u16 i = 0; i < 32; i++)
                    {
                        CreateSailIceForSegment(voyageSegment, 1);
                    }
                    return;

                case SAILVOYAGESEGMENT_TYPE_0:
                case SAILVOYAGESEGMENT_TYPE_3:
                case SAILVOYAGESEGMENT_TYPE_4:
                case SAILVOYAGESEGMENT_TYPE_5:
                case SAILVOYAGESEGMENT_TYPE_6:
                case SAILVOYAGESEGMENT_TYPE_7:
                case SAILVOYAGESEGMENT_TYPE_10:
                case SAILVOYAGESEGMENT_TYPE_11:
                case SAILVOYAGESEGMENT_TYPE_12:
                case SAILVOYAGESEGMENT_TYPE_13:
                case SAILVOYAGESEGMENT_TYPE_14:
                case SAILVOYAGESEGMENT_TYPE_15:
                default:
                    break;
            }
        }

        if (voyageSegment->blockID == 0xFFFF)
            return;

        SBBSegment *block = blockList;
        if (eventManager->blockID != 0xFFFF)
            block = &blockList[eventManager->blockID];
        else
            block = &blockList[voyageSegment->blockID];

        SBBObject *object = (SBBObject *)((u8 *)block + block->offset);
        if (id >= voyageManager->segmentCount)
        {
            return;
        }

        for (u16 s = 0; s < block->count; s++, object++)
        {
            SailEventManagerObject *stageObject = SailEventManager__AllocateStageObject();
            MI_CpuClear16(stageObject, sizeof(*stageObject));
            stageObject->type           = object->type;
            stageObject->segmentID      = id;
            stageObject->angle          = voyageSegment->angle;
            stageObject->voyagePosition = object->voyagePosition;

            stageObject->voyagePosition.x = (stageObject->voyagePosition.x - 128) * _0218B9AC[shipType];
            stageObject->voyagePosition.y *= _0218B9B4[shipType];
            stageObject->voyagePosition.z = 4096 - 8 * stageObject->voyagePosition.z;
            stageObject->viewRange        = object->viewRange;
            stageObject->param            = object->param;
            stageObject->angle            = SailVoyageManager__GetAngleForSegmentPos(voyageSegment, stageObject->voyagePosition.z);
            stageObject->voyagePosition.z = MultiplyFX(stageObject->voyagePosition.z, SailVoyageManager__GetSegmentSize(voyageSegment));
            stageObject->objectRef        = object;
            stageObject->voyagePosition.z += voyageSegment->field_24;
            stageObject->voyagePosition.z += voyageManager->field_70;
            stageObject->word32 = manager->field_62;

            stageObject->flags = SAILMAPOBJECT_FLAG_10000000;
            stageObject->flags |= object->flags;

            if (voyageManager->field_70)
                stageObject->flags |= SAILMAPOBJECT_FLAG_8000000;

            if ((manager->flags & SAILMANAGER_FLAG_4) != 0)
            {
                stageObject->voyagePosition.x = -stageObject->voyagePosition.x;
                stageObject->flags |= SAILMAPOBJECT_FLAG_80000000;
            }
            NNS_FndAppendListObject(&eventManager->stageObjectList, stageObject);
        }

        if ((voyageSegment->type < SAILVOYAGESEGMENT_TYPE_7 || voyageSegment->type >= SAILVOYAGESEGMENT_TYPE_14) && voyageSegment->type < SAILVOYAGESEGMENT_TYPE_7)
            manager->field_62++;

        eventManager->blockID = 0xFFFF;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r11, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0xa0]
	str r0, [sp, #0xc]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
	bl SailManager__GetWork
	add r2, sp, #0x10
	mov r1, #0
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	ldr r2, [r5, #0xc0]
	mov r1, #0x28
	mla r8, r11, r1, r2
	ldr r1, [sp, #0xc]
	mov r9, r0
	ldrh r2, [r1, #0x36]
	ldr r1, =0x0000FFFE
	cmp r2, r1
	bne _0215556C
	ldr r0, [sp, #0xc]
	add r1, r1, #1
	strh r1, [r0, #0x36]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215556C:
	ldr r0, [r9, #0xc]
	cmp r0, #1
	beq _02155584
	ldrh r0, [r9, #0x14]
	cmp r0, #0
	beq _02155590
_02155584:
	ldr r0, [sp, #0xc]
	ldr r2, [r0, #0x48]
	b _0215559C
_02155590:
	mov r0, #0x33
	bl GetObjectFileWork
	ldr r2, [r0, #0]
_0215559C:
	ldr r1, [r2, #0]
	cmp r11, #0xff
	ldr r0, [r2, r1]
	add r1, r2, r1
	add r4, r1, r0
	bhs _0215598C
	ldr r0, [r9, #0xc]
	cmp r0, #1
	beq _021555CC
	ldrh r0, [r9, #0x14]
	cmp r0, #0
	beq _021555E8
_021555CC:
	ldrh r0, [r5, #0xb8]
	sub r0, r0, #2
	cmp r11, r0
	bne _02155600
	mov r0, r8
	bl CreateSailBuoyForGoal
	b _02155600
_021555E8:
	ldrh r0, [r5, #0xb8]
	sub r0, r0, #1
	cmp r11, r0
	bne _02155600
	mov r0, r8
	bl CreateSailBuoyForGoal
_02155600:
	ldr r0, [sp, #8]
	cmp r0, #3
	bne _02155684
	mov r6, #0
	mov r7, r6
_02155614:
	mov r0, r8
	mov r1, r7
	bl CreateSailRockForSegment
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #5
	blo _02155614
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #3
	bne _021557A8
	mov r6, #0
_02155664:
	mov r0, r8
	bl CreateSailFishForSegment
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #4
	blo _02155664
	b _021557A8
_02155684:
	ldrh r0, [r8, #0x30]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _021556C8
_02155694: // jump table
	b _021556C8 // case 0
	b _021556C8 // case 1
	b _021556C8 // case 2
	b _0215575C // case 3
	b _0215575C // case 4
	b _0215575C // case 5
	b _0215575C // case 6
	b _0215575C // case 7
	b _0215575C // case 8
	b _0215575C // case 9
	b _0215575C // case 10
	b _0215575C // case 11
	b _021557A0 // case 12
_021556C8:
	ldr r0, [sp, #8]
	cmp r0, #1
	beq _021557A8
	ldr r7, =_obj_disp_rand
	ldr r10, =0x3C6EF35F
	mov r6, #0
_021556E0:
	ldr r1, [r7, #0]
	ldr r0, =0x00196225
	mla r2, r1, r0, r10
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r7]
	tst r0, #1
	beq _02155710
	mov r0, r8
	mov r1, #0
	bl CreateSailRockForSegment
_02155710:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #3
	blo _021556E0
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	beq _021557A8
	mov r0, r8
	bl CreateSailSeagullForSegment
	b _021557A8
_0215575C:
	ldr r2, =_obj_disp_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	beq _02155794
	mov r0, r8
	mov r1, #0
	bl CreateSailRockForSegment
_02155794:
	mov r0, r8
	bl CreateSailBuoyForSegment
	b _021557A8
_021557A0:
	mov r0, r8
	bl CreateSailBuoyForGoal
_021557A8:
	ldrb r0, [r8, #0]
	cmp r0, #0x13
	addls pc, pc, r0, lsl #2
	b _0215598C
_021557B8: // jump table
	b _0215598C // case 0
	b _021558EC // case 1
	b _021558EC // case 2
	b _0215598C // case 3
	b _0215598C // case 4
	b _0215598C // case 5
	b _0215598C // case 6
	b _0215598C // case 7
	b _021558EC // case 8
	b _021558EC // case 9
	b _0215598C // case 10
	b _0215598C // case 11
	b _0215598C // case 12
	b _0215598C // case 13
	b _0215598C // case 14
	b _0215598C // case 15
	b _021558B8 // case 16
	b _02155934 // case 17
	b _02155808 // case 18
	b _0215584C // case 19
_02155808:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155820
	bl SailManager__GetShipType
	cmp r0, #3
	bne _0215598C
_02155820:
	mov r7, #0
	mov r6, #2
_02155828:
	mov r0, r8
	mov r1, r6
	bl CreateSailRockForSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _02155828
	b _0215598C
_0215584C:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155864
	bl SailManager__GetShipType
	cmp r0, #3
	bne _0215598C
_02155864:
	mov r7, #0
	mov r6, #2
_0215586C:
	mov r0, r8
	mov r1, r6
	bl CreateSailRockForSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _0215586C
	mov r7, #0
	mov r6, #1
_02155894:
	mov r0, r8
	mov r1, r6
	bl CreateSailRockForSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x10
	blo _02155894
	b _0215598C
_021558B8:
	bl SailManager__GetShipType
	cmp r0, #1
	bne _021558EC
	mov r7, #0
	mov r6, r7
_021558CC:
	mov r0, r8
	mov r1, r6
	bl CreateSailIceForSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _021558CC
_021558EC:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155920
	mov r7, #0
	mov r6, r7
_02155900:
	mov r0, r8
	mov r1, r6
	bl CreateSailIceForSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _02155900
_02155920:
	ldrb r0, [r8, #0]
	cmp r0, #0x10
	bne _0215598C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02155934:
	mov r5, #0
	mov r4, r5
_0215593C:
	mov r0, r8
	mov r1, r4
	bl CreateSailIceForSegment
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #8
	blo _0215593C
	mov r5, #0
	mov r4, #1
_02155964:
	mov r0, r8
	mov r1, r4
	bl CreateSailIceForSegment
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x20
	blo _02155964
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215598C:
	ldrh r3, [r8, #6]
	ldr r1, =0x0000FFFF
	cmp r3, r1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0xc]
	ldrh r2, [r0, #0x36]
	mov r0, #0xc
	cmp r2, r1
	mlane r4, r2, r0, r4
	mlaeq r4, r3, r0, r4
	ldrh r0, [r5, #0xb8]
	ldr r1, [r4, #0]
	cmp r11, r0
	add r6, r4, r1
	addhs sp, sp, #0x1c
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r4, #4]
	mov r10, #0
	cmp r0, #0
	bls _02155B54
	ldr r0, [sp, #8]
	ldr r2, =_0218B9AC
	mov r3, r0, lsl #1
	ldrh r0, [r2, r3]
	ldr r1, =_0218B9B4
	str r0, [sp, #4]
	ldrh r0, [r1, r3]
	str r0, [sp]
_02155A00:
	bl SailEventManager__AllocateStageObject
	mov r7, r0
	mov r0, #0
	mov r1, r7
	mov r2, #0x40
	bl MIi_CpuClear16
	ldrh r0, [r6, #0xc]
	add r3, r7, #0x10
	strh r0, [r7, #0x30]
	strh r11, [r7, #0x2c]
	ldrh r0, [r8, #2]
	strh r0, [r7, #0x2e]
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r7, #0x10]
	mov r0, r8
	sub r2, r1, #0x80
	ldr r1, [sp, #4]
	mul r1, r2, r1
	str r1, [r7, #0x10]
	ldr r2, [r7, #0x14]
	ldr r1, [sp]
	mul r1, r2, r1
	str r1, [r7, #0x14]
	ldr r1, [r7, #0x18]
	mov r1, r1, lsl #3
	rsb r1, r1, #0x1000
	str r1, [r7, #0x18]
	ldrh r1, [r6, #0x10]
	str r1, [r7, #0x28]
	ldr r1, [r6, #0x14]
	str r1, [r7, #0x38]
	ldr r1, [r7, #0x18]
	bl SailVoyageManager__GetAngleForSegmentPos
	strh r0, [r7, #0x2e]
	mov r0, r8
	bl SailVoyageManager__GetSegmentSize
	ldr r1, [r7, #0x18]
	smull r3, r2, r1, r0
	mov r0, #0x800
	adds r1, r3, r0
	mov r0, #0
	adc r0, r2, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r7, #0x18]
	str r6, [r7, #0x3c]
	ldr r1, [r7, #0x18]
	ldr r0, [r8, #0x24]
	add r1, r1, r0
	str r1, [r7, #0x18]
	ldr r0, [r5, #0x70]
	add r0, r1, r0
	str r0, [r7, #0x18]
	ldrh r0, [r9, #0x62]
	strh r0, [r7, #0x32]
	mov r0, #0x10000000
	str r0, [r7, #0x34]
	ldrh r1, [r6, #0xe]
	orr r0, r1, #0x10000000
	str r0, [r7, #0x34]
	ldr r0, [r5, #0x70]
	cmp r0, #0
	ldrne r0, [r7, #0x34]
	orrne r0, r0, #0x8000000
	strne r0, [r7, #0x34]
	ldr r0, [r9, #0x24]
	tst r0, #4
	beq _02155B2C
	ldr r0, [r7, #0x10]
	rsb r0, r0, #0
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x34]
	orr r0, r0, #0x80000000
	str r0, [r7, #0x34]
_02155B2C:
	ldr r0, [sp, #0xc]
	mov r1, r7
	bl NNS_FndAppendListObject
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #4]
	add r6, r6, #0x18
	mov r10, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _02155A00
_02155B54:
	ldrb r0, [r8, #0]
	cmp r0, #7
	blo _02155B68
	cmp r0, #0xe
	blo _02155B78
_02155B68:
	cmp r0, #7
	ldrloh r0, [r9, #0x62]
	addlo r0, r0, #1
	strloh r0, [r9, #0x62]
_02155B78:
	ldr r1, =0x0000FFFF
	ldr r0, [sp, #0xc]
	strh r1, [r0, #0x36]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SailEventManager__LoadObject(SBBObject *object)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    SailEventManagerObject *tempObject = SailEventManager__AllocateTempObject();
    MI_CpuClear16(tempObject, sizeof(*tempObject));

    tempObject->type           = object->type;
    tempObject->voyagePosition = object->voyagePosition;
    tempObject->viewRange      = FX32_FROM_WHOLE(object->viewRange);
    tempObject->flags          = SAILMAPOBJECT_FLAG_10000000;
    tempObject->flags |= SAILMAPOBJECT_FLAG_40000000;
    tempObject->param = object->param;

    NNS_FndAppendListObject(&eventManager->tempObjectList, tempObject);
}

BOOL SailEventManager__ViewCheck(VecFx32 *position, s32 viewRange)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    VecFx32 unknownPos;
    VEC_Subtract(&eventManager->field_24, position, &unknownPos);

    s32 range = (eventManager->baseViewRange >> 8) + (viewRange >> 8);

    s32 posSq   = MultiplyFX(unknownPos.x >> 8, unknownPos.x >> 8) + MultiplyFX(unknownPos.z >> 8, unknownPos.z >> 8);
    s32 rangeSq = MultiplyFX(range, range);

    if (posSq < rangeSq)
    {
        if (position->y < -180 * _0218B9B4[SailManager__GetShipType()] || position->y > 96 * _0218B9B4[SailManager__GetShipType()])
        {
            return TRUE;
        }

        return FALSE;
    }

    return TRUE;
}

void SailEventManager__RemoveEntry(SailEventManagerObject *object)
{
    SailManager *manager = SailManager__GetWork();

    if (manager != NULL)
    {
        SailEventManager *eventManager = manager->eventManager;

        if (eventManager != NULL)
        {
            object->flags &= ~SAILMAPOBJECT_FLAG_10000000;

            if (object->objTask != NULL)
                eventManager->activeObjectCount--;

            object->objTask  = NULL;
            object->ringTask = NULL;

            if ((object->flags & SAILMAPOBJECT_FLAG_40000000) == 0)
                NNS_FndRemoveListObject(&eventManager->stageObjectList, object);
            else
                NNS_FndRemoveListObject(&eventManager->tempObjectList, object);
        }
    }
}

SailEventManagerObject *SailEventManager__CreateObject(u16 type, VecFx32 *position)
{
    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    SailEventManagerObject *object = SailEventManager__AllocateStageObject();

    SailVoyageSegment *segment = &voyageManager->segmentList[FX32_TO_WHOLE(position->z) >> 7];

    MI_CpuClear16(object, sizeof(*object));
    object->type      = type;
    object->segmentID = FX32_TO_WHOLE(position->z) >> 7;

    object->voyagePosition = *position;
    object->objectRef      = NULL;

    s32 segmentPos = FX_Div(object->voyagePosition.z & 0x7FFFF, SailVoyageManager__GetSegmentSize(segment));
    object->angle  = SailVoyageManager__GetAngleForSegmentPos(segment, segmentPos);
    SailVoyageManager__Func_2158888(segment, segmentPos, &object->position.x, &object->position.z);

    object->position.x += MultiplyFX(object->voyagePosition.x, CosFX(object->angle));
    object->position.z += MultiplyFX(object->voyagePosition.x, SinFX(object->angle));
    VEC_Subtract(&object->position, &voyageManager->position, &object->position);

    object->flags = SAILMAPOBJECT_FLAG_10000000;

    return object;
}

void SailEventManager__CreateObject2(SailEventManagerObject *object)
{
    u16 shipType                   = SailManager__GetShipType();
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    if ((object->flags & SAILMAPOBJECT_FLAG_20000000) == 0)
        NNS_FndAppendListObject(&eventManager->stageObjectList, object);

    if (object->type == SAILMAPOBJECT_RING)
    {
        SailRing *ring = SailRingManager_CreateStageRing(&object->position);
        if ((object->flags & SAILMAPOBJECT_FLAG_20000000) == 0)
            object->ringTask = ring;
    }
    else
    {
        if (shipType == SHIP_HOVER)
            shipType = 0;

        if (shipType == SHIP_SUBMARINE)
            shipType--;

        StageTask *objTask = sailObjectSpawnList[shipType][object->type](object);
        if ((object->flags & SAILMAPOBJECT_FLAG_20000000) == 0)
            object->objTask = objTask;
    }
}

void SailEventManager__Destructor(Task *task)
{
    SailManager *manager = SailManager__GetWork();

    SailEventManager *work = TaskGetWork(task, SailEventManager);

    if (work->stageObjectEntries != NULL)
    {
        if (manager->isRivalRace)
            HeapFree(HEAP_USER, work->stageObjectEntries);
        else
            HeapFree(HEAP_SYSTEM, work->stageObjectEntries);
    }
    work->stageObjectEntries = NULL;

    if (work->tempObjectEntries != NULL)
        HeapFree(HEAP_USER, work->tempObjectEntries);
    work->tempObjectEntries = NULL;

    if (work->sbbFile != NULL)
    {
        HeapFree(HEAP_USER, work->sbbFile);
    }
    else
    {
        ObjDataRelease(GetObjectFileWork(OBJDATAWORK_51));
    }
}

void SailEventManager__Main(void)
{
    SailEventManager *work = TaskGetWorkCurrent(SailEventManager);

    SailVoyageManager *voyageManager = SailManager__GetWork()->voyageManager;

    SailEventManagerObject *object;
    SailManager *manager = SailManager__GetWork();

    SailPlayer *playerWorker = NULL;
    StageTask *player        = SailManager__GetWork()->sailPlayer;

    s32 voyagePos = SailVoyageManager__GetVoyagePos();

    u16 shipType         = SailManager__GetShipType();
    fx32 objDrawDistance = work->objDrawDistance;
    if (player != NULL)
        playerWorker = GetStageTaskWorker(SailManager__GetWork()->sailPlayer, SailPlayer);

    if ((manager->flags & SAILMANAGER_FLAG_800) == 0)
    {
        if (shipType == SHIP_HOVER)
            shipType = SHIP_JET;

        if (shipType == SHIP_SUBMARINE)
        {
            shipType--;
        }

        object = (SailEventManagerObject *)work->stageObjectList.headObject;

        if (playerWorker != NULL)
        {
            if (playerWorker->seaAngle2 != 0)
            {
                objDrawDistance -= MultiplyFX(FLOAT_TO_FX32(48.0), playerWorker->seaAngle2 >> 2);
            }
        }

        s32 objectSpawnPos = voyagePos + objDrawDistance;
        while (TRUE)
        {
            if (object != NULL)
            {
                SailEventManagerObject *next = (SailEventManagerObject *)NNS_FndGetNextListObject(&work->stageObjectList, object);

                if ((object->flags & SAILMAPOBJECT_FLAG_8000000) != 0)
                    object->voyagePosition.z += voyageManager->field_74;

                if (object->ringTask == NULL && object->objTask == NULL)
                {
                    if (objectSpawnPos > object->voyagePosition.z)
                    {
                        VecFx32 position;
                        VecFx32 unknownVec;

                        SailVoyageSegment *voyageSegment = &voyageManager->segmentList[object->segmentID];

                        unknownVec = object->voyagePosition;
                        unknownVec.z -= voyageSegment->field_24;

                        position = unknownVec;

                        SailVoyageManager__Func_2158888(voyageSegment, FX_Div(unknownVec.z, SailVoyageManager__GetSegmentSize(voyageSegment)), &position.x, &position.z);
                        position.x += MultiplyFX(unknownVec.x, CosFX((s32)(u16)-object->angle));
                        position.z += MultiplyFX(unknownVec.x, SinFX((s32)(u16)-object->angle));
                        VEC_Subtract(&position, &voyageManager->position, &position);

                        object->position = position;
                        object->ringTask = NULL;
                        object->objTask  = NULL;

                        if (((object->flags & (SAILMAPOBJECT_FLAG_100 | SAILMAPOBJECT_FLAG_200 | SAILMAPOBJECT_FLAG_400)) >> 8) > manager->field_5E)
                        {
                            SailEventManager__RemoveEntry(object);
                        }
                        else
                        {
                            if (object->type == SAILMAPOBJECT_RING)
                            {
                                object->ringTask = SailRingManager_CreateStageRing(&position);
                            }
                            else
                            {
                                if (sailObjectSpawnList[shipType][object->type] != NULL)
                                {
                                    object->objTask = sailObjectSpawnList[shipType][object->type](object);
                                    work->activeObjectCount++;
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (object->type == SAILMAPOBJECT_RING)
                    {
                        if ((object->ringTask->flags & SAILRING_FLAG_ALLOCATED) == 0)
                        {
                            SailEventManager__RemoveEntry(object);
                        }
                        else
                        {
                            if (voyagePos + work->objDespawnDistance >= object->voyagePosition.z || voyagePos + work->objDrawDistance < object->voyagePosition.z)
                            {
                                SailRingManager_DestroyRing(object->ringTask);
                                SailEventManager__RemoveEntry(object);
                            }
                        }
                    }
                }

                object = next;
            }
            else
            {
                VecFx32 objectDistance = { 0 };
                VecFx32 voyagePos      = { 0 };

                switch (SailManager__GetShipType())
                {
                    case SHIP_JET:
                    case SHIP_HOVER:
                        work->field_24.x = MultiplyFX(-FLOAT_TO_FX32(40.0), SinFX(voyageManager->angle));
                        work->field_24.z = MultiplyFX(-FLOAT_TO_FX32(40.0), CosFX(voyageManager->angle));
                        break;

                    case SHIP_BOAT:
                        work->field_24.x = MultiplyFX(-FLOAT_TO_FX32(48.0), SinFX(voyageManager->angle));
                        work->field_24.z = MultiplyFX(-FLOAT_TO_FX32(48.0), CosFX(voyageManager->angle));
                        break;

                    case SHIP_SUBMARINE:
                        work->field_24.x = MultiplyFX(-FLOAT_TO_FX32(104.0), SinFX(voyageManager->angle));
                        work->field_24.z = MultiplyFX(-FLOAT_TO_FX32(104.0), CosFX(voyageManager->angle));
                        break;
                }

                VEC_Add(&voyagePos, &voyageManager->position, &voyagePos);

                SailEventManagerObject *curObject = (SailEventManagerObject *)work->tempObjectList.headObject;
                while (TRUE)
                {
                    if (curObject == NULL)
                        break;

                    VEC_Subtract(&voyagePos, &curObject->voyagePosition, &objectDistance);

                    s32 range    = (work->baseViewRange >> 8) + (curObject->viewRange >> 8);
                    fx32 posSq   = MultiplyFX(objectDistance.x >> 8, objectDistance.x >> 8) + MultiplyFX(objectDistance.z >> 8, objectDistance.z >> 8);
                    fx32 rangeSq = MultiplyFX(range, range);
                    if (curObject->objTask == NULL && posSq < rangeSq)
                    {
                        VEC_Subtract(&curObject->voyagePosition, &voyageManager->position, &curObject->position);
                        curObject->objTask = CreateSailIsland(curObject);
                    }

                    curObject = (SailEventManagerObject *)NNS_FndGetNextListObject(&work->tempObjectList, curObject);
                }
                return;
            }
        }
    }
}

SailEventManagerObject *SailEventManager__AllocateStageObject(void)
{
    SailEventManagerObject *object;

    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    u16 startID = eventManager->field_20;
    while (TRUE)
    {
        eventManager->field_20 &= (SAILEVENTMANAGER_STAGE_OBJ_LIST_SIZE - 1);

        SailEventManagerObject *objectList = eventManager->stageObjectEntries;
        object                             = &objectList[eventManager->field_20++];

        if ((object->flags & SAILMAPOBJECT_FLAG_10000000) == 0)
            return object;

        if (startID == eventManager->field_20)
            break;
    }

    return NULL;
}

SailEventManagerObject *SailEventManager__AllocateTempObject(void)
{
    SailEventManager *eventManager = SailManager__GetWork()->eventManager;

    for (u16 i = 0; i < SAILEVENTMANAGER_TEMP_OBJ_LIST_SIZE; i++)
    {
        SailEventManagerObject *object = &eventManager->tempObjectEntries[i];
        if ((object->flags & SAILMAPOBJECT_FLAG_10000000) == 0)
            return object;
    }

    return NULL;
}