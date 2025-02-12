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
    CVIDOCKNPCTALK_ACTION_0,
    CVIDOCKNPCTALK_ACTION_1,
    CVIDOCKNPCTALK_ACTION_2,
    CVIDOCKNPCTALK_ACTION_3,
    CVIDOCKNPCTALK_ACTION_4,
    CVIDOCKNPCTALK_ACTION_5,
    CVIDOCKNPCTALK_ACTION_6,
    CVIDOCKNPCTALK_ACTION_7,
    CVIDOCKNPCTALK_ACTION_8,
    CVIDOCKNPCTALK_ACTION_9,
    CVIDOCKNPCTALK_ACTION_10,
    CVIDOCKNPCTALK_ACTION_11,
    CVIDOCKNPCTALK_ACTION_12,
    CVIDOCKNPCTALK_ACTION_13,
    CVIDOCKNPCTALK_ACTION_14,
    CVIDOCKNPCTALK_ACTION_15,
    CVIDOCKNPCTALK_ACTION_16,
    CVIDOCKNPCTALK_ACTION_17,
    CVIDOCKNPCTALK_ACTION_18,
    CVIDOCKNPCTALK_ACTION_19,
    CVIDOCKNPCTALK_ACTION_20,
    CVIDOCKNPCTALK_ACTION_21,
    CVIDOCKNPCTALK_ACTION_22,
    CVIDOCKNPCTALK_ACTION_23,
    CVIDOCKNPCTALK_ACTION_24,
    CVIDOCKNPCTALK_ACTION_25,
    CVIDOCKNPCTALK_ACTION_26,
    CVIDOCKNPCTALK_ACTION_27,
    CVIDOCKNPCTALK_ACTION_28,
    CVIDOCKNPCTALK_ACTION_29,
    CVIDOCKNPCTALK_ACTION_30,
    CVIDOCKNPCTALK_ACTION_31,
    CVIDOCKNPCTALK_ACTION_32,
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