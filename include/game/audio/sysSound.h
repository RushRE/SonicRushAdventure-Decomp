#ifndef RUSH2_SYSSOUND_H
#define RUSH2_SYSSOUND_H

#include <global.h>
#include <game/audio/audioSystem.h>

// --------------------
// ENUMS
// --------------------

enum SysSoundGroupID_
{
    SYSSOUND_GROUP_DL_PLAY,
    SYSSOUND_GROUP_TITLE_1,
    SYSSOUND_GROUP_TITLE_2,
    SYSSOUND_GROUP_VILLAGE1_0,
    SYSSOUND_GROUP_VILLAGE1_1,
    SYSSOUND_GROUP_VILLAGE1_2,
    SYSSOUND_GROUP_VILLAGE2_1,
    SYSSOUND_GROUP_VILLAGE2_2,
    SYSSOUND_GROUP_VILLAGE3,
    SYSSOUND_GROUP_DOCK,
    SYSSOUND_GROUP_POWERUP,
    SYSSOUND_GROUP_CHART,
    SYSSOUND_GROUP_CLEAR,
    SYSSOUND_GROUP_CLEAR_B,
    SYSSOUND_GROUP_CLEAR_F,
    SYSSOUND_GROUP_CLEAR_E,
    SYSSOUND_GROUP_TA_CLEAR,
    SYSSOUND_GROUP_TA_CLEAR_B,
    SYSSOUND_GROUP_CONVER_NOR,
    SYSSOUND_GROUP_CONVER_TEN,
    SYSSOUND_GROUP_CONVER_PIR,
    SYSSOUND_GROUP_CONVER_FIN,
    SYSSOUND_GROUP_CONVER_ANX,
    SYSSOUND_GROUP_CONVER_UND,
    SYSSOUND_GROUP_OPENING,
    SYSSOUND_GROUP_MYSTERY,
    SYSSOUND_GROUP_STAFF,
    SYSSOUND_GROUP_EMERALD,

    SYSSOUND_GROUP_COUNT,
};
typedef s32 SysSoundGroupID;

enum SysSoundMenuNavSeq_
{
    SYSSOUND_MENUNAV_DECIDE,
    SYSSOUND_MENUNAV_CANCEL,
    SYSSOUND_MENUNAV_CURSOR,
};
typedef s32 SysSoundMenuNavSeq;

// --------------------
// FUNCTIONS
// --------------------

// Admin
void ExitSysSound(void);
void LoadSysSound(SysSoundGroupID id);
void LoadSysSoundVillage(void);
void ReleaseSysSound(void);
SysSoundGroupID GetCurrentSysSoundGroup(void);

// Tracks
void PlaySysTrack(s32 seqNo, BOOL alwaysPlay);
void PlaySysVillageTrack(BOOL alwaysPlay);
void StopSysTrack(void);
void FadeSysTrack(s32 fadeFrame);
void SetSysTrackVolume(u8 volume);

// Sfx
void PlaySysSfx(s32 seqNo);
void PlaySysMenuNavSfx(SysSoundMenuNavSeq id);
void StopSysSfx(void);

// Voices(?)
void StopSysVoice(void);

// Streams
void PlaySysStream(s32 strmNo, BOOL alwaysPlay);
void StopSysStream(void);
void FadeSysStream(s32 fadeFrame);

#endif // RUSH2_SYSSOUND_H
