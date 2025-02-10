#include <hub/missionConfig.h>
#include <hub/talkHelpers.h>
#include <hub/hubConfig.h>
#include <game/save/saveGame.h>
#include <game/system/sysEvent.h>
#include <sail/vikingCupManager.h>

// resources
#include <resources/narc/vi_msg_ctrl_lz7.h>

// --------------------
// TYPES
// --------------------

typedef u16 (*TalkHelperFunc)(void);

// --------------------
// VARIABLES
// --------------------

static const u16 missionTable_Tabby[] = { MISSION_9, MISSION_59, MISSION_49 };

static const u16 missionIslandTable_Tabby[] = { MISSION_INVALID, MISSION_INVALID, MISSION_INVALID };

static const u16 missionTable_Daikun[] = { MISSION_39, MISSION_88, MISSION_91 };

static const u16 missionIslandTable_Daikun[] = { MISSION_INVALID, SAVE_ISLAND_10, SAVE_ISLAND_12 };

static const u16 missionIslandTable_Norman[] = { MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID };

static const u16 missionTable_Norman[] = { MISSION_95, MISSION_96, MISSION_97, MISSION_98 };

static const u16 missionIslandTable_Kylok[] = { MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID };

static const u16 missionTable_Kylok[] = { MISSION_6, MISSION_16, MISSION_26, MISSION_36, MISSION_47 };

static const u16 missionValueTable_Daikun[] = { 7, 8, 10, 11, 13, 14 };

static const u16 missionValueTable_Tabby[] = { 10, 11, 13, 14, 16, 17 };

static const u16 missionTable_Setter[] = { MISSION_83, MISSION_84, MISSION_79, MISSION_89, MISSION_93, MISSION_85 };

static const u16 missionIslandTable_Setter[] = { SAVE_ISLAND_6, SAVE_ISLAND_7, SAVE_ISLAND_4, SAVE_ISLAND_11, SAVE_ISLAND_13, SAVE_ISLAND_8 };

static const u16 missionTable_Gardon[7] = { MISSION_19, MISSION_77, MISSION_29, MISSION_86, MISSION_81, MISSION_69, MISSION_71 };

static const u16 missionIslandTable_Gardon[] = { MISSION_INVALID, SAVE_ISLAND_3, MISSION_INVALID, SAVE_ISLAND_9, SAVE_ISLAND_5, MISSION_INVALID, MISSION_INVALID };

static const u16 missionValueTable_Norman[] = { 7, 8, 9, 10, 11, 12, 13, 14 };

static const MissionHelpersProgressCheck missionProgressTable_Tabby[] = {
    { .gameProgress = SAVE_PROGRESS_5, .unknownProgress1 = 0, .unknownProgress2 = 0 },
    { .gameProgress = SAVE_PROGRESS_26, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_35, .unknownProgress1 = 0, .unknownProgress2 = 0 },
};

static const MissionHelpersProgressCheck missionProgressTable_Daikun[] = {
    { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 4, .unknownProgress2 = 0 },
    { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 0, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_35, .unknownProgress1 = 4, .unknownProgress2 = 6 },
};

static const u16 missionValueTable_Kylok[] = { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 };

static const MissionHelpersProgressCheck missionProgressTable_Norman[] = {
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
};

static const u16 missionValueTable_Setter[] = { 8, 9, 11, 12, 14, 15, 17, 18, 20, 21, 23, 24 };

static const u16 missionValueTable_Gardon[] = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 };

static const u16 postGameMissionListMarine[] = { MISSION_2,  MISSION_7,  MISSION_13, MISSION_17, MISSION_23, MISSION_27, MISSION_33,
                                                 MISSION_37, MISSION_43, MISSION_48, MISSION_53, MISSION_57, MISSION_63, MISSION_67 };

static const MissionHelpersProgressCheck missionProgressTable_Kylok[] = {
    { .gameProgress = SAVE_PROGRESS_21, .unknownProgress1 = 0, .unknownProgress2 = 0 }, { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 4, .unknownProgress2 = 0 },
    { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 4, .unknownProgress2 = 6 }, { .gameProgress = SAVE_PROGRESS_35, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
};

static const MissionHelpersProgressCheck missionProgressTable_Setter[] = {
    { .gameProgress = SAVE_PROGRESS_8, .unknownProgress1 = 0, .unknownProgress2 = 0 },  { .gameProgress = SAVE_PROGRESS_9, .unknownProgress1 = 0, .unknownProgress2 = 0 },
    { .gameProgress = SAVE_PROGRESS_16, .unknownProgress1 = 0, .unknownProgress2 = 0 }, { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 1, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 1, .unknownProgress2 = 6 }, { .gameProgress = SAVE_PROGRESS_30, .unknownProgress1 = 4, .unknownProgress2 = 6 },
};

static const MissionHelpersProgressCheck missionProgressTable_Gardon[] = {
    { .gameProgress = SAVE_PROGRESS_16, .unknownProgress1 = 0, .unknownProgress2 = 0 }, { .gameProgress = SAVE_PROGRESS_21, .unknownProgress1 = 0, .unknownProgress2 = 0 },
    { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 4, .unknownProgress2 = 0 }, { .gameProgress = SAVE_PROGRESS_24, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_30, .unknownProgress1 = 4, .unknownProgress2 = 6 }, { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
    { .gameProgress = SAVE_PROGRESS_36, .unknownProgress1 = 4, .unknownProgress2 = 6 },
};

static const u16 messageControlFileTable[TALKINTERACTION_COUNT] = {
    [TALKINTERACTION_TAILS]     = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_TAILS_MCF,
    [TALKINTERACTION_MARINE]    = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_RAC_MCF,
    [TALKINTERACTION_BLAZE]     = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_BLZ_MCF,
    [TALKINTERACTION_TABBY]     = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF,
    [TALKINTERACTION_COLONEL]   = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SPY_MCF,
    [TALKINTERACTION_SETTER]    = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_OP_MCF,
    [TALKINTERACTION_COLONEL_2] = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SPY_MCF,
    [TALKINTERACTION_7]         = MISSION_INVALID,
    [TALKINTERACTION_8]         = MISSION_INVALID,
    [TALKINTERACTION_TAILS_2]   = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_TAILS_MCF,
    [TALKINTERACTION_MARINE_2]  = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_RAC_MCF,
    [TALKINTERACTION_TABBY_2]   = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF,
    [TALKINTERACTION_KYLOK]     = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SCR_MCF,
    [TALKINTERACTION_COLONEL_3] = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SPY_MCF,
    [TALKINTERACTION_GARDON]    = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_IMP_MCF,
    [TALKINTERACTION_NORMAN]    = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_VIK_MCF,
    [TALKINTERACTION_COLONEL_4] = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SPY_MCF,
    [TALKINTERACTION_DAIKUN]    = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_CRP_MCF,
    [TALKINTERACTION_COLONEL_5] = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_SPY_MCF,
    [TALKINTERACTION_DAIKUN_2]  = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_CRP_MCF,
    [TALKINTERACTION_TABBY_3]   = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_ADV_MCF,
    [TALKINTERACTION_MUZY]      = ARCHIVE_VI_MSG_CTRL_LZ7_FILE_VI_MSGC_TK_MSC_MCF,
};

static const u16 talkInteractionList_Daikun[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    0,
    0,
    0,
    0,
    0,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    3,
    3,
    4,
    4,
    4,
    4,
    4,
    6,
    6,
    6,
    6,
};

static const u16 talkInteractionList_Muzy[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    1,
    1,
    1,
    1,
};

static const u16 talkInteractionList_Norman[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    3,
    3,
    3,
    4,
    4,
    5,
    5,
    5,
    5,
    5,
    6,
    6,
    6,
    6,
};

static const u16 talkInteractionList_Marine[] = {
    MISSION_INVALID,
    1,
    2,
    3,
    3,
    4,
    5,
    5,
    6,
    7,
    7,
    7,
    8,
    8,
    9,
    9,
    10,
    11,
    11,
    12,
    12,
    13,
    14,
    15,
    15,
    16,
    16,
    17,
    14,
    14,
    18,
    18,
    19,
    20,
    21,
    21,
    21,
    22,
    22,
    22,
    22,
    22,
    22,
    22,
    23,
    23,
    23,
    23,
};

static const u16 talkInteractionList_Blaze[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    0,
    1,
    1,
    2,
    2,
    3,
    4,
    5,
    5,
    6,
    6,
    7,
    5,
    5,
    8,
    8,
    9,
    10,
    11,
    11,
    11,
    12,
    12,
    13,
    13,
    13,
    13,
    14,
    16,
    16,
    16,
    16,
};

static const u16 talkInteractionList_Setter[] = {
    MISSION_INVALID, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7,
};

static const u16 talkInteractionList_Tabby[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    0,
    1,
    1,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    5,
    5,
    5,
    6,
    6,
    7,
    7,
    7,
    7,
    7,
    9,
    9,
    9,
    9,
};

static const u16 talkInteractionList_Colonel[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    3,
    3,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    5,
    6,
    6,
    6,
    7,
    7,
    7,
    6,
    6,
    8,
    8,
    8,
    8,
    9,
    9,
    9,
    10,
    10,
    11,
    11,
    11,
    11,
    11,
    12,
    12,
    12,
    12,
};

static const u16 talkInteractionList_Gardon[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    0,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    2,
    2,
    4,
    4,
    4,
    5,
    6,
    6,
    6,
    6,
    6,
    7,
    7,
    7,
    7,
    7,
    9,
    9,
    9,
    9,
};

static const u16 talkInteractionList_Kylok[] = {
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    MISSION_INVALID,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
    4,
};

static const u16 talkInteractionList_Tails[] = {
    MISSION_INVALID,
    9,
    7,
    10,
    10,
    11,
    12,
    12,
    13,
    14,
    14,
    15,
    16,
    16,
    17,
    17,
    18,
    19,
    19,
    20,
    20,
    21,
    22,
    22,
    23,
    24,
    24,
    25,
    22,
    22,
    26,
    26,
    27,
    28,
    29,
    29,
    30,
    31,
    31,
    32,
    32,
    32,
    32,
    33,
    34,
    34,
    34,
    34,
};

static const u16 postGameMissionIslandListMuzy[] = {
    MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID,
    MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID,
    MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID,
    MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID,
    MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID, MISSION_INVALID,
    SAVE_ISLAND_3,   SAVE_ISLAND_4,   SAVE_ISLAND_5,   SAVE_ISLAND_9,   SAVE_ISLAND_11,  SAVE_ISLAND_12,  SAVE_ISLAND_13,
};

static const u16 postGameMissionListMuzy[] = {
    MISSION_0,  MISSION_1,  MISSION_3,  MISSION_4,  MISSION_5,  MISSION_8,  MISSION_10, MISSION_11, MISSION_12, MISSION_14, MISSION_15, MISSION_18,
    MISSION_20, MISSION_21, MISSION_22, MISSION_24, MISSION_25, MISSION_28, MISSION_30, MISSION_31, MISSION_32, MISSION_34, MISSION_35, MISSION_38,
    MISSION_40, MISSION_41, MISSION_42, MISSION_44, MISSION_45, MISSION_46, MISSION_50, MISSION_51, MISSION_52, MISSION_54, MISSION_55, MISSION_56,
    MISSION_58, MISSION_60, MISSION_61, MISSION_62, MISSION_64, MISSION_65, MISSION_66, MISSION_68, MISSION_70, MISSION_72, MISSION_73, MISSION_74,
    MISSION_75, MISSION_76, MISSION_78, MISSION_80, MISSION_82, MISSION_87, MISSION_90, MISSION_92, MISSION_94,
};

// --------------------
// FUNCTION DECLS
// --------------------

static u16 TalkHelpers__Interaction1_Tails(void);
static u16 TalkHelpers__Interaction1_Marine(void);
static u16 TalkHelpers__Interaction1_Setter(void);
static u16 TalkHelpers__Interaction1_Colonel(void);
static u16 TalkHelpers__Interaction1_Kylok(void);
static u16 TalkHelpers__Interaction1_Muzy(void);
static u16 TalkHelpers__Interaction1_Norman(void);

static u16 TalkHelpers__Interaction2_Tails(void);
static u16 TalkHelpers__Interaction2_Tabby(void);
static u16 TalkHelpers__Interaction2_Kylok(void);
static u16 TalkHelpers__Interaction2_Daikun(void);

static u16 TalkHelpers__Interaction3_Marine(void);
static u16 TalkHelpers__Interaction3_Setter(void);
static u16 TalkHelpers__Interaction3_Tabby(void);
static u16 TalkHelpers__Interaction3_Kylok(void);
static u16 TalkHelpers__Interaction3_Gardon(void);
static u16 TalkHelpers__Interaction3_Daikun(void);
static u16 TalkHelpers__Interaction3_Norman(void);
static u16 TalkHelpers__Interaction3_Muzy(void);

// --------------------
// VARIABLES (PART 2)
// --------------------

static TalkHelperFunc talkInteractionTable2[TALKINTERACTION_COUNT] = {
    [TALKINTERACTION_TAILS]     = TalkHelpers__Interaction2_Tails,
    [TALKINTERACTION_MARINE]    = NULL,
    [TALKINTERACTION_BLAZE]     = NULL,
    [TALKINTERACTION_TABBY]     = TalkHelpers__Interaction2_Tabby,
    [TALKINTERACTION_COLONEL]   = NULL,
    [TALKINTERACTION_SETTER]    = NULL,
    [TALKINTERACTION_COLONEL_2] = NULL,
    [TALKINTERACTION_7]         = NULL,
    [TALKINTERACTION_8]         = NULL,
    [TALKINTERACTION_TAILS_2]   = NULL,
    [TALKINTERACTION_MARINE_2]  = NULL,
    [TALKINTERACTION_TABBY_2]   = TalkHelpers__Interaction2_Tabby,
    [TALKINTERACTION_KYLOK]     = TalkHelpers__Interaction2_Kylok,
    [TALKINTERACTION_COLONEL_3] = NULL,
    [TALKINTERACTION_GARDON]    = NULL,
    [TALKINTERACTION_NORMAN]    = NULL,
    [TALKINTERACTION_COLONEL_4] = NULL,
    [TALKINTERACTION_DAIKUN]    = TalkHelpers__Interaction2_Daikun,
    [TALKINTERACTION_COLONEL_5] = NULL,
    [TALKINTERACTION_DAIKUN_2]  = TalkHelpers__Interaction2_Daikun,
    [TALKINTERACTION_TABBY_3]   = TalkHelpers__Interaction2_Tabby,
    [TALKINTERACTION_MUZY]      = NULL,
};

static const u16 *talkInteractionTable0[TALKINTERACTION_COUNT] = {
    [TALKINTERACTION_TAILS]     = talkInteractionList_Tails,
    [TALKINTERACTION_MARINE]    = talkInteractionList_Marine,
    [TALKINTERACTION_BLAZE]     = talkInteractionList_Blaze,
    [TALKINTERACTION_TABBY]     = talkInteractionList_Tabby,
    [TALKINTERACTION_COLONEL]   = talkInteractionList_Colonel,
    [TALKINTERACTION_SETTER]    = talkInteractionList_Setter,
    [TALKINTERACTION_COLONEL_2] = talkInteractionList_Colonel,
    [TALKINTERACTION_7]         = NULL,
    [TALKINTERACTION_8]         = NULL,
    [TALKINTERACTION_TAILS_2]   = talkInteractionList_Tails,
    [TALKINTERACTION_MARINE_2]  = talkInteractionList_Marine,
    [TALKINTERACTION_TABBY_2]   = talkInteractionList_Tabby,
    [TALKINTERACTION_KYLOK]     = talkInteractionList_Kylok,
    [TALKINTERACTION_COLONEL_3] = talkInteractionList_Colonel,
    [TALKINTERACTION_GARDON]    = talkInteractionList_Gardon,
    [TALKINTERACTION_NORMAN]    = talkInteractionList_Norman,
    [TALKINTERACTION_COLONEL_4] = talkInteractionList_Colonel,
    [TALKINTERACTION_DAIKUN]    = talkInteractionList_Daikun,
    [TALKINTERACTION_COLONEL_5] = talkInteractionList_Colonel,
    [TALKINTERACTION_DAIKUN_2]  = talkInteractionList_Daikun,
    [TALKINTERACTION_TABBY_3]   = talkInteractionList_Tabby,
    [TALKINTERACTION_MUZY]      = talkInteractionList_Muzy,
};

static TalkHelperFunc talkInteractionTable1[TALKINTERACTION_COUNT] = {
    [TALKINTERACTION_TAILS]     = TalkHelpers__Interaction1_Tails,
    [TALKINTERACTION_MARINE]    = TalkHelpers__Interaction1_Marine,
    [TALKINTERACTION_BLAZE]     = NULL,
    [TALKINTERACTION_TABBY]     = NULL,
    [TALKINTERACTION_COLONEL]   = TalkHelpers__Interaction1_Colonel,
    [TALKINTERACTION_SETTER]    = TalkHelpers__Interaction1_Setter,
    [TALKINTERACTION_COLONEL_2] = TalkHelpers__Interaction1_Colonel,
    [TALKINTERACTION_7]         = NULL,
    [TALKINTERACTION_8]         = NULL,
    [TALKINTERACTION_TAILS_2]   = TalkHelpers__Interaction1_Tails,
    [TALKINTERACTION_MARINE_2]  = TalkHelpers__Interaction1_Marine,
    [TALKINTERACTION_TABBY_2]   = NULL,
    [TALKINTERACTION_KYLOK]     = TalkHelpers__Interaction1_Kylok,
    [TALKINTERACTION_COLONEL_3] = TalkHelpers__Interaction1_Colonel,
    [TALKINTERACTION_GARDON]    = NULL,
    [TALKINTERACTION_NORMAN]    = TalkHelpers__Interaction1_Norman,
    [TALKINTERACTION_COLONEL_4] = TalkHelpers__Interaction1_Colonel,
    [TALKINTERACTION_DAIKUN]    = NULL,
    [TALKINTERACTION_COLONEL_5] = TalkHelpers__Interaction1_Colonel,
    [TALKINTERACTION_DAIKUN_2]  = NULL,
    [TALKINTERACTION_TABBY_3]   = NULL,
    [TALKINTERACTION_MUZY]      = TalkHelpers__Interaction1_Muzy,
};

static TalkHelperFunc talkInteractionTable3[TALKINTERACTION_COUNT] = {
    [TALKINTERACTION_TAILS]     = NULL,
    [TALKINTERACTION_MARINE]    = TalkHelpers__Interaction3_Marine,
    [TALKINTERACTION_BLAZE]     = NULL,
    [TALKINTERACTION_TABBY]     = TalkHelpers__Interaction3_Tabby,
    [TALKINTERACTION_COLONEL]   = NULL,
    [TALKINTERACTION_SETTER]    = TalkHelpers__Interaction3_Setter,
    [TALKINTERACTION_COLONEL_2] = NULL,
    [TALKINTERACTION_7]         = NULL,
    [TALKINTERACTION_8]         = NULL,
    [TALKINTERACTION_TAILS_2]   = NULL,
    [TALKINTERACTION_MARINE_2]  = TalkHelpers__Interaction3_Marine,
    [TALKINTERACTION_TABBY_2]   = TalkHelpers__Interaction3_Tabby,
    [TALKINTERACTION_KYLOK]     = TalkHelpers__Interaction3_Kylok,
    [TALKINTERACTION_COLONEL_3] = NULL,
    [TALKINTERACTION_GARDON]    = TalkHelpers__Interaction3_Gardon,
    [TALKINTERACTION_NORMAN]    = TalkHelpers__Interaction3_Norman,
    [TALKINTERACTION_COLONEL_4] = NULL,
    [TALKINTERACTION_DAIKUN]    = TalkHelpers__Interaction3_Daikun,
    [TALKINTERACTION_COLONEL_5] = NULL,
    [TALKINTERACTION_DAIKUN_2]  = TalkHelpers__Interaction3_Daikun,
    [TALKINTERACTION_TABBY_3]   = TalkHelpers__Interaction3_Tabby,
    [TALKINTERACTION_MUZY]      = TalkHelpers__Interaction3_Muzy,
};

// --------------------
// FUNCTIONS
// --------------------

// TalkHelpers
u16 TalkHelpers__GetInteractionCtrl(s32 id)
{
    return messageControlFileTable[id];
}

u16 TalkHelpers__GetInteractionText1(s32 id)
{
    return talkInteractionTable0[id][TalkHelpers__GetInteraction0ID(id)];
}

u16 TalkHelpers__GetInteractionText2(s32 id)
{
    if (talkInteractionTable1[id] == NULL)
        return MISSION_INVALID;

    return talkInteractionTable1[id]();
}

u16 TalkHelpers__GetInteractionText3(s32 id)
{
    if (talkInteractionTable2[id] == NULL)
        return MISSION_INVALID;

    return talkInteractionTable2[id]();
}

u16 TalkHelpers__GetInteractionText4(s32 id)
{
    if (talkInteractionTable3[id] == NULL)
        return MISSION_INVALID;

    return talkInteractionTable3[id]();
}

u16 TalkHelpers__GetInteraction0ID(s32 id)
{
    u16 gameProgress     = SaveGame__GetGameProgress();
    u16 unknownProgress1 = SaveGame__GetUnknownProgress1();
    u16 unknownProgress2 = SaveGame__GetUnknownProgress2();

    if (gameProgress < SAVE_PROGRESS_24 || (gameProgress == SAVE_PROGRESS_24 && unknownProgress1 == 1 && unknownProgress2 == 1))
    {
        return (s32)gameProgress;
    }
    else if (gameProgress == SAVE_PROGRESS_24)
    {
        BOOL flag;
        if (id == 17 || id == 19)
        {
            flag = FALSE;
        }
        else if (id == 15)
        {
            flag = TRUE;
        }
        else if (unknownProgress2 >= 4)
        {
            flag = SaveGame__GetProgressFlags_0x1();
        }
        else
        {
            flag = TRUE;
        }

        switch (flag)
        {
            default:
                return unknownProgress1 + 23;

            case FALSE:
                return unknownProgress2 + 26;
        }
    }

    return gameProgress + 8;
}

u16 TalkHelpers__Interaction1_Tails(void)
{
    switch (SaveGame__GetGameProgress())
    {
        case SAVE_PROGRESS_8:
        case SAVE_PROGRESS_21:
        case SAVE_PROGRESS_25:
            return 0;

        case SAVE_PROGRESS_16:
            return 1;
    }

    if (SaveGame__GetNextShipUpgrade(NULL, NULL))
        return 35;

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction1_Marine(void)
{
    if (MissionHelpers__GetUnlockedMissionCount() != 0)
        return 0;

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction1_Setter(void)
{
    return 0;
}

u16 TalkHelpers__Interaction1_Colonel(void)
{
    BOOL unknownFlag      = FALSE;
    BOOL canBuyDecoration = FALSE;

    if (SaveGame__CheckProgress29())
        unknownFlag = TRUE;

    for (s32 i = 0; i < 3; i++)
    {
        if (SaveGame__CanBuyDecoration(i) && !SaveGame__GetBoughtDecoration(i))
        {
            canBuyDecoration = TRUE;
            break;
        }
    }

    if (unknownFlag && canBuyDecoration)
        return 2;

    if (unknownFlag)
        return 0;

    if (canBuyDecoration)
        return 1;

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction1_Kylok(void)
{
    return 0;
}

u16 TalkHelpers__Interaction1_Muzy(void)
{
    return 0;
}

u16 TalkHelpers__Interaction1_Norman(void)
{
    return 0;
}

// MissionHelpers
u16 TalkHelpers__Interaction3_Marine(void)
{
    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction3_Setter(void)
{
    u16 id = MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Setter), missionTable_Setter, (const u16 *)missionProgressTable_Setter, missionIslandTable_Setter,
                                                      missionValueTable_Setter);

    if (id == 23 && !MissionHelpers__CheckMissionCompleted(MISSION_84))
        return MISSION_INVALID;
    else
        return id;
}

u16 TalkHelpers__Interaction3_Tabby(void)
{
    return MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Tabby), missionTable_Tabby, (const u16 *)missionProgressTable_Tabby, missionIslandTable_Tabby,
                                                    missionValueTable_Tabby);
}

u16 TalkHelpers__Interaction3_Kylok(void)
{
    return MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Kylok), missionTable_Kylok, (const u16 *)missionProgressTable_Kylok, missionIslandTable_Kylok,
                                                    missionValueTable_Kylok);
}

u16 TalkHelpers__Interaction3_Gardon(void)
{
    return MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Gardon), missionTable_Gardon, (const u16 *)missionProgressTable_Gardon, missionIslandTable_Gardon,
                                                    missionValueTable_Gardon);
}

u16 TalkHelpers__Interaction3_Daikun(void)
{
    return MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Daikun), missionTable_Daikun, (const u16 *)missionProgressTable_Daikun, missionIslandTable_Daikun,
                                                    missionValueTable_Daikun);
}

u16 TalkHelpers__Interaction3_Norman(void)
{
    return MissionHelpers__GetInteractionForMission(ARRAY_COUNT(missionTable_Norman), missionTable_Norman, (const u16 *)missionProgressTable_Norman, missionIslandTable_Norman,
                                                    missionValueTable_Norman);
}

u16 TalkHelpers__Interaction3_Muzy(void)
{
    for (s32 i = 0; i < (s32)ARRAY_COUNT(postGameMissionListMuzy); i++)
    {
        u16 id = postGameMissionListMuzy[i];
        if (!MissionHelpers__CheckMissionCompleted(id) && MissionHelpers__CheckMissionBeaten(id))
            return 2;
    }

    return MISSION_INVALID;
}

s32 MissionHelpers__MuzyPostGameMissionCount(void)
{
    return ARRAY_COUNT(postGameMissionListMuzy);
}

u16 MissionHelpers__GetMuzyPostGameMission(u16 id)
{
    return postGameMissionListMuzy[id];
}

u16 MissionHelpers__GetMuzyPostGameMissionIsland(u16 id)
{
    return postGameMissionIslandListMuzy[id];
}

s32 MissionHelpers__MarinePostGameMissionCount(void)
{
    return ARRAY_COUNT(postGameMissionListMarine);
}

u32 MissionHelpers__GetMarinePostGameMission(u16 id)
{
    return postGameMissionListMarine[id];
}

s32 MissionHelpers__BlazeMissionCount(void)
{
    return ARRAY_COUNT(missionTable_Gardon);
}

u16 MissionHelpers__GetBlazeMission(u16 id)
{
    return missionTable_Gardon[id];
}

u16 MissionHelpers__GetInteractionForMission(u32 count, const u16 *missionTable, const u16 *progressTable, const u16 *islandTable, const u16 *value)
{
    u16 i;

    for (i = 0; i < count; i++)
    {
        if (!MissionHelpers__CheckMissionCompleted(missionTable[i]) && MissionHelpers__CheckMissionBeaten(missionTable[i]))
        {
            return value[2 * i + 1];
        }
    }

    for (i = 0; i < count; i++)
    {
        if (!MissionHelpers__CheckMissionUnlocked(missionTable[i]) && MissionHelpers__CheckSaveProgress((MissionHelpersProgressCheck *)&progressTable[3 * i])
            && MissionHelpers__CheckIslandBeaten(islandTable[i]))
        {
            return value[2 * i + 0];
        }
    }

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction2_Tails(void)
{
    u16 shipUpgradeTable[SHIP_COUNT][2] = { { 36, 37 }, { 38, 39 }, { 40, 41 }, { 42, 43 } };

    switch (SaveGame__GetGameProgress())
    {
        case SAVE_PROGRESS_1:
            if (SaveGame__Func_205BF24())
                return 2;
            else
                return 8;

        case SAVE_PROGRESS_8:
            return 3;

        case SAVE_PROGRESS_21:
            return 4;

        case SAVE_PROGRESS_25:
            return 5;
    }

    u16 ship;
    u16 level;
    if (SaveGame__GetNextShipUpgrade(&ship, &level))
        return shipUpgradeTable[ship][level - 1];

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction2_Tabby(void)
{
    if (SaveGame__GetGameProgress() == SAVE_PROGRESS_29)
        return 6;

    return MISSION_INVALID;
}

u16 TalkHelpers__Interaction2_Kylok(void)
{
    if (SaveGame__GetProgressFlags_0x10())
        return MISSION_INVALID;

    SaveGame__SetProgressFlags_0x10();
    return 1;
}

u16 TalkHelpers__Interaction2_Daikun(void)
{
    if (SaveGame__GetGameProgress() == SAVE_PROGRESS_29)
        return 3;

    return MISSION_INVALID;
}

BOOL MissionHelpers__CheckSaveProgress(MissionHelpersProgressCheck *progress)
{
    s32 gameProgress     = SaveGame__GetGameProgress();
    s32 unknownProgress1 = SaveGame__GetUnknownProgress1();
    s32 unknownProgress2 = SaveGame__GetUnknownProgress2();

    return gameProgress >= progress->gameProgress && unknownProgress1 >= progress->unknownProgress1 && unknownProgress2 >= progress->unknownProgress2;
}

BOOL MissionHelpers__CheckIslandBeaten(s32 id)
{
    if (id == MISSION_INVALID)
        return TRUE;

    return SaveGame__GetIslandProgress(&saveGame.stage.progress, id) >= SAVE_ISLAND_STATE_BEATEN;
}

void MissionHelpers__UnlockMission(s32 id)
{
    if (!MissionHelpers__CheckMissionUnlocked(id))
    {
        SaveGame__SetMissionStatus(id, MISSION_STATE_UNLOCKED);
        SaveGame__SetMissionAttempted(id, TRUE);
    }
}

BOOL MissionHelpers__CheckMissionUnlocked(s32 id)
{
    return (s32)SaveGame__GetMissionStatus(id) >= MISSION_STATE_UNLOCKED;
}

u16 MissionHelpers__GetUnlockedMissionCount(void)
{
    s32 i;
    s32 count = 0;

    for (i = 0; i < MISSION_COUNT; i++)
    {
        if (MissionHelpers__CheckMissionUnlocked(i))
            count++;
    }

    return count;
}

void MissionHelpers__BeatMission(s32 id)
{
    if (!MissionHelpers__CheckMissionBeaten(id))
    {
        SaveGame__SetMissionStatus(id, MISSION_STATE_BEATEN);

        // Check if mission 100 should be unlocked
        s32 i;
        for (i = 0; i < (MISSION_COUNT - 1); i++)
        {
            if (!MissionHelpers__CheckMissionBeaten(i))
                break;
        }

        if (i >= (MISSION_COUNT - 1))
            MissionHelpers__UnlockMission(MISSIONLIST_100);
    }
}

BOOL MissionHelpers__CheckMissionBeaten(s32 id)
{
    return (s32)SaveGame__GetMissionStatus(id) >= MISSION_STATE_BEATEN;
}

void MissionHelpers__CompleteMission(s32 id)
{
    if (!MissionHelpers__CheckMissionCompleted(id))
        SaveGame__SetMissionStatus(id, MISSION_STATE_COMPLETED);
}

BOOL MissionHelpers__CheckMissionCompleted(s32 id)
{
    return (s32)SaveGame__GetMissionStatus(id) >= MISSION_STATE_COMPLETED;
}

void MissionHelpers__ResetMissionAttempted(s32 id)
{
    SaveGame__SetMissionAttempted(id, FALSE);
}

BOOL MissionHelpers__CheckMissionAttempted(s32 id)
{
    return SaveGame__GetMissionAttempted(id);
}