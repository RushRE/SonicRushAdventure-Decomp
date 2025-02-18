#ifndef RUSH_MENUHELPERS_H
#define RUSH_MENUHELPERS_H

#include <global.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u16 MenuHelpers__GetStageID(s32 id);
NOT_DECOMPILED u16 MenuHelpers__GetProgressFromStageID(s32 id);
NOT_DECOMPILED u16 MenuHelpers__Func_217CEA8(s32 id);
NOT_DECOMPILED s32 MenuHelpers__Func_217CEBC(s32 id);
NOT_DECOMPILED BOOL MenuHelpers__CheckProgress(s32 progress, BOOL useAltProgressCheck, BOOL useSystemProgress);

#endif // RUSH_MENUHELPERS_H