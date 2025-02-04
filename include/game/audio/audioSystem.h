#ifndef RUSH_AUDIOSYSTEM_H
#define RUSH_AUDIOSYSTEM_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define AUDIOMANAGER_HANDLELIST_SIZE 128

#define AUDIOMANAGER_PLAYERNO_AUTO   -1
#define AUDIOMANAGER_BANKNO_AUTO     -1
#define AUDIOMANAGER_PLAYERPRIO_AUTO -1

#define AUDIOMANAGER_VOLUME_MIN SND_CHANNEL_VOLUME_MIN
#define AUDIOMANAGER_VOLUME_MAX SND_CHANNEL_VOLUME_MAX

#define AUDIOMANAGER_PAN_MIN    SND_CHANNEL_PAN_MIN
#define AUDIOMANAGER_PAN_CENTER SND_CHANNEL_PAN_CENTER
#define AUDIOMANAGER_PAN_MAX    SND_CHANNEL_PAN_MAX

#define AUDIOMANAGER_HEAP_SIZE 0x64000 // ~400kb

// --------------------
// ENUMS
// --------------------

#include <game/audio/audio_system.h>
#include <game/audio/audio_zone.h>
#include <game/audio/audio_sail.h>

// --------------------
// VARIABLES
// --------------------

extern NNSSndHeapHandle audioManagerSndHeap;
extern NNSSndHandle defaultSfxPlayer;
extern NNSSndHandle defaultVoicePlayer;
extern NNSSndHandle defaultTrackPlayer;

// --------------------
// FUNCTIONS
// --------------------

// Admin
void InitAudioSystem(size_t heapSize);
void ReleaseAudioSystem(void);
void LoadAudioSndArc(const char *path);
void InitAudioSystemForStage(void *data);

// Tracks
BOOL PlayTrack(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo);
BOOL PlayTrackEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo);
u8 GetMusicVolume(void);
void SetMusicVolume(u8 volume);

// Sfx
BOOL PlaySfx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo);
BOOL PlaySfxEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo);
u8 GetSfxVolume(void);
void SetSfxVolume(u8 volume);

// Voices
BOOL PlayVoiceClip(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo);
BOOL PlayVoiceClipEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo);
u8 GetVoiceVolume(void);
void SetVoiceVolume(u8 volume);

// Internal
void ReleaseSndHandleList(void);
NNSSndHandle *AllocSndHandle(void);
void FreeSndHandle(NNSSndHandle *handle);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void PlayStageSfx(enum SND_ZONE_SEQARC_GAME_SE sfxID)
{
    PlaySfxEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfxID);
}

RUSH_INLINE void PlayHandleStageSfx(NNSSndHandle *handle, enum SND_ZONE_SEQARC_GAME_SE sfxID)
{
    PlaySfxEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfxID);
}

RUSH_INLINE void PlaySystemSfx(u32 arcID, u32 sfxID)
{
    PlaySfxEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, arcID, sfxID);
}

RUSH_INLINE void PlayHandleSystemSfx(NNSSndHandle *handle, u32 arcID, u32 sfxID)
{
    PlaySfxEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, arcID, sfxID);
}

RUSH_INLINE void StopStageSfx(NNSSndHandle *handle)
{
    NNS_SndPlayerStopSeq(handle, 0);
}

RUSH_INLINE void FadeOutStageSfx(NNSSndHandle *handle, u32 frames)
{
    NNS_SndPlayerStopSeq(handle, frames);
}

RUSH_INLINE void ReleaseStageSfx(NNSSndHandle *handle)
{
    NNS_SndHandleReleaseSeq(handle);
}

RUSH_INLINE void PlayStageVoiceClip(enum SND_ZONE_SEQARC_GAME_SE sfxID)
{
    PlayVoiceClipEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfxID);
}

RUSH_INLINE void PlayHandleStageVoiceClip(NNSSndHandle *handle, enum SND_ZONE_SEQARC_GAME_SE sfxID)
{
    PlayVoiceClipEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfxID);
}

RUSH_INLINE void PlaySystemVoiceClip(u32 arcID, u32 sfxID)
{
    PlayVoiceClipEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, arcID, sfxID);
}

RUSH_INLINE void PlayHandleSystemVoiceClip(NNSSndHandle *handle, u32 arcID, u32 sfxID)
{
    PlayVoiceClipEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, arcID, sfxID);
}

RUSH_INLINE void StopStageVoiceClip(NNSSndHandle *handle)
{
    NNS_SndPlayerStopSeq(handle, 0);
}

RUSH_INLINE void FadeOutStageVoiceClip(NNSSndHandle *handle, u32 frames)
{
    NNS_SndPlayerStopSeq(handle, frames);
}

RUSH_INLINE void ReleaseStageVoiceClip(NNSSndHandle *handle)
{
    NNS_SndHandleReleaseSeq(handle);
}

#ifdef __cplusplus
}
#endif

#endif // RUSH_AUDIOSYSTEM_H