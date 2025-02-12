#ifndef RUSH_CVITALKOPTIONS_HPP
#define RUSH_CVITALKOPTIONS_HPP

#include <hub/hubTask.hpp>
#include <game/system/threadWorker.h>
#include <hub/cviEvtCmn.hpp>

// --------------------
// STRUCTS
// --------------------

class CViTalkOptions
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnTalk eventTalk;
    Thread thread;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void InitDisplay();
    void Release();
    void ResetDisplay();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(s32 param);
    static void ThreadFunc(void *arg);

    static void Main_Init(void);
    static void Main_ChooseOption(void);
    static void Main_ChangeDifficulty(void);
    static void Main_ChangeTimeLimit(void);
    static void Main_ClearSaveDataWarning(void);
    static void Destructor(Task *task);

    static BOOL GetNormalDifficultyEnabled(void);
    static BOOL GetTimeLimit(void);
    static BOOL EnableNormalDifficulty(BOOL enabled);
    static BOOL EnableTimeLimit(BOOL enabled);
};

#endif // RUSH_CVITALKOPTIONS_HPP