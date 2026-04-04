#include <menu/menuHelpers.h>
#include <game/save/saveGame.h>

// --------------------
// ENUMS
// --------------------

enum SaveProgressMode_
{
    SAVE_PROGRESS_EXTRACHECK_COMMON,
    SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED,
    SAVE_PROGRESS_EXTRACHECK_ZONE5_DISCOVERED,
    SAVE_PROGRESS_EXTRACHECK_ZONE6_DISCOVERED,
};
typedef u8 SaveProgressMode;

// --------------------
// STRUCTS
// --------------------

typedef struct StageProgressCheck_
{
    u8 gameProgress;
    u8 zone5Progress;
    u8 zone6Progress;
    u8 extraCheck;
} StageProgressCheck;

// --------------------
// VARIABLES
// --------------------

static const u16 sLeaderboardStageTable[] = { STAGE_Z11, STAGE_Z12, STAGE_Z21, STAGE_Z22, STAGE_Z31, STAGE_Z32, STAGE_Z41,
                                              STAGE_Z42, STAGE_Z51, STAGE_Z52, STAGE_Z61, STAGE_Z62, STAGE_Z71, STAGE_Z72 };

static const u16 sStageSelectIDTable[STAGE_COUNT_NO_RACES] = {
    [STAGE_Z11]               = 0,
    [STAGE_Z12]               = 1,
    [STAGE_TUTORIAL]          = 3,
    [STAGE_Z1B]               = 4,
    [STAGE_Z21]               = 5,
    [STAGE_Z22]               = 6,
    [STAGE_Z2B]               = 7,
    [STAGE_Z31]               = 8,
    [STAGE_Z32]               = 10,
    [STAGE_HIDDEN_ISLAND_1]   = 11,
    [STAGE_Z3B]               = 12,
    [STAGE_Z41]               = 13,
    [STAGE_Z42]               = 14,
    [STAGE_Z4B]               = 15,
    [STAGE_Z51]               = 16,
    [STAGE_Z52]               = 17,
    [STAGE_Z5B]               = 18,
    [STAGE_Z61]               = 20,
    [STAGE_Z62]               = 21,
    [STAGE_HIDDEN_ISLAND_2]   = 22,
    [STAGE_Z6B]               = 23,
    [STAGE_Z71]               = 24,
    [STAGE_Z72]               = 46,
    [STAGE_Z7B]               = 9,
    [STAGE_BOSS_FINAL]        = 19,
    [STAGE_HIDDEN_ISLAND_3]   = 25,
    [STAGE_HIDDEN_ISLAND_4]   = 26,
    [STAGE_HIDDEN_ISLAND_5]   = 27,
    [STAGE_HIDDEN_ISLAND_6]   = 28,
    [STAGE_HIDDEN_ISLAND_7]   = 29,
    [STAGE_HIDDEN_ISLAND_8]   = 30,
    [STAGE_HIDDEN_ISLAND_9]   = 31,
    [STAGE_HIDDEN_ISLAND_10]  = 32,
    [STAGE_HIDDEN_ISLAND_11]  = 33,
    [STAGE_HIDDEN_ISLAND_12]  = 34,
    [STAGE_HIDDEN_ISLAND_13]  = 35,
    [STAGE_HIDDEN_ISLAND_14]  = 36,
    [STAGE_HIDDEN_ISLAND_15]  = 37,
    [STAGE_HIDDEN_ISLAND_16]  = 38,
    [STAGE_HIDDEN_ISLAND_VS1] = 39,
    [STAGE_HIDDEN_ISLAND_VS2] = 40,
    [STAGE_HIDDEN_ISLAND_VS3] = 41,
    [STAGE_HIDDEN_ISLAND_VS4] = 42,
};

static const u16 sTimeAttackRecordsIDTable[STAGE_COUNT] = {
    [STAGE_Z11]               = 0,
    [STAGE_Z12]               = 1,
    [STAGE_TUTORIAL]          = 3,
    [STAGE_Z1B]               = 4,
    [STAGE_Z21]               = 5,
    [STAGE_Z22]               = 6,
    [STAGE_Z2B]               = 7,
    [STAGE_Z31]               = 8,
    [STAGE_Z32]               = 10,
    [STAGE_HIDDEN_ISLAND_1]   = 11,
    [STAGE_Z3B]               = 12,
    [STAGE_Z41]               = 13,
    [STAGE_Z42]               = 14,
    [STAGE_Z4B]               = 15,
    [STAGE_Z51]               = 16,
    [STAGE_Z52]               = 17,
    [STAGE_Z5B]               = 18,
    [STAGE_Z61]               = 20,
    [STAGE_Z62]               = 21,
    [STAGE_HIDDEN_ISLAND_2]   = 22,
    [STAGE_Z6B]               = 23,
    [STAGE_Z71]               = 24,
    [STAGE_Z72]               = 46,
    [STAGE_Z7B]               = 9,
    [STAGE_BOSS_FINAL]        = 19,
    [STAGE_HIDDEN_ISLAND_3]   = 25,
    [STAGE_HIDDEN_ISLAND_4]   = 26,
    [STAGE_HIDDEN_ISLAND_5]   = 27,
    [STAGE_HIDDEN_ISLAND_6]   = 28,
    [STAGE_HIDDEN_ISLAND_7]   = 29,
    [STAGE_HIDDEN_ISLAND_8]   = 30,
    [STAGE_HIDDEN_ISLAND_9]   = 31,
    [STAGE_HIDDEN_ISLAND_10]  = 32,
    [STAGE_HIDDEN_ISLAND_11]  = 33,
    [STAGE_HIDDEN_ISLAND_12]  = 34,
    [STAGE_HIDDEN_ISLAND_13]  = 35,
    [STAGE_HIDDEN_ISLAND_14]  = 36,
    [STAGE_HIDDEN_ISLAND_15]  = 37,
    [STAGE_HIDDEN_ISLAND_16]  = 38,
    [STAGE_HIDDEN_ISLAND_VS1] = 39,
    [STAGE_HIDDEN_ISLAND_VS2] = 40,
    [STAGE_HIDDEN_ISLAND_VS3] = 41,
    [STAGE_HIDDEN_ISLAND_VS4] = 42,
    [STAGE_HIDDEN_ISLAND_R1]  = 43,
    [STAGE_HIDDEN_ISLAND_R2]  = 44,
    [STAGE_HIDDEN_ISLAND_R3]  = 45,
};

static const StageProgressCheck sProgressCheck_Unlocked[STAGE_COUNT_NON_OPTIONAL + 1] = {
    [STAGE_Z11] = { .gameProgress  = SAVE_PROGRESS_3,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z12] = { .gameProgress  = SAVE_PROGRESS_3,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_TUTORIAL] = { .gameProgress  = SAVE_PROGRESS_1,
                         .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                         .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                         .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z1B] = { .gameProgress  = SAVE_PROGRESS_4,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z21] = { .gameProgress  = SAVE_PROGRESS_6,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z22] = { .gameProgress  = SAVE_PROGRESS_6,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z2B] = { .gameProgress  = SAVE_PROGRESS_7,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z31] = { .gameProgress  = SAVE_PROGRESS_14,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z32] = { .gameProgress  = SAVE_PROGRESS_14,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_HIDDEN_ISLAND_1] = { .gameProgress  = SAVE_PROGRESS_13,
                                .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                                .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                                .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z3B] = { .gameProgress  = SAVE_PROGRESS_15,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z41] = { .gameProgress  = SAVE_PROGRESS_19,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z42] = { .gameProgress  = SAVE_PROGRESS_19,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z4B] = { .gameProgress  = SAVE_PROGRESS_20,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z51] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_2,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z52] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_2,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE5_DISCOVERED },

    [STAGE_Z5B] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_3,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z61] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z62] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE6_DISCOVERED },

    [STAGE_HIDDEN_ISLAND_2] = { .gameProgress  = SAVE_PROGRESS_24,
                                .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                                .zone6Progress = SAVE_ZONE6_PROGRESS_3,
                                .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z6B] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_5,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z71] = { .gameProgress  = SAVE_PROGRESS_33,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z72] = { .gameProgress  = SAVE_PROGRESS_33,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z7B] = { .gameProgress  = SAVE_PROGRESS_34,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_BOSS_FINAL] = { .gameProgress  = SAVE_PROGRESS_35,
                           .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                           .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                           .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    // Deep Core progress check
    [1 + STAGE_BOSS_FINAL] = { .gameProgress  = SAVE_PROGRESS_38,
                               .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                               .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                               .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },
};

static const StageProgressCheck sProgressCheck_Cleared[STAGE_COUNT_NON_OPTIONAL + 1] = {
    [STAGE_Z11] = { .gameProgress  = SAVE_PROGRESS_3,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z12] = { .gameProgress  = SAVE_PROGRESS_4,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_TUTORIAL] = { .gameProgress  = SAVE_PROGRESS_1,
                         .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                         .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                         .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z1B] = { .gameProgress  = SAVE_PROGRESS_5,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z21] = { .gameProgress  = SAVE_PROGRESS_6,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z22] = { .gameProgress  = SAVE_PROGRESS_7,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z2B] = { .gameProgress  = SAVE_PROGRESS_8,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z31] = { .gameProgress  = SAVE_PROGRESS_14,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z32] = { .gameProgress  = SAVE_PROGRESS_15,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_HIDDEN_ISLAND_1] = { .gameProgress  = SAVE_PROGRESS_14,
                                .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                                .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                                .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z3B] = { .gameProgress  = SAVE_PROGRESS_16,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z41] = { .gameProgress  = SAVE_PROGRESS_19,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z42] = { .gameProgress  = SAVE_PROGRESS_20,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z4B] = { .gameProgress  = SAVE_PROGRESS_21,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z51] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_2,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE5_DISCOVERED },

    [STAGE_Z52] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_3,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z5B] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_0,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z61] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE6_DISCOVERED },

    [STAGE_Z62] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_5,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_HIDDEN_ISLAND_2] = { .gameProgress  = SAVE_PROGRESS_24,
                                .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                                .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                                .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z6B] = { .gameProgress  = SAVE_PROGRESS_24,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_0,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z71] = { .gameProgress  = SAVE_PROGRESS_33,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED },

    [STAGE_Z72] = { .gameProgress  = SAVE_PROGRESS_34,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_Z7B] = { .gameProgress  = SAVE_PROGRESS_35,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                    .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    [STAGE_BOSS_FINAL] = { .gameProgress  = SAVE_PROGRESS_36,
                           .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                           .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                           .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },

    // Deep Core progress check
    [1 + STAGE_BOSS_FINAL] = { .gameProgress  = SAVE_PROGRESS_39,
                               .zone5Progress = SAVE_ZONE5_PROGRESS_4,
                               .zone6Progress = SAVE_ZONE6_PROGRESS_6,
                               .extraCheck    = SAVE_PROGRESS_EXTRACHECK_COMMON },
};

// --------------------
// FUNCTIONS
// --------------------

u16 MenuHelpers__GetStageIDForStageSelect(s32 id)
{
    return sStageSelectIDTable[id];
}

u16 MenuHelpers__GetStageIDForTimeAttackRecordsMenu(s32 id)
{
    return sTimeAttackRecordsIDTable[id];
}

u16 MenuHelpers__GetStageIDFromLeaderboardID(s32 id)
{
    return sLeaderboardStageTable[id];
}

s32 MenuHelpers__GetLeaderboardIDFromStageID(s32 id)
{
    for (s32 s = 0; s < (s32)ARRAY_COUNT(sLeaderboardStageTable); s++)
    {
        if (id == sLeaderboardStageTable[s])
            return s;
    }

    return (s32)ARRAY_COUNT(sLeaderboardStageTable);
}

BOOL MenuHelpers__CheckStageCleared(s32 stage, BOOL checkStageCleared, BOOL useSystemProgress)
{
    SaveGameProgress *saveProgress;
    if (useSystemProgress)
        saveProgress = &saveGame.system.progress;
    else
        saveProgress = &saveGame.stage.progress;

    u32 gameProgress  = saveProgress->gameProgress;
    u32 zone5Progress = saveProgress->zone5Progress;
    u32 zone6Progress = saveProgress->zone6Progress;

    if (stage <= STAGE_BOSS_FINAL)
    {
        // check regular stages up until (and including) the final boss

        const StageProgressCheck *progressCheck;
        if (checkStageCleared)
            progressCheck = &sProgressCheck_Cleared[stage];
        else
            progressCheck = &sProgressCheck_Unlocked[stage];

        if (gameProgress >= progressCheck->gameProgress && zone5Progress >= progressCheck->zone5Progress && zone6Progress >= progressCheck->zone6Progress)
        {
            switch (progressCheck->extraCheck)
            {
                case SAVE_PROGRESS_EXTRACHECK_COMMON:
                    return TRUE;

                case SAVE_PROGRESS_EXTRACHECK_ZONE_DISCOVERED:
                    if (gameProgress > progressCheck->gameProgress || (saveProgress->flags & SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR) != 0)
                        return TRUE;
                    break;

                case SAVE_PROGRESS_EXTRACHECK_ZONE5_DISCOVERED:
                    if (zone5Progress > progressCheck->zone5Progress || (saveProgress->flags & SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR) != 0)
                        return TRUE;
                    break;

                case SAVE_PROGRESS_EXTRACHECK_ZONE6_DISCOVERED:
                    if (zone6Progress > progressCheck->zone6Progress || (saveProgress->flags & SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR) != 0)
                        return TRUE;
                    break;
            }
        }
    }
    else
    {
        if (stage <= STAGE_HIDDEN_ISLAND_16)
        {
            // check if hidden islands are unlocked
            s32 islandProgress = SaveGame__GetIslandProgress(saveProgress, (u16)(stage - STAGE_HIDDEN_ISLAND_3));
            if (checkStageCleared)
            {
                if (islandProgress >= SAVE_ISLAND_STATE_BEATEN)
                    return TRUE;
            }
            else
            {
                if (islandProgress >= SAVE_ISLAND_STATE_UNLOCKED)
                    return TRUE;
            }
        }
        else
        {
            // check everything else

            if (stage <= STAGE_HIDDEN_ISLAND_VS4)
                return TRUE; // all VS islands are always unlocked

            if (stage <= STAGE_HIDDEN_ISLAND_R3)
                return TRUE; // all race islands are always unlocked

            // check deep core
            const StageProgressCheck *progressCheck;
            if (checkStageCleared)
                progressCheck = &sProgressCheck_Cleared[STAGE_BOSS_FINAL + 1];
            else
                progressCheck = &sProgressCheck_Unlocked[STAGE_BOSS_FINAL + 1];

            if (gameProgress >= progressCheck->gameProgress && zone5Progress >= progressCheck->zone5Progress && zone6Progress >= progressCheck->zone6Progress)
                return TRUE;
        }
    }

    return FALSE;
}