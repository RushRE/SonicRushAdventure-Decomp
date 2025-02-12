#ifndef RUSH_CVITALKMISSIONLIST_HPP
#define RUSH_CVITALKMISSIONLIST_HPP

#include <hub/hubTask.hpp>
#include <hub/cviEvtCmn.hpp>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/graphics/unknown2056570.h>
#include <hub/cviEvtCmnList.hpp>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViTalkMissionList
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnTalk eventTalk;
    void *mpcFile;
    u16 missionCount;
    u16 selection;
    BOOL missionSelected;
    BOOL lastMissionSelected;
    s32 unused1;
    s32 unused2;
    s32 lastDrawnMissionNum;
    u32 missionID;
    u32 nextMissionID;
    BOOL isWindowOpen;
    FontWindowAnimator fontWindowAnimator;
    FontAnimator fontAnimator;
    Unknown2056570 unknown;
    void *missionNumberPixels;
    AnimatorSprite aniMissionStatus;
    AnimatorSprite aniMissionNumBackdrop;
    AnimatorSprite aniMissionStatusBackdrop;
    AnimatorSprite aniCharacterName;
    AnimatorSprite aniCharacterCircle;
    AnimatorSprite aniCharacterPortrait;
    CViEvtCmnList eventSelectList;
    CViEvtCmnListEntry *missionList;
    Thread thread;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void InitDisplay();
    void InitSprites();
    void InitList();
    void Release();
    void ResetDisplay();
    void ReleaseGraphics();
    void ReleaseList();

    void DrawUpperMissionNumber(s32 selection);
    void Draw();
    BOOL CheckThreadIdle();
    void StopThreadWorker();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);

private:
    static void ThreadFunc_Load(void *arg);
    static void Main_Init(void);
    static void Main_ShowMissionSelectPrompt(void);
    static void Main_OpeningMissionList(void);
    static void Main_MissionListActive(void);
    static void Main_MissionSelected(void);
    static void Main_ClearedAllMissionsDialog(void);
    static void Main_CloseMissionListDialog(void);
    static void Main_Finished(void);
    static void Destructor(Task *task);
    static void ThreadFunc_ChangeMissionText(void *arg);
    static void SetMissionListWindowVisible(BOOL enabled);
    static void SetMissionUnknownVisible(BOOL enabled);
    static void SetMissionListVisible(BOOL enabled);
    static void SetMissionDescriptionVisible(BOOL enabled);
    static void InitWindow(BOOL enabled, s32 scrollPos);
};

#endif // RUSH_CVITALKMISSIONLIST_HPP
