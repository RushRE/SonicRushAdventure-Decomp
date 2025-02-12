#ifndef RUSH_NPCRETRY_HPP
#define RUSH_NPCRETRY_HPP

#include <hub/cviEvtCmn.hpp>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class NpcRetry
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    CViEvtCmnTalk evtCmnTalk;
    BOOL disableRetryPrompt;
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
    static void Main_Talking(void);
    static void Destructor(Task *task);
};

#endif

// --------------------
// FUNCTIONS
// --------------------

#endif // RUSH_NPCRETRY_HPP
