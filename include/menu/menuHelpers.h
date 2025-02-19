#ifndef RUSH_MENUHELPERS_H
#define RUSH_MENUHELPERS_H

#include <global.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u16 MenuHelpers__GetStageIDForStageSelect(s32 id);
NOT_DECOMPILED u16 MenuHelpers__GetStageIDForTimeAttackRecordsMenu(s32 id);
NOT_DECOMPILED u16 MenuHelpers__GetStageIDFromLeaderboardID(s32 id);
NOT_DECOMPILED s32 MenuHelpers__GetLeaderboardIDFromStageID(s32 id);
NOT_DECOMPILED BOOL MenuHelpers__CheckProgress(s32 progress, BOOL useAltProgressCheck, BOOL useSystemProgress);

#endif // RUSH_MENUHELPERS_H