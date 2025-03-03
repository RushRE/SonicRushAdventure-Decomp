#include <sail/sailVoyageManager.h>
#include <sail/sailManager.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapUnknown204A9E4.h>
#include <seaMap/seaMapUnknown204AB60.h>
#include <sail/sailPlayer.h>
#include <game/object/obj.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED u32 _0218BBC0[4];

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

    if (manager->isRivalRace)
        work->segmentList = HeapAllocHead(HEAP_USER, 0x100 * sizeof(SailVoyageSegment));
    else
        work->segmentList = HeapAllocHead(HEAP_SYSTEM, 0x100 * sizeof(SailVoyageSegment));

    MI_CpuClear16(work->segmentList, 0x100 * sizeof(SailVoyageSegment));

    if (SailManager__GetShipType() == SHIP_BOAT)
        work->word3C = 0x3C00;

    if (manager->isRivalRace || manager->missionType != 0)
        return work;

    if (state->seaMapNodeList.nodes.numObjects != 0)
    {
        SeaMapManager__Func_2045BF8(work->dword54, &work->int5C, &work->dword60);
        work->dword64 = work->int5C;
        work->dword68 = work->dword60;
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
#ifdef NON_MATCHING

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
	ldr r0, =_0218BBC0
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
#ifdef NON_MATCHING

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
	ldr r0, =_0218BBC0
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
	bl SeaMapUnknown204AB60__Func_204ABBC
	ldr r1, [sp, #8]
	cmp r1, r0
	bhs _02157760
_0215767C:
	ldr r0, [sp, #8]
	bl SeaMapUnknown204AB60__Func_204ABCC
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
	bl SailVoyageManager__Func_215776C
	b _02157740
_02157704:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__Func_215794C
	mov r6, r0
	b _02157740
_0215770E:
	ldr r0, [sp, #0xc]
	bl SailVoyageManager__Func_215799C
	mov r7, r0
	b _02157740
_02157718:
	ldr r0, [sp, #0xc]
	mov r1, r4
	bl SailVoyageManager__Func_2157894
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
	bl SeaMapUnknown204AB60__Func_204ABBC
	ldr r1, [sp, #8]
	cmp r1, r0
	blo _0215767C
_02157760:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailVoyageManager__Func_215776C(void *a1, u32 segmentCount)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r1
	bl SailManager__GetWork
	mov r6, r0
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	cmp r4, #1
	bhi _021577A2
	mov r2, r0
	add r2, #0xc0
	mov r1, #0x28
	mul r1, r4
	ldr r3, [r2, #0]
	mov r4, #2
	ldrb r2, [r3, r1]
	add r3, #0x28
	strb r2, [r3]
	mov r2, r0
	add r2, #0xc0
	ldr r2, [r2, #0]
	ldrb r1, [r2, r1]
	add r2, #0x50
	strb r1, [r2]
_021577A2:
	ldr r1, [r5, #0x10]
	cmp r1, #0
	beq _021577B2
	cmp r1, #1
	beq _021577DE
	cmp r1, #2
	beq _0215780C
	b _0215785C
_021577B2:
	mov r1, r0
	add r1, #0xb8
	mov r2, r0
	strh r4, [r1]
	add r2, #0xc0
	sub r3, r4, #1
	ldr r7, [r2, #0]
	mov r2, #0x28
	mov r6, r3
	mov r1, #0x1a
	mul r6, r2
	strb r1, [r7, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	mov r6, #0x1b
	mul r1, r2
	strb r6, [r3, r1]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	b _0215785C
_021577DE:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	sub r7, r4, #1
	mov r3, #0x28
	mov r2, #0xe
	mul r3, r7
	strb r2, [r1, r3]
	mov r2, r0
	add r2, #0xc0
	ldr r3, [r2, #0]
	mov r2, #0x28
	mov r1, #0xf
	mul r2, r4
	strb r1, [r3, r2]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	ldr r1, [r5, #0x14]
	str r1, [r6, #4]
	b _0215785C
_0215780C:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	ldr r1, [r5, #8]
	mov r5, r4
	str r1, [r0, #0x58]
	mov r1, #0x28
	mul r5, r1
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	ldrb r1, [r3, r5]
	cmp r1, #5
	bhi _02157840
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02157834: // jump table
    DCD 0xE000A
    DCD 0x12000E
    DCD 0x12000A
	// .hword _02157840 - _02157834 - 2 // case 0
	// .hword _02157844 - _02157834 - 2 // case 1
	// .hword _02157844 - _02157834 - 2 // case 2
	// .hword _02157848 - _02157834 - 2 // case 3
	// .hword _02157840 - _02157834 - 2 // case 4
	// .hword _02157848 - _02157834 - 2 // case 5
_02157840:
	mov r2, #0x15
	b _0215784A
_02157844:
	mov r2, #0x11
	b _0215784A
_02157848:
	mov r2, #0x13
_0215784A:
	sub r7, r4, #1
	mov r6, #0x28
	sub r1, r2, #1
	mul r6, r7
	strb r1, [r3, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	strb r2, [r1, r5]
_0215785C:
	sub r1, r4, #1
	mov r3, r1
	mov r1, r0
	add r1, #0xc0
	mov r5, #0x28
	ldr r1, [r1, #0]
	mul r3, r5
	mov r2, #0
	add r1, r1, r3
	strh r2, [r1, #0xa]
	mov r1, r4
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	mul r1, r5
	add r4, r4, r1
	strh r2, [r4, #0xa]
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	add r0, #0xc0
	add r3, r4, r3
	strh r2, [r3, #4]
	ldr r0, [r0, #0]
	add r0, r0, r1
	strh r2, [r0, #4]
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SailVoyageManager__Func_2157894(void *a1, u32 segmentCount)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r1
	bl SailManager__GetWork
	mov r6, r0
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0, #0]
	cmp r4, #1
	bhi _021578AE
	mov r4, #2
_021578AE:
	ldr r1, [r5, #0x10]
	cmp r1, #0
	beq _021578BA
	cmp r1, #1
	beq _021578EC
	b _02157916
_021578BA:
	mov r1, r0
	add r1, #0xb8
	strh r4, [r1]
	mov r1, r0
	add r1, #0xc0
	ldr r1, [r1, #0]
	sub r7, r4, #1
	mov r3, #0x28
	mov r2, #0x16
	mul r3, r7
	strb r2, [r1, r3]
	mov r2, r0
	add r2, #0xc0
	ldr r3, [r2, #0]
	mov r2, #0x28
	mov r1, #0x17
	mul r2, r4
	strb r1, [r3, r2]
	ldr r2, [r5, #0x14]
	mov r1, #0x10
	ldrsh r1, [r2, r1]
	str r1, [r6, #8]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
	b _02157916
_021578EC:
	mov r1, r0
	add r1, #0xb8
	mov r2, r0
	strh r4, [r1]
	add r2, #0xc0
	sub r3, r4, #1
	ldr r7, [r2, #0]
	mov r2, #0x28
	mov r6, r3
	mov r1, #0x18
	mul r6, r2
	strb r1, [r7, r6]
	mov r1, r0
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	mov r6, #0x19
	mul r1, r2
	strb r6, [r3, r1]
	ldr r1, [r5, #8]
	str r1, [r0, #0x58]
_02157916:
	sub r1, r4, #1
	mov r3, r1
	mov r1, r0
	add r1, #0xc0
	mov r5, #0x28
	ldr r1, [r1, #0]
	mul r3, r5
	mov r2, #0
	add r1, r1, r3
	strh r2, [r1, #0xa]
	mov r1, r4
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	mul r1, r5
	add r4, r4, r1
	strh r2, [r4, #0xa]
	mov r4, r0
	add r4, #0xc0
	ldr r4, [r4, #0]
	add r0, #0xc0
	add r3, r4, r3
	strh r2, [r3, #4]
	ldr r0, [r0, #0]
	add r0, r0, r1
	strh r2, [r0, #4]
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

s32 SailVoyageManager__Func_215794C(SailVoyageManager *work)
{
    SailManager *manager = SailManager__GetWork();

    switch (work->field_C.y)
    {
        case 0:
            return 0;

        case 1:
            return 5;

        case 2:
            return 3;

        case 3:
            if (SailManager__GetShipType() == SHIP_HOVER)
                return 2;
            else
                return 1;

        case 4:
            return 6;

        case 5:
            return 4;
    }

    return 0;
}

u8 SailVoyageManager__Func_215799C(SailVoyageManager *work)
{
    SailManager *manager = SailManager__GetWork();

    switch (work->field_C.y)
    {
        case 0:
        case 1:
            return 0;

        case 2:
            return work->field_C.y - 1;

        case 3:
            return work->field_C.y - 1;
    }

    return 0;
}

NONMATCH_FUNC void SailVoyageManager__SetupVoyage(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	bl SailManager__GetWork
	mov r5, r0
	ldr r6, =gameState
	bl SailManager__GetWork
	add r0, #0x98
	ldr r4, [r0, #0]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _02157A04
	ldrh r0, [r5, #0x12]
	cmp r0, #0
	bne _02157A04
	add r6, #0x8c
	ldrh r0, [r6, #0]
	cmp r0, #0
	beq _02157A04
	mov r0, r4
	bl SailVoyageManager__Func_21574B4
_02157A04:
	ldrh r0, [r5, #0x12]
	cmp r0, #6
	bne _02157A8A
	mov r0, r4
	mov r1, #0x1a
	add r0, #0xb8
	strh r1, [r0]
	bl SailManager__GetShipType
	cmp r0, #1
	bne _02157A22
	mov r0, r4
	mov r1, #0x12
	add r0, #0xb8
	strh r1, [r0]
_02157A22:
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02157A32
	mov r0, r4
	mov r1, #0x1e
	add r0, #0xb8
	strh r1, [r0]
_02157A32:
	mov r0, r4
	add r0, #0xb8
	ldrh r1, [r0, #0]
	mov r6, #0
	add r0, r1, #1
	cmp r0, #0
	ble _02157A66
	ldr r7, =0x000005DC
	mov r0, #0x28
_02157A44:
	mov r1, r4
	add r1, #0xc0
	ldr r2, [r1, #0]
	mov r1, r6
	mul r1, r0
	ldr r3, [r5, r7]
	add r1, r2, r1
	strb r3, [r1, #1]
	add r1, r6, #1
	lsl r1, r1, #0x10
	lsr r6, r1, #0x10
	mov r1, r4
	add r1, #0xb8
	ldrh r1, [r1, #0]
	add r2, r1, #1
	cmp r6, r2
	blt _02157A44
_02157A66:
	mov r2, r4
	add r2, #0xc0
	sub r1, r1, #1
	ldr r5, [r2, #0]
	mov r3, r1
	mov r2, #0x28
	mov r1, r4
	mov r0, #0x1a
	mul r3, r2
	strb r0, [r5, r3]
	add r1, #0xc0
	ldr r3, [r1, #0]
	mov r1, r4
	add r1, #0xb8
	ldrh r1, [r1, #0]
	mov r0, #0x1b
	mul r2, r1
	strb r0, [r3, r2]
_02157A8A:
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02157AC0
	mov r0, #2
	lsl r0, r0, #0xe
	strh r0, [r4, #0x34]
	ldrh r0, [r4, #0x34]
	mov r1, #0
	mov r3, #0x28
	strh r0, [r4, #0x36]
	mov r0, r1
_02157AA2:
	mov r2, r4
	add r2, #0xc0
	ldr r5, [r2, #0]
	mov r2, r1
	mul r2, r3
	add r2, r5, r2
	strh r0, [r2, #4]
	mov r2, r4
	add r2, #0xb8
	add r1, r1, #1
	lsl r1, r1, #0x10
	ldrh r2, [r2, #0]
	lsr r1, r1, #0x10
	cmp r1, r2
	bls _02157AA2
_02157AC0:
	bl SailEventManager__ProcessSBB
	mov r0, r4
	bl SailVoyageManager__LinkSegments
	mov r0, #0
	mov r1, r0
	bl SailEventManager__LoadMapObjects
	mov r0, #1
	mov r1, #0
	bl SailEventManager__LoadMapObjects
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

s32 SailVoyageManager__Func_2157AE4(void)
{
    SailManager *manager = SailManager__GetWork();

    return manager->voyageManager->voyagePos;
}

VecFx32 *SailVoyageManager__Func_2157AF4(void)
{
    SailManager *manager = SailManager__GetWork();

    return &manager->voyageManager->field_28;
}

s32 SailVoyageManager__Func_2157B04(void)
{
    SailManager *manager = SailManager__GetWork();

    return manager->voyageManager->angle;
}

s32 SailVoyageManager__Func_2157B14(SailVoyageSegment *segment)
{
    return 0x80000;
}

void SailVoyageManager__Main(void)
{
    SailVoyageManager *work = TaskGetWorkCurrent(SailVoyageManager);

    SailManager *manager = SailManager__GetWork();

    SailVoyageManager__Func_2157C34(work);

    if (work->field_BC)
    {
        work->field_BC -= FLOAT_TO_FX32(0.25);
        if (work->field_BC < FLOAT_TO_FX32(0.0))
            work->field_BC = FLOAT_TO_FX32(0.0);
    }

    if (SailManager__GetShipType() != SHIP_SUBMARINE)
    {
        u16 segmentID      = FX32_TO_WHOLE(work->voyagePos) >> 7;
        u16 otherSegmentID = FX32_TO_WHOLE(work->field_48) >> 7;

        switch (work->segmentList[segmentID].field_0)
        {
            case 5:
            case 12:
            case 18:
            case 19:
                work->field_BA |= 2;
                break;

            default:
                if (manager->field_5A == 3)
                    manager->field_5A = 2;
                break;

            case 11:
            case 4:
                if (otherSegmentID == 0 || (work->segmentList[otherSegmentID].field_0 != 4 && work->segmentList[otherSegmentID].field_0 != 11))
                {
                    manager->field_5A = 3;
                }
                break;
        }

        if (!work->segmentList[segmentID].field_0)
            work->field_BA &= ~2;

        if ((work->field_BA & 2) != 0)
        {
            work->field_BC += FLOAT_TO_FX32(0.5);
            if (work->field_BC > FLOAT_TO_FX32(10.0))
                work->field_BC = FLOAT_TO_FX32(10.0);
        }
    }
}