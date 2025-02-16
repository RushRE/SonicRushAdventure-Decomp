#include <hub/missionConfig.h>
#include <hub/talkHelpers.h>
#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <game/system/sysEvent.h>
#include <sail/vikingCupManager.h>
#include <hub/dockCommon.h>

// --------------------
// FUNCTION DECLS
// --------------------

extern void InitStageMission(s32 id);

// --------------------
// VARIABLES
// --------------------

static const u8 npcNameAnimForMission[MISSION_COUNT] = {
    // Regular missions
    [MISSION_0]  = 5,
    [MISSION_1]  = 4,
    [MISSION_2]  = 4,
    [MISSION_3]  = 7,
    [MISSION_4]  = 4,
    [MISSION_5]  = 9,
    [MISSION_6]  = 7,
    [MISSION_7]  = 4,
    [MISSION_8]  = 9,
    [MISSION_9]  = 7,
    [MISSION_10] = 8,
    [MISSION_11] = 9,
    [MISSION_12] = 7,
    [MISSION_13] = 8,
    [MISSION_14] = 4,
    [MISSION_15] = 5,
    [MISSION_16] = 7,
    [MISSION_17] = 4,
    [MISSION_18] = 9,
    [MISSION_19] = 5,
    [MISSION_20] = 8,
    [MISSION_21] = 10,
    [MISSION_22] = 10,
    [MISSION_23] = 2,
    [MISSION_24] = 10,
    [MISSION_25] = 10,
    [MISSION_26] = 10,
    [MISSION_27] = 2,
    [MISSION_28] = 10,
    [MISSION_29] = 10,
    [MISSION_30] = 10,
    [MISSION_31] = 10,
    [MISSION_32] = 2,
    [MISSION_33] = 10,
    [MISSION_34] = 10,
    [MISSION_35] = 2,
    [MISSION_36] = 10,
    [MISSION_37] = 10,
    [MISSION_38] = 10,
    [MISSION_39] = 10,
    [MISSION_40] = 2,
    [MISSION_41] = 10,
    [MISSION_42] = 10,
    [MISSION_43] = 2,
    [MISSION_44] = 10,
    [MISSION_45] = 10,
    [MISSION_46] = 10,
    [MISSION_47] = 10,
    [MISSION_48] = 2,
    [MISSION_49] = 10,
    [MISSION_50] = 10,
    [MISSION_51] = 2,
    [MISSION_52] = 10,
    [MISSION_53] = 10,
    [MISSION_54] = 10,
    [MISSION_55] = 10,
    [MISSION_56] = 2,
    [MISSION_57] = 10,
    [MISSION_58] = 10,
    [MISSION_59] = 10,
    [MISSION_60] = 9,
    [MISSION_61] = 2,
    [MISSION_62] = 10,
    [MISSION_63] = 10,
    [MISSION_64] = 10,
    [MISSION_65] = 2,
    [MISSION_66] = 10,
    [MISSION_67] = 10,
    [MISSION_68] = 10,
    [MISSION_69] = 2,
    [MISSION_70] = 10,
    [MISSION_71] = 10,
    [MISSION_72] = 10,
    [MISSION_73] = 10,
    [MISSION_74] = 10,
    [MISSION_75] = 10,
    [MISSION_76] = 10,
    [MISSION_77] = 10,
    [MISSION_78] = 10,
    [MISSION_79] = 2,
    [MISSION_80] = 10,
    [MISSION_81] = 10,
    [MISSION_82] = 10,
    [MISSION_83] = 2,
    [MISSION_84] = 10,
    [MISSION_85] = 7,
    [MISSION_86] = 10,
    [MISSION_87] = 7,
    [MISSION_88] = 10,
    [MISSION_89] = 10,
    [MISSION_90] = 10,
    [MISSION_91] = 10,
    [MISSION_92] = 10,
    [MISSION_93] = 10,
    [MISSION_94] = 10,

    // Sailing missions
    [MISSION_95] = 3,
    [MISSION_96] = 3,
    [MISSION_97] = 3,
    [MISSION_98] = 3,

    // Mission 100
    [MISSION_99] = 2,
};

static const u16 missionIndexFromSelection[MISSIONLIST_COUNT] = {
    // Regular missions
    [MISSIONLIST_1]  = MISSION_9,
    [MISSIONLIST_2]  = MISSION_83,
    [MISSIONLIST_3]  = MISSION_84,
    [MISSIONLIST_4]  = MISSION_19,
    [MISSIONLIST_5]  = MISSION_79,
    [MISSIONLIST_6]  = MISSION_6,
    [MISSIONLIST_7]  = MISSION_77,
    [MISSIONLIST_8]  = MISSION_89,
    [MISSIONLIST_9]  = MISSION_16,
    [MISSIONLIST_10] = MISSION_29,
    [MISSIONLIST_11] = MISSION_39,
    [MISSIONLIST_12] = MISSION_26,
    [MISSIONLIST_13] = MISSION_86,
    [MISSIONLIST_14] = MISSION_88,
    [MISSIONLIST_15] = MISSION_93,
    [MISSIONLIST_16] = MISSION_59,
    [MISSIONLIST_17] = MISSION_81,
    [MISSIONLIST_18] = MISSION_85,
    [MISSIONLIST_19] = MISSION_36,
    [MISSIONLIST_20] = MISSION_49,
    [MISSIONLIST_21] = MISSION_91,
    [MISSIONLIST_22] = MISSION_0,
    [MISSIONLIST_23] = MISSION_1,
    [MISSIONLIST_24] = MISSION_2,
    [MISSIONLIST_25] = MISSION_3,
    [MISSIONLIST_26] = MISSION_4,
    [MISSIONLIST_27] = MISSION_5,
    [MISSIONLIST_28] = MISSION_7,
    [MISSIONLIST_29] = MISSION_8,
    [MISSIONLIST_30] = MISSION_10,
    [MISSIONLIST_31] = MISSION_11,
    [MISSIONLIST_32] = MISSION_12,
    [MISSIONLIST_33] = MISSION_13,
    [MISSIONLIST_34] = MISSION_14,
    [MISSIONLIST_35] = MISSION_15,
    [MISSIONLIST_36] = MISSION_17,
    [MISSIONLIST_37] = MISSION_18,
    [MISSIONLIST_38] = MISSION_20,
    [MISSIONLIST_39] = MISSION_21,
    [MISSIONLIST_40] = MISSION_22,
    [MISSIONLIST_41] = MISSION_23,
    [MISSIONLIST_42] = MISSION_24,
    [MISSIONLIST_43] = MISSION_25,
    [MISSIONLIST_44] = MISSION_27,
    [MISSIONLIST_45] = MISSION_28,
    [MISSIONLIST_46] = MISSION_30,
    [MISSIONLIST_47] = MISSION_31,
    [MISSIONLIST_48] = MISSION_32,
    [MISSIONLIST_49] = MISSION_33,
    [MISSIONLIST_50] = MISSION_34,
    [MISSIONLIST_51] = MISSION_35,
    [MISSIONLIST_52] = MISSION_37,
    [MISSIONLIST_53] = MISSION_38,
    [MISSIONLIST_54] = MISSION_40,
    [MISSIONLIST_55] = MISSION_41,
    [MISSIONLIST_56] = MISSION_42,
    [MISSIONLIST_57] = MISSION_43,
    [MISSIONLIST_58] = MISSION_44,
    [MISSIONLIST_59] = MISSION_45,
    [MISSIONLIST_60] = MISSION_46,
    [MISSIONLIST_61] = MISSION_47,
    [MISSIONLIST_62] = MISSION_48,
    [MISSIONLIST_63] = MISSION_50,
    [MISSIONLIST_64] = MISSION_51,
    [MISSIONLIST_65] = MISSION_52,
    [MISSIONLIST_66] = MISSION_53,
    [MISSIONLIST_67] = MISSION_54,
    [MISSIONLIST_68] = MISSION_55,
    [MISSIONLIST_69] = MISSION_56,
    [MISSIONLIST_70] = MISSION_57,
    [MISSIONLIST_71] = MISSION_58,
    [MISSIONLIST_72] = MISSION_60,
    [MISSIONLIST_73] = MISSION_72,
    [MISSIONLIST_74] = MISSION_73,
    [MISSIONLIST_75] = MISSION_74,
    [MISSIONLIST_76] = MISSION_75,
    [MISSIONLIST_77] = MISSION_76,
    [MISSIONLIST_78] = MISSION_61,
    [MISSIONLIST_79] = MISSION_62,
    [MISSIONLIST_80] = MISSION_63,
    [MISSIONLIST_81] = MISSION_64,
    [MISSIONLIST_82] = MISSION_65,
    [MISSIONLIST_83] = MISSION_66,
    [MISSIONLIST_84] = MISSION_67,
    [MISSIONLIST_85] = MISSION_68,
    [MISSIONLIST_86] = MISSION_69,
    [MISSIONLIST_87] = MISSION_70,
    [MISSIONLIST_88] = MISSION_71,
    [MISSIONLIST_89] = MISSION_78,
    [MISSIONLIST_90] = MISSION_80,
    [MISSIONLIST_91] = MISSION_82,
    [MISSIONLIST_92] = MISSION_87,
    [MISSIONLIST_93] = MISSION_90,
    [MISSIONLIST_94] = MISSION_92,
    [MISSIONLIST_95] = MISSION_94,

    // Sailing missions
    [MISSIONLIST_96] = MISSION_95,
    [MISSIONLIST_97] = MISSION_96,
    [MISSIONLIST_98] = MISSION_97,
    [MISSIONLIST_99] = MISSION_98,

    // Mission 100
    [MISSIONLIST_100] = MISSION_99,
};

static const u16 missionIDTable[MISSION_COUNT] = {
    // Regular missions
    [MISSION_0]  = MISSION_0,
    [MISSION_1]  = MISSION_1,
    [MISSION_2]  = MISSION_2,
    [MISSION_3]  = MISSION_3,
    [MISSION_4]  = MISSION_4,
    [MISSION_5]  = MISSION_5,
    [MISSION_6]  = MISSION_6,
    [MISSION_7]  = MISSION_7,
    [MISSION_8]  = MISSION_8,
    [MISSION_9]  = MISSION_9,
    [MISSION_10] = MISSION_10,
    [MISSION_11] = MISSION_11,
    [MISSION_12] = MISSION_12,
    [MISSION_13] = MISSION_13,
    [MISSION_14] = MISSION_14,
    [MISSION_15] = MISSION_15,
    [MISSION_16] = MISSION_16,
    [MISSION_17] = MISSION_17,
    [MISSION_18] = MISSION_18,
    [MISSION_19] = MISSION_19,
    [MISSION_20] = MISSION_20,
    [MISSION_21] = MISSION_21,
    [MISSION_22] = MISSION_22,
    [MISSION_23] = MISSION_23,
    [MISSION_24] = MISSION_24,
    [MISSION_25] = MISSION_25,
    [MISSION_26] = MISSION_26,
    [MISSION_27] = MISSION_27,
    [MISSION_28] = MISSION_28,
    [MISSION_29] = MISSION_29,
    [MISSION_30] = MISSION_30,
    [MISSION_31] = MISSION_31,
    [MISSION_32] = MISSION_32,
    [MISSION_33] = MISSION_33,
    [MISSION_34] = MISSION_34,
    [MISSION_35] = MISSION_35,
    [MISSION_36] = MISSION_36,
    [MISSION_37] = MISSION_37,
    [MISSION_38] = MISSION_38,
    [MISSION_39] = MISSION_39,
    [MISSION_40] = MISSION_40,
    [MISSION_41] = MISSION_41,
    [MISSION_42] = MISSION_42,
    [MISSION_43] = MISSION_43,
    [MISSION_44] = MISSION_44,
    [MISSION_45] = MISSION_45,
    [MISSION_46] = MISSION_46,
    [MISSION_47] = MISSION_47,
    [MISSION_48] = MISSION_48,
    [MISSION_49] = MISSION_49,
    [MISSION_50] = MISSION_50,
    [MISSION_51] = MISSION_51,
    [MISSION_52] = MISSION_52,
    [MISSION_53] = MISSION_53,
    [MISSION_54] = MISSION_54,
    [MISSION_55] = MISSION_55,
    [MISSION_56] = MISSION_56,
    [MISSION_57] = MISSION_57,
    [MISSION_58] = MISSION_58,
    [MISSION_59] = MISSION_59,
    [MISSION_60] = MISSION_60,
    [MISSION_61] = MISSION_61,
    [MISSION_62] = MISSION_62,
    [MISSION_63] = MISSION_63,
    [MISSION_64] = MISSION_64,
    [MISSION_65] = MISSION_65,
    [MISSION_66] = MISSION_66,
    [MISSION_67] = MISSION_67,
    [MISSION_68] = MISSION_68,
    [MISSION_69] = MISSION_69,
    [MISSION_70] = MISSION_70,
    [MISSION_71] = MISSION_71,
    [MISSION_72] = MISSION_72,
    [MISSION_73] = MISSION_73,
    [MISSION_74] = MISSION_74,
    [MISSION_75] = MISSION_75,
    [MISSION_76] = MISSION_76,
    [MISSION_77] = MISSION_77,
    [MISSION_78] = MISSION_78,
    [MISSION_79] = MISSION_79,
    [MISSION_80] = MISSION_80,
    [MISSION_81] = MISSION_81,
    [MISSION_82] = MISSION_82,
    [MISSION_83] = MISSION_83,
    [MISSION_84] = MISSION_84,
    [MISSION_85] = MISSION_85,
    [MISSION_86] = MISSION_86,
    [MISSION_87] = MISSION_87,
    [MISSION_88] = MISSION_88,
    [MISSION_89] = MISSION_89,
    [MISSION_90] = MISSION_90,
    [MISSION_91] = MISSION_91,
    [MISSION_92] = MISSION_92,
    [MISSION_93] = MISSION_93,
    [MISSION_94] = MISSION_94,

    // Sailing missions
    [MISSION_95] = 5,
    [MISSION_96] = 6,
    [MISSION_97] = 7,
    [MISSION_98] = 8,

    // Mission 100
    [MISSION_99] = MISSION_INVALID,
};

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckMissionMatches(u16 id1, u16 id2)
{
    return id1 == id2;
}

// --------------------
// FUNCTIONS
// --------------------

void MissionHelpers__StartMission(s32 id)
{
    gameState.talk.missionID            = id;
    gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_MISSIONLIST_TALK;

    if (id < MISSION_95)
    {
        InitStageMission(missionIDTable[id]);

        if (MissionHelpers__CheckSonicMission(id))
        {
            gameState.characterID[0] = CHARACTER_SONIC;
            RequestNewSysEventChange(SYSEVENT_LOAD_STAGE);
        }
        else if (MissionHelpers__CheckBlazeMission(id))
        {
            gameState.characterID[0] = CHARACTER_BLAZE;
            RequestNewSysEventChange(SYSEVENT_LOAD_STAGE);
        }
        else
        {
            if (SaveGame__BlazeUnlocked())
            {
                gameState.characterID[0] = CHARACTER_SONIC;
                RequestNewSysEventChange(SYSEVENT_7);
            }
            else
            {
                gameState.characterID[0] = CHARACTER_SONIC;
                RequestNewSysEventChange(SYSEVENT_LOAD_STAGE);
            }
        }
    }
    else
    {
        VikingCupManager__EventStartVikingCup(missionIDTable[id]);
        RequestNewSysEventChange(SYSEVENT_SAILING);
    }
}

s32 MissionHelpers__GetMissionID(void)
{
    return gameState.talk.missionID;
}

u16 MissionHelpers__GetMissionFromSelection(u16 id)
{
    return missionIndexFromSelection[id];
}

void MissionHelpers__HandleCompletedMuzyMissions(void)
{
    s32 i;
    s32 count = MissionHelpers__MuzyPostGameMissionCount();

    for (i = 0; i < count; i++)
    {
        u16 id = MissionHelpers__GetMuzyPostGameMission(i);
        if (!MissionHelpers__CheckMissionCompleted(id))
        {
            if (MissionHelpers__CheckMissionBeaten(id))
                MissionHelpers__CompleteMission(id);
        }
    }
}

u32 MissionHelpers__GetMissionCompletedReward(s32 id)
{
    switch (id)
    {
        case MISSION_9:
            return 16;

        case MISSION_39:
            return 2;

        case MISSION_49:
            return 19;

        case MISSION_59:
            return 13;

        case MISSION_83:
            return 1;

        case MISSION_84:
            return 20;

        case MISSION_85:
            return 21;

        case MISSION_79:
            return 10;

        case MISSION_88:
            return 18;

        case MISSION_89:
            return 11;

        case MISSION_91:
            return 4;

        case MISSION_93:
            return 12;

        case MISSION_99:
            return 6;

        default:
            return 23;
    }
}

BOOL MissionHelpers__CheckPostGameMissionUnlock(void)
{
    BOOL didUnlock = FALSE;

    if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_36)
    {
        for (s32 i = 0; i < MissionHelpers__MuzyPostGameMissionCount(); i++)
        {
            s32 id       = MissionHelpers__GetMuzyPostGameMission(i);
            u16 islandID = MissionHelpers__GetMuzyPostGameMissionIsland(i);

            if ((islandID == MISSION_INVALID || SaveGame__GetIslandProgress(&saveGame.stage.progress, islandID) >= SAVE_ISLAND_STATE_BEATEN)
                && !MissionHelpers__CheckMissionUnlocked(id))
            {
                MissionHelpers__UnlockMission(id);
                didUnlock = TRUE;
            }
        }

        for (s32 i = 0; i < MissionHelpers__MarinePostGameMissionCount(); i++)
        {
            s32 id = MissionHelpers__GetMarinePostGameMission(i);
            if (!MissionHelpers__CheckMissionUnlocked(id))
            {
                MissionHelpers__UnlockMission(id);
                didUnlock = TRUE;
            }
        }
    }

    return didUnlock;
}

BOOL MissionHelpers__CheckSonicMission(s32 id)
{
    return FALSE; // There are no missions in the game that are sonic exclusive.
}

BOOL MissionHelpers__CheckBlazeMission(s32 id)
{
    for (s32 i = 0; i < MissionHelpers__BlazeMissionCount(); i++)
    {
        if (CheckMissionMatches(id, MissionHelpers__GetBlazeMission(i)))
        {
            return TRUE;
        }
    }

    return FALSE;
}

u16 MissionHelpers__GetSolEmeraldIDFromMissionID(s32 id)
{
    if (MissionHelpers__CheckMissionBeaten(id))
        return MISSION_INVALID;

    for (s32 i = 0; i < MissionHelpers__BlazeMissionCount(); i++)
    {
        if (CheckMissionMatches(id, MissionHelpers__GetBlazeMission(i)))
        {
            return i;
        }
    }

    return MISSION_INVALID;
}

u16 MissionHelpers__GetNpcNameAnimForMission(u16 id)
{
    return npcNameAnimForMission[id];
}