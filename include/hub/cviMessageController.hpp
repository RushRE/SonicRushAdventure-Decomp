#ifndef RUSH_VIMESSAGECONTROLLER_HPP
#define RUSH_VIMESSAGECONTROLLER_HPP

#include <global.h>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CViMessageController
{
public:

    // --------------------
    // VARIABLES
    // --------------------

    void *controlFile;
    u16 interactionID;
    u16 pageID;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void SetControlFile(void *ctrlFile);
    u16 GetTextFileIndex();
    void SetInteraction(u16 id);
    u16 GetPageCount();
    void SetPageID(u16 pageID);
    BOOL CheckPageHasNameAnim();
    u16 GetPageNameAnim();
    u16 GetPageSequence();
    s32 CheckPageHasSequenceUnknown();
    u16 GetPageSequenceUnknown();
    void AdvancePage(s32 id);
    BOOL CheckPageActionEnabled();
    s32 GetPageActionType();
    s32 GetPageActionSelection();
    BOOL CheckPageHasActions();
};

#endif

#endif // RUSH_VIMESSAGECONTROLLER_HPP
