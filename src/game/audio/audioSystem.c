#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------

static u8 voiceVolume;
static u8 sfxVolume;
static u8 musicVolume;

NNSSndHandle defaultSfxPlayer;
NNSSndHeapHandle audioManagerSndHeap;
static NNSSndHandle defaultAllocHandle;
static void *audioHeapStart;
static void *audioHeapEnd;
NNSSndHandle defaultVoicePlayer;
NNSSndHandle defaultTrackPlayer;

static NNSSndArc audioManagerSndArc;

static NNSSndHandle audioManagerHandleList[AUDIOMANAGER_HANDLELIST_SIZE];
static u8 audioManagerHandleState[AUDIOMANAGER_HANDLELIST_SIZE / 8];

// --------------------
// FUNCTIONS
// --------------------

// =====
// Admin
// =====

void InitAudioSystem(size_t heapSize)
{
    NNS_SndInit();

    audioHeapStart = OS_GetArenaLo(OS_ARENA_MAIN);
    audioHeapEnd   = (void *)((u8 *)audioHeapStart + heapSize);
    OS_SetArenaLo(OS_ARENA_MAIN, audioHeapEnd);

    audioHeapEnd        = OS_GetArenaLo(OS_ARENA_MAIN);
    audioManagerSndHeap = NNS_SndHeapCreate(audioHeapStart, (size_t)audioHeapEnd - (size_t)audioHeapStart);

    NNS_SndHandleInit(&defaultTrackPlayer);
    NNS_SndHandleInit(&defaultSfxPlayer);
    NNS_SndHandleInit(&defaultVoicePlayer);

    for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        NNS_SndHandleInit(&audioManagerHandleList[i]);
    }

    NNS_SndHandleInit(&defaultAllocHandle);
    MI_CpuFill8(audioManagerHandleState, 0, sizeof(audioManagerHandleState));

    musicVolume = AUDIOMANAGER_VOLUME_MAX;
    sfxVolume   = AUDIOMANAGER_VOLUME_MAX;
    voiceVolume = AUDIOMANAGER_VOLUME_MAX;
}

void ReleaseAudioSystem(void)
{
    NNS_SndHandleReleaseSeq(&defaultTrackPlayer);
    NNS_SndHandleReleaseSeq(&defaultSfxPlayer);
    NNS_SndHandleReleaseSeq(&defaultVoicePlayer);

    ReleaseSndHandleList();
    NNS_SndHeapClear(audioManagerSndHeap);
    NNS_SndHeapDestroy(audioManagerSndHeap);

    audioManagerSndHeap = NNS_SndHeapCreate(audioHeapStart, audioHeapEnd - audioHeapStart);

    musicVolume = AUDIOMANAGER_VOLUME_MAX;
    sfxVolume   = AUDIOMANAGER_VOLUME_MAX;
    voiceVolume = AUDIOMANAGER_VOLUME_MAX;
}

void LoadAudioSndArc(const char *path)
{
    NNS_SndArcInitWithResult(&audioManagerSndArc, path, audioManagerSndHeap, FALSE);
    NNS_SndArcPlayerSetup(audioManagerSndHeap);
}

void InitAudioSystemForStage(void *data)
{
    NNS_SndArcInitOnMemory(&audioManagerSndArc, data);
    NNS_SndArcPlayerSetup(audioManagerSndHeap);
}

// ======
// Tracks
// ======

BOOL PlayTrack(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultTrackPlayer;

    if (defaultTrackPlayer.player != NULL)
    {
        NNS_SndPlayerStopSeq(&defaultTrackPlayer, 0);
        NNS_SndHandleReleaseSeq(&defaultTrackPlayer);
    }

    if (handlePtr != &defaultTrackPlayer)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, musicVolume);
}

BOOL PlayTrackEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultTrackPlayer;

    if (defaultTrackPlayer.player != NULL)
    {
        NNS_SndPlayerStopSeq(&defaultTrackPlayer, 0);
        NNS_SndHandleReleaseSeq(&defaultTrackPlayer);
    }

    if (handlePtr != &defaultTrackPlayer)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, musicVolume);
}

u8 GetMusicVolume(void)
{
    return musicVolume;
}

void SetMusicVolume(u8 volume)
{
    musicVolume = volume;
}

// ===
// Sfx
// ===

BOOL PlaySfx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultSfxPlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sfxVolume);
}

BOOL PlaySfxEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultSfxPlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sfxVolume);
}

u8 GetSfxVolume(void)
{
    return sfxVolume;
}

void SetSfxVolume(u8 volume)
{
    sfxVolume = volume;
}

// ======
// Voices
// ======

BOOL PlayVoiceClip(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultVoicePlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, voiceVolume);
}

BOOL PlayVoiceClipEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &defaultVoicePlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, voiceVolume);
}

u8 GetVoiceVolume(void)
{
    return voiceVolume;
}

void SetVoiceVolume(u8 volume)
{
    voiceVolume = volume;
}

// ========
// Internal
// ========

void ReleaseSndHandleList(void)
{
    for (s32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        NNS_SndHandleReleaseSeq(&audioManagerHandleList[i]);
    }

    NNS_SndHandleReleaseSeq(&defaultAllocHandle);
    MI_CpuFill8(audioManagerHandleState, 0, sizeof(audioManagerHandleState));
}

NNSSndHandle *AllocSndHandle(void)
{
    for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        if ((audioManagerHandleState[i >> 3] & (1 << (i & 7))) == 0)
        {
            audioManagerHandleState[i >> 3] |= (1 << (i & 7));
            return &audioManagerHandleList[i];
        }
    }

    NNS_SndHandleReleaseSeq(&defaultAllocHandle);
    return &defaultAllocHandle;
}

void FreeSndHandle(NNSSndHandle *handle)
{
    if (&defaultAllocHandle == handle)
    {
        NNS_SndHandleReleaseSeq(handle);
    }
    else
    {
        for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
        {
            if (&audioManagerHandleList[i] == handle)
            {
                NNS_SndHandleReleaseSeq(&audioManagerHandleList[i]);
                audioManagerHandleState[i >> 3] &= ~(1 << (i & 7));
                return;
            }
        }
    }
}
