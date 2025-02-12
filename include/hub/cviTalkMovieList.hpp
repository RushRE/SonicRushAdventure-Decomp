#ifndef RUSH_CVITALKMOVIELIST_HPP
#define RUSH_CVITALKMOVIELIST_HPP

#include <hub/hubTask.hpp>
#include <game/system/threadWorker.h>
#include <hub/cviEvtCmnList.hpp>

// --------------------
// STRUCTS
// --------------------

class CViTalkMovieList
{

public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnList eventSelectList;
    CViEvtCmnListEntry *cutsceneList;
    u16 cutsceneCount;
    u16 unused1;
    s32 unused2;
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

#endif // RUSH_CVITALKMOVIELIST_HPP
