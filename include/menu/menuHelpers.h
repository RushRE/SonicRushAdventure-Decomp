#ifndef RUSH_MENUHELPERS_H
#define RUSH_MENUHELPERS_H

#include <global.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTIONS
// --------------------

u16 MenuHelpers__GetStageIDForStageSelect(s32 id);
u16 MenuHelpers__GetStageIDForTimeAttackRecordsMenu(s32 id);
u16 MenuHelpers__GetStageIDFromLeaderboardID(s32 id);
s32 MenuHelpers__GetLeaderboardIDFromStageID(s32 id);
BOOL MenuHelpers__CheckStageCleared(s32 stage, BOOL useAltProgressCheck, BOOL useSystemProgress);

#endif // RUSH_MENUHELPERS_H