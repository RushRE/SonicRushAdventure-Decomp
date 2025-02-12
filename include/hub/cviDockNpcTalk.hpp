#ifndef RUSH_CVIDOCKNPCTALK_HPP
#define RUSH_CVIDOCKNPCTALK_HPP

#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockNpcTalk
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    u16 messageID;
    u16 field_2;
    CViEvtCmnTalk eventTalk;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Release();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void RunAction(s32 id, s32 param);
    static u32 GetTalkAction(void);
    static u32 GetSelection(void);
    static void SetTalkAction(u32 value);
    static void SetSelection(s32 value);

    static void CreateMission(s32 param);
    static void CreateUnknown(s32 param);
    static void CreateTalkAction(s32 param);

    static void Create(s32 messageID);

private:
    static void CreatePrivate(s32 messageID);
    static void Main(void);
    static void Destructor(Task *task);
};

#endif // RUSH_CVIDOCKNPCTALK_HPP