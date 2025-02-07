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

NOT_DECOMPILED void viMessageController__SetCtrlFile(ViMessageController *work, void *ctrlFile);
NOT_DECOMPILED u16 viMessageController__GetMPCFile(ViMessageController *work);
NOT_DECOMPILED void viMessageController__SetInteractionID(ViMessageController *work, u16 id);
NOT_DECOMPILED u16 viMessageController__GetPageCount(ViMessageController *work);
NOT_DECOMPILED void viMessageController__SetPageID(ViMessageController *work, u16 pageID);
NOT_DECOMPILED BOOL viMessageController__HasName(ViMessageController *work);
NOT_DECOMPILED u16 viMessageController__GetNameAnim(ViMessageController *work);
NOT_DECOMPILED u16 viMessageController__GetPageSequence(ViMessageController *work);
NOT_DECOMPILED s32 viMessageController__IsDialogIDValid(ViMessageController *work);
NOT_DECOMPILED u16 viMessageController__GetDialogID(ViMessageController *work);
NOT_DECOMPILED BOOL viMessageController__IsDialogIDValid_2(ViMessageController *work, s32 a2);
NOT_DECOMPILED BOOL viMessageController__Entry3Enabled2(ViMessageController *work);
NOT_DECOMPILED s32 viMessageController__GetEntry3ValueFromID(ViMessageController *work);
NOT_DECOMPILED s32 viMessageController__GetEntry3Value2(ViMessageController *work);
NOT_DECOMPILED BOOL viMessageController__Entry3Enabled(ViMessageController *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VIMESSAGECONTROLLER_H
