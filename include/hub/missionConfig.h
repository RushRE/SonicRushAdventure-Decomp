#ifndef RUSH_MISSIONCONFIG_H
#define RUSH_MISSIONCONFIG_H

#include <global.h>
#include <game/game/missionList.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

// general purpose invalid value for mission-related logic
#define MISSION_INVALID (u16)(-1)

// --------------------
// STRUCTS
// --------------------

typedef struct MissionHelpersProgressCheck_
{
    u16 gameProgress;
    u16 zone5Progress;
    u16 zone6Progress;
} MissionHelpersProgressCheck;

// --------------------
// FUNCTIONS
// --------------------

s32 MissionHelpers__MuzyPostGameMissionCount(void);
u16 MissionHelpers__GetMuzyPostGameMission(u16 id);
u16 MissionHelpers__GetMuzyPostGameMissionIsland(u16 id);
s32 MissionHelpers__MarinePostGameMissionCount(void);
u32 MissionHelpers__GetMarinePostGameMission(u16 id);
s32 MissionHelpers__BlazeMissionCount(void);
u16 MissionHelpers__GetBlazeMission(u16 id);
u16 MissionHelpers__GetInteractionForMission(u32 count, const u16 *missionTable, const u16 *progressTable, const u16 *islandTable, const u16 *value);

BOOL MissionHelpers__CheckSaveProgress(MissionHelpersProgressCheck *progress);
BOOL MissionHelpers__CheckIslandBeaten(s32 id);
void MissionHelpers__UnlockMission(s32 id);
BOOL MissionHelpers__CheckMissionUnlocked(s32 id);
u16 MissionHelpers__GetUnlockedMissionCount(void);
void MissionHelpers__BeatMission(s32 id);
BOOL MissionHelpers__CheckMissionBeaten(s32 id);
void MissionHelpers__CompleteMission(s32 id);
BOOL MissionHelpers__CheckMissionCompleted(s32 id);
void MissionHelpers__ResetMissionAttempted(s32 id);
BOOL MissionHelpers__CheckMissionAttempted(s32 id);
void MissionHelpers__StartMission(s32 id);
s32 MissionHelpers__GetMissionID(void);
u16 MissionHelpers__GetMissionFromSelection(u16 id);
void MissionHelpers__HandleCompletedMuzyMissions(void);
u32 MissionHelpers__GetMissionDecorationReward(s32 id);
BOOL MissionHelpers__CheckPostGameMissionUnlock(void);
BOOL MissionHelpers__CheckSonicMission(s32 id);
BOOL MissionHelpers__CheckBlazeMission(s32 id);
u16 MissionHelpers__GetSolEmeraldIDFromMissionID(s32 a1);
u16 MissionHelpers__GetNpcNameAnimForMission(u16 id);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MISSIONCONFIG_H