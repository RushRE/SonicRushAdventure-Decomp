#ifndef RUSH_AUTOSAVEPOPUP_H
#define RUSH_AUTOSAVEPOPUP_H

#include <game/system/task.h>
#include <game/text/fontWindow.h>
#include <game/util/saveSpriteButton.h>

// --------------------
// STRUCTS
// --------------------

typedef struct AutoSavePopup_
{
    SaveSpriteButton spriteButton;
    FontWindow fontWindow;
    void *fntAll;
    void *mpcDmta_lang;
    BOOL saveFailed;
} AutoSavePopup;

// --------------------
// FUNCTIONS
// --------------------

void CreateAutoSavePopup(void);

#endif // RUSH_AUTOSAVEPOPUP_H
