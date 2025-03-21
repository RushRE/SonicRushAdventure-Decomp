#ifndef RUSH_CVIDOCKNPCTALK_HPP
#define RUSH_CVIDOCKNPCTALK_HPP

#include <hub/cviEvtCmn.hpp>

// --------------------
// ENUMS
// --------------------

enum CViDockNpcTalkType
{
    CVIDOCKNPCTALK_NPC,
    CVIDOCKNPCTALK_SAILPROMPT,
    CVIDOCKNPCTALK_PURCHASE,
    CVIDOCKNPCTALK_MISSIONLIST,
    CVIDOCKNPCTALK_MISSIONCLEARED,
    CVIDOCKNPCTALK_ANNOUNCE,
    CVIDOCKNPCTALK_6,
    CVIDOCKNPCTALK_OPTIONS,
    CVIDOCKNPCTALK_MOVIELIST,
    CVIDOCKNPCTALK_GAMEOVER,
    CVIDOCKNPCTALK_ACTION,

    CVIDOCKNPCTALK_COUNT,
    CVIDOCKNPCTALK_INVALID,
};

enum CViDockNpcTalkAction
{
    CVIDOCKNPCTALK_ACTION_NONE,
    CVIDOCKNPCTALK_ACTION_START_SAILING,
    CVIDOCKNPCTALK_ACTION_START_SAIL_TRAINING,
    CVIDOCKNPCTALK_ACTION_TALKPURCHASE_SHIP,
    CVIDOCKNPCTALK_ACTION_CONSTRUCT_SHIP,
    CVIDOCKNPCTALK_ACTION_TALKPURCHASE_DECORATION,
    CVIDOCKNPCTALK_ACTION_CONSTRUCT_DECORATION,
    CVIDOCKNPCTALK_ACTION_ANNOUNCE_FROM_SELECTION,
    CVIDOCKNPCTALK_ACTION_TALK_MISSIONLIST,
    CVIDOCKNPCTALK_ACTION_START_MISSION,
    CVIDOCKNPCTALK_ACTION_ANNOUNCE_NEW_MISSION,
    CVIDOCKNPCTALK_ACTION_CONSTRUCT_DECORATION_MISSION_REWARD,
    CVIDOCKNPCTALK_ACTION_TALK_OPTIONS,
    CVIDOCKNPCTALK_ACTION_OPEN_PLAYER_NAME_MENU,
    CVIDOCKNPCTALK_ACTION_OPEN_DELETE_SAVE_MENU,
    CVIDOCKNPCTALK_ACTION_OPEN_VS_MAIN_MENU,
    CVIDOCKNPCTALK_ACTION_OPEN_STAGE_SELECT,
    CVIDOCKNPCTALK_ACTION_GOTO_JET_DOCK,
    CVIDOCKNPCTALK_ACTION_SAVE_GAME, // unused?
    CVIDOCKNPCTALK_ACTION_TALK_MOVIELIST,
    CVIDOCKNPCTALK_ACTION_MOVIELIST_CUTSCENE,
    CVIDOCKNPCTALK_ACTION_STORY_CUTSCENE,
    CVIDOCKNPCTALK_ACTION_TALKPURCHASE_INFO,
    CVIDOCKNPCTALK_ACTION_SOUND_TEST,
    CVIDOCKNPCTALK_ACTION_VIKING_CUP,
    CVIDOCKNPCTALK_ACTION_VIKING_CUP_2,
    CVIDOCKNPCTALK_ACTION_TALK_MISSION_COMPLETED,
    CVIDOCKNPCTALK_ACTION_GAMEOVER_RETRY_STAGE,
    CVIDOCKNPCTALK_ACTION_TALKPURCHASE_SHIP_UPGRADE,
    CVIDOCKNPCTALK_ACTION_UPGRADE_SHIP,
    CVIDOCKNPCTALK_ACTION_CORRUPT_SAVE,

    CVIDOCKNPCTALK_ACTION_COUNT,
    CVIDOCKNPCTALK_ACTION_INVALID,
};

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CViDockNpcTalk
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    u16 messageID;
    CViEvtCmnTalk eventTalk;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Release();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void CreateTalk(s32 type, s32 param);
    static u32 GetTalkAction(void);
    static u32 GetSelection(void);
    static void SetTalkAction(u32 action);
    static void SetSelection(s32 selection);

    static void CreateMissionClearTalk(s32 param);
    static void CreateUnknown(s32 param);
    static void CreateTalkAction(s32 param);

    static void Create(s32 messageID);

private:
    static void CreatePrivate(s32 messageID);
    static void Main(void);
    static void Destructor(Task *task);
};

#endif

#endif // RUSH_CVIDOCKNPCTALK_HPP