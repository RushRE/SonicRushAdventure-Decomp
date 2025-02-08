#ifndef RUSH_NPCUTSCENEVIEWER_HPP
#define RUSH_NPCUTSCENEVIEWER_HPP

#include <hub/hubTask.hpp>
#include <game/system/threadWorker.h>
#include <hub/npcTalkList.hpp>

// --------------------
// STRUCTS
// --------------------

class NpcCutsceneViewer
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    NpcTalkList npcTalk;
    NpcTalkListEntry *cutsceneList;
    u16 cutsceneCount;
    u16 field_486;
    s32 field_488;
    void *mpcFile;
    Thread thread;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void InitDisplay();
    void InitList();
    void Release();
    void ResetDisplay();
    void ReleaseList();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);
    static u16 GetNextCutscene(u16 id);
    static void ThreadFunc(void *arg);

    static void Main_Init();
    static void Main_Active();
    static void Main_CloseWindow();
    static void Destructor(Task *task);
    static BOOL CheckCutsceneUnlocked(u16 id);
    static u16 GetSelectionFromCutscene();
};

#endif // RUSH_NPCUTSCENEVIEWER_HPP
