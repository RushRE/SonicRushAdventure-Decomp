#ifndef RUSH_MISSIONHELPERS_H
#define RUSH_MISSIONHELPERS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u16 MissionHelpers__Func_2153A5C(void);
NOT_DECOMPILED u32 MissionHelpers__PostGameMissionCount1(void);
NOT_DECOMPILED u32 MissionHelpers__GetPostGameMission1(u16 id);
NOT_DECOMPILED u16 MissionHelpers__GetPostGameMissionFlag1(u16 id);
NOT_DECOMPILED s32 MissionHelpers__PostGameMissionCount2(void);
NOT_DECOMPILED u32 MissionHelpers__GetPostGameMission2(u16 id);
NOT_DECOMPILED u32 MissionHelpers__BlazeMissionCount(void);
NOT_DECOMPILED BOOL MissionHelpers__IsBlazeMission(s32 id);
NOT_DECOMPILED void MissionHelpers__Func_2153B18(void);
NOT_DECOMPILED void MissionHelpers__Func_2153BF8(void);
NOT_DECOMPILED void MissionHelpers__Func_2153CEC(void);
NOT_DECOMPILED void MissionHelpers__Func_2153D08(void);
NOT_DECOMPILED void MissionHelpers__Func_2153D2C(void);
NOT_DECOMPILED BOOL MissionHelpers__CheckSaveProgress(void *progress);
NOT_DECOMPILED BOOL MissionHelpers__GetIslandProgress(s32 id);
NOT_DECOMPILED void MissionHelpers__GetPostGameMission(u32 id);
NOT_DECOMPILED void MissionHelpers__IsMissionUnlocked(void);
NOT_DECOMPILED void MissionHelpers__GetUnlockedMissionCount(void);
NOT_DECOMPILED void MissionHelpers__Func_2153E4C(u16 id);
NOT_DECOMPILED BOOL MissionHelpers__IsMissionComplete(void);
NOT_DECOMPILED void MissionHelpers__BeatMission(s32 id);
NOT_DECOMPILED BOOL MissionHelpers__IsMissionBeaten(s32 id);
NOT_DECOMPILED void MissionHelpers__ResetMissionAttempted(void);
NOT_DECOMPILED void MissionHelpers__GetMissionAttempted(void);
NOT_DECOMPILED void MissionHelpers__StartMission(u32 id);
NOT_DECOMPILED u16 MissionHelpers__GetMissionID(void);
NOT_DECOMPILED void MissionHelpers__GetMissionFromSelection_REAL(void);
NOT_DECOMPILED void MissionHelpers__HandlePostGameMissionBeaten(void);
NOT_DECOMPILED u32 MissionHelpers__GetMissionFromSelection(u32 a1);
NOT_DECOMPILED BOOL MissionHelpers__CheckPostGameMissionUnlock(void);
NOT_DECOMPILED BOOL MissionHelpers__CheckSonicMission(u16 a1);
NOT_DECOMPILED BOOL MissionHelpers__CheckBlazeMission(u16 a1);
NOT_DECOMPILED u32 MissionHelpers__GetBlazeMissionCount(u16 a1);
NOT_DECOMPILED void MissionHelpers__GetUnknown2172B10(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MISSIONHELPERS_H