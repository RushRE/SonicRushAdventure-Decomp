#ifndef RUSH2_MAP_FAR_SYS_H
#define RUSH2_MAP_FAR_SYS_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

// MapFarSys
void MapFarSys__SetAsset(void *asset);
void *MapFarSys__GetAsset(void);
void MapFarSys__Release(void);
void MapFarSys__Build(void);
void MapFarSys__BuildBG(void);
void MapFarSys__ReleaseBG(void);
void MapFarSys__ProcessBG(void);
void MapFarSys__SetScrollSpeed(s32 id, fx32 x1, fx32 x2);
void MapFarSys__AdvanceScrollSpeed(s32 id, fx32 move);
void MapFarSys__Func_200B524(s32 a1, s32 a2, s32 a3, s8 id);
void MapFarSys__Func_200B578(void *bgFile);
void MapFarSys__Func_200B718(void);
void MapFarSys__Build_Z1(void);
void MapFarSys__Build_Z2(void);
void MapFarSys__Build_Z3(void);
void MapFarSys__Build_Z4(void);
void MapFarSys__Build_Z5(void);
void MapFarSys__Build_Z6(void);
void MapFarSys__Build_Z7(void);
void MapFarSys__Build_Z9(void);
void MapFarSys__Process_Z1(void);
void MapFarSys__Process_Z2(void);
void MapFarSys__Process_Z3(void);
void MapFarSys__Process_Z4(void);
void MapFarSys__Process_Z5(void);
void MapFarSys__Process_Z6(void);
void MapFarSys__Process_Z7(void);
void MapFarSys__Process_Z9(void);
void MapFarSys__DoFarScrollX(s32 scrollSpeed);
void MapFarSys__DoFarScrollY(void);
void MapFarSys__ProcessScroll(void);
void MapFarSys__Func_200D144(void);

#endif // RUSH2_MAP_FAR_SYS_H
