#ifndef RUSH_VIMESSAGECONTROLLER_H
#define RUSH_VIMESSAGECONTROLLER_H

#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct ViMessageController_
{
    void *controlFile;
    u16 interactionID;
    u16 pageID;
} ViMessageController;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void viMessageController__SetCtrlFile(void);
NOT_DECOMPILED void viMessageController__GetMPCFile(void);
NOT_DECOMPILED void viMessageController__SetInteractionID(void);
NOT_DECOMPILED void viMessageController__GetPageCount(void);
NOT_DECOMPILED void viMessageController__SetPageID(void);
NOT_DECOMPILED void viMessageController__HasName(void);
NOT_DECOMPILED void viMessageController__GetNameAnim(void);
NOT_DECOMPILED void viMessageController__GetPageSequence(void);
NOT_DECOMPILED void viMessageController__IsDialogIDValid(void);
NOT_DECOMPILED void viMessageController__GetDialogID(void);
NOT_DECOMPILED void viMessageController__IsDialogIDValid_2(void);
NOT_DECOMPILED void viMessageController__Entry3Enabled2(void);
NOT_DECOMPILED void viMessageController__GetEntry3ValueFromID(void);
NOT_DECOMPILED void viMessageController__GetEntry3Value2(void);
NOT_DECOMPILED void viMessageController__Entry3Enabled(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VIMESSAGECONTROLLER_H
