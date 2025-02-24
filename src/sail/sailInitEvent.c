#include <sail/sailInitEvent.h>
#include <game/game/gameState.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailEventEntry_
{
    s8 type;
    s8 courseID;
    s8 unknown;
    s8 shipType;
} SailEventEntry;

// --------------------
// VARIABLES
// --------------------

static const s32 _0211160C[] = { 1080000, 108000, 18000, 1800, 300, 30, 10, 1 };

static const SailEventEntry sailMissionList[SAILMISSION_COUNT] = {
    // Training
    [SAILMISSION_TRAINING_JET_INTRO] = { MISSION_TYPE_TRAINING, 1, 1, SHIP_JET },
    [SAILMISSION_TRAINING_JET]       = { MISSION_TYPE_TRAINING, 1, 0, SHIP_JET },
    [SAILMISSION_TRAINING_BOAT]      = { MISSION_TYPE_TRAINING, 2, 0, SHIP_BOAT },
    [SAILMISSION_TRAINING_HOVER]     = { MISSION_TYPE_TRAINING, 3, 0, SHIP_HOVER },
    [SAILMISSION_TRAINING_SUBMARINE] = { MISSION_TYPE_TRAINING, 4, 0, SHIP_SUBMARINE },

    // Missions
    [SAILMISSION_MISSION_JET]       = { MISSION_TYPE_REACH_GOAL, 0, 2, SHIP_JET },
    [SAILMISSION_MISSION_BOAT]      = { MISSION_TYPE_REACH_GOAL, 0, 2, SHIP_BOAT },
    [SAILMISSION_MISSION_HOVER]     = { MISSION_TYPE_REACH_GOAL, 0, 2, SHIP_HOVER },
    [SAILMISSION_MISSION_SUBMARINE] = { MISSION_TYPE_REACH_GOAL, 0, 2, SHIP_SUBMARINE },

    // Viking Cup
    [SAILMISSION_VIKINGCUP_JET_ACT1]       = { MISSION_TYPE_VIKINGCUP_TIME, 51, 2, SHIP_JET },
    [SAILMISSION_VIKINGCUP_JET_ACT2]       = { MISSION_TYPE_VIKINGCUP_TIME, 52, 2, SHIP_JET },
    [SAILMISSION_VIKINGCUP_BOAT_ACT1]      = { MISSION_TYPE_VIKINGCUP_SCORE, 61, 2, SHIP_BOAT },
    [SAILMISSION_VIKINGCUP_BOAT_ACT2]      = { MISSION_TYPE_VIKINGCUP_SCORE, 62, 2, SHIP_BOAT },
    [SAILMISSION_VIKINGCUP_HOVER_ACT1]     = { MISSION_TYPE_VIKINGCUP_SCORE, 71, 2, SHIP_HOVER },
    [SAILMISSION_VIKINGCUP_HOVER_ACT2]     = { MISSION_TYPE_VIKINGCUP_SCORE, 72, 2, SHIP_HOVER },
    [SAILMISSION_VIKINGCUP_SUBMARINE_ACT1] = { MISSION_TYPE_VIKINGCUP_SCORE, 81, 2, SHIP_SUBMARINE },
    [SAILMISSION_VIKINGCUP_SUBMARINE_ACT2] = { MISSION_TYPE_VIKINGCUP_SCORE, 82, 2, SHIP_SUBMARINE },
};

// --------------------
// FUNCTIONS
// --------------------

void ResetSailState(void)
{
    gameState.sailUnknown1         = 0;
    gameState.sailStoredShipHealth = 0;
    gameState.sailUnknown4         = 0;
    gameState.sailRandSeed         = 0;
}

NONMATCH_FUNC void InitSailEvent(s32 id)
{
    // https://decomp.me/scratch/Yefjk -> 75.41%
#ifdef NON_MATCHING
    gameState.vikingCupID = id;

    if (id >= SAILMISSION_COUNT)
    {
        gameState.sailVsJohnny                = TRUE;
        gameState.sailVsJohnnyID              = id - 7;
        gameState.missionType                 = MISSION_TYPE_NONE;
        gameState.missionConfig.sail.courseID = 0;
        gameState.missionConfig.sail.unknown  = 0;
        gameState.sailShipType                = SHIP_JET;
    }
    else
    {
        gameState.missionType                 = sailMissionList[id].type;
        gameState.missionConfig.sail.courseID = sailMissionList[id].courseID;
        gameState.missionConfig.sail.unknown  = sailMissionList[id].unknown;
        gameState.sailShipType                = sailMissionList[id].shipType;
        gameState.sailVsJohnny                = FALSE;
        gameState.sailVsJohnnyID              = 0;
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =gameState
	cmp r0, #0x11
	str r0, [r1, #0xc4]
	blt _02063C9C
	mov r2, #0
	sub r0, r0, #7
	mov r3, #1
	str r3, [r1, #0xa4]
	strh r0, [r1, #0xb4]
	str r2, [r1, #0x70]
	str r2, [r1, #0x74]
	str r2, [r1, #0x78]
	str r2, [r1, #0xa0]
	ldmia sp!, {r4, pc}
_02063C9C:
	ldr lr, =sailMissionList
	mov r4, r0, lsl #2
	ldr ip, =0x0211162D
	ldr r3, =0x0211162E
	mov r0, #0
	ldr r2, =0x0211162F
	ldrsb lr, [lr, r4]
	ldrsb ip, [ip, r4]
	ldrsb r3, [r3, r4]
	ldrsb r2, [r2, r4]
	str lr, [r1, #0x70]
	str ip, [r1, #0x74]
	str r3, [r1, #0x78]
	str r2, [r1, #0xa0]
	str r0, [r1, #0xa4]
	strh r0, [r1, #0xb4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void GetSailUnknownValue(s32 *value, s32 timer)
{
    // https://decomp.me/scratch/3PO4L -> 67.56%
#ifdef NON_MATCHING
    s16 i = 0;

    u32 array1[] = { 1080000, 108000, 18000, 1800, 300, 30, 10, 1 };

    s32 v12 = 0;
    *value  = 0;
    for (i = 0; i < 7; i++)
    {
        if (i == 6)
        {
            timer = MultiplyFX(timer, 13984);
        }

        if (timer >= array1[i])
        {
            s32 v15 = FX_DivS32(timer, array1[i]);
            timer -= v15 * array1[i];
            *value |= v15 << v12;
        }

        v12 += 4;
    }

    *value |= timer << (4 * i);

    s16 v17   = 4 * i;
    s32 v18   = v17;
    s32 start = v17 >> 1;

    while (v17 >= start)
    {
        s32 v0 = 15 << v17;
        s32 v1 = 15 << (v18 - v17);

        *value = *value & ~(v0 | v1) | ((*value & v0) >> v17 << (v18 - v17)) | ((*value & v1) >> (v18 - v17) << v17);
        // *value &= ~(v0 | v1);
        // *value |= ((*value & v0) >> v17 << (v18 - v17));
        // *value |= (*value & v1) >> (v18 - v17) << v17;

        v17 -= 4;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r6, =_0211160C
	add r4, sp, #0
	mov r10, r0
	mov r9, r1
	mov r5, r4
	ldmia r6!, {r0, r1, r2, r3}
	mov r8, #0
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r4, =0x000036A0
	mov r7, r8
	str r8, [r10]
	mov r11, r8
_02063D34:
	cmp r8, #6
	ldr r6, [r5, r8, lsl #2]
	bne _02063D68
	mov r0, #0
	umull r2, r1, r9, r4
	mla r1, r9, r0, r1
	mov r0, r9, asr #0x1f
	mla r1, r0, r4, r1
	mov r0, #0x800
	adds r2, r2, r0
	adc r0, r1, r11
	mov r9, r2, lsr #0xc
	orr r9, r9, r0, lsl #20
_02063D68:
	cmp r9, r6
	blo _02063D90
	mov r0, r9
	mov r1, r6
	bl FX_DivS32
	mul r1, r0, r6
	ldr r2, [r10, #0]
	sub r9, r9, r1
	orr r0, r2, r0, lsl r7
	str r0, [r10]
_02063D90:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	cmp r8, #7
	add r7, r7, #4
	blt _02063D34
	ldr r1, [r10, #0]
	mov r0, r8, lsl #2
	orr r1, r1, r9, lsl r0
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	cmp r8, r8, asr #1
	mov r3, r8
	addlt sp, sp, #0x20
	str r1, [r10]
	mov r2, r8, asr #1
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0xf
_02063DD8:
	ldr r9, [r10, #0]
	sub r1, r3, r8
	and r4, r9, r0, lsl r8
	and r6, r9, r0, lsl r1
	mov r7, r0, lsl r8
	mov r5, r4, lsr r8
	orr r4, r7, r0, lsl r1
	mov r6, r6, lsr r1
	mov r1, r5, lsl r1
	mvn r4, r4
	and r7, r9, r4
	orr r1, r1, r6, lsl r8
	sub r4, r8, #4
	mov r4, r4, lsl #0x10
	orr r1, r7, r1
	str r1, [r10]
	cmp r2, r4, asr #16
	mov r8, r4, asr #0x10
	ble _02063DD8
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}