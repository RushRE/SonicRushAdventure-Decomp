#ifndef RUSH2_DELETESAVEDATAMENU_H
#define RUSH2_DELETESAVEDATAMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontWindow.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>

// --------------------
// ENUMS
// --------------------

enum DeleteSaveDataStatus_
{
    DELETESAVEDATA_STATUS_FAILED,
    DELETESAVEDATA_STATUS_SUCCEEDED,
};
typedef u32 DeleteSaveDataStatus;

// --------------------
// STRUCTS
// --------------------

typedef struct DeleteSaveDataMenu_
{
    FontWindow fontWindow;
    FontWindowAnimator fontWindowAnimatorMain;
    FontWindowAnimator fntWindowSelection;
    FontAnimator aniFontMain;
    FontAnimator aniFontSelection;
    FontWindowMWControl fontMWControl;
    AnimatorSprite aniCursor;
    void *mpcDeleteSaveData;
    void *fntAll;
    void *archiveSaveDelete;
    u32 timer;
    u16 selection;
    u16 msgSelection;
    BOOL windowOpen;
    BOOL deleteAllData;
    BOOL saveChanged;
    DeleteSaveDataStatus saveStatus;
    void (*state)(struct DeleteSaveDataMenu_ *work);
    void (*stateSelect)(struct DeleteSaveDataMenu_ *work);
} DeleteSaveDataMenu;

// --------------------
// FUNCTIONS
// --------------------

void CreateDeleteSaveDataMenu(void);

#endif // RUSH2_DELETESAVEDATAMENU_H