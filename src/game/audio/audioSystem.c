#include <game/audio/audioSystem.h>

// --------------------
// VARIABLES
// --------------------

static u8 sVoiceVolume;
static u8 sSfxVolume;
static u8 sBGMVolume;

NNSSndHandle gDefaultSfxPlayer;
NNSSndHeapHandle gAudioManagerSndHeap;
static NNSSndHandle sDefaultAllocHandle;
static void *sAudioHeapStart;
static void *sAudioHeapEnd;
NNSSndHandle gDefaultVoicePlayer;
NNSSndHandle gDefaultTrackPlayer;

static NNSSndArc sAudioManagerSndArc;

static NNSSndHandle sAudioManagerHandleList[AUDIOMANAGER_HANDLELIST_SIZE];
static u8 sAudioManagerHandleState[AUDIOMANAGER_HANDLELIST_SIZE / 8];

// --------------------
// FUNCTIONS
// --------------------

// =====
// Admin
// =====

void InitAudioSystem(size_t heapSize)
{
    NNS_SndInit();

    sAudioHeapStart = OS_GetArenaLo(OS_ARENA_MAIN);
    sAudioHeapEnd   = (void *)((u8 *)sAudioHeapStart + heapSize);
    OS_SetArenaLo(OS_ARENA_MAIN, sAudioHeapEnd);

    sAudioHeapEnd        = OS_GetArenaLo(OS_ARENA_MAIN);
    gAudioManagerSndHeap = NNS_SndHeapCreate(sAudioHeapStart, (size_t)sAudioHeapEnd - (size_t)sAudioHeapStart);

    NNS_SndHandleInit(&gDefaultTrackPlayer);
    NNS_SndHandleInit(&gDefaultSfxPlayer);
    NNS_SndHandleInit(&gDefaultVoicePlayer);

    for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        NNS_SndHandleInit(&sAudioManagerHandleList[i]);
    }

    NNS_SndHandleInit(&sDefaultAllocHandle);
    MI_CpuFill8(sAudioManagerHandleState, 0, sizeof(sAudioManagerHandleState));

    sBGMVolume   = AUDIOMANAGER_VOLUME_MAX;
    sSfxVolume   = AUDIOMANAGER_VOLUME_MAX;
    sVoiceVolume = AUDIOMANAGER_VOLUME_MAX;
}

void ReleaseAudioSystem(void)
{
    NNS_SndHandleReleaseSeq(&gDefaultTrackPlayer);
    NNS_SndHandleReleaseSeq(&gDefaultSfxPlayer);
    NNS_SndHandleReleaseSeq(&gDefaultVoicePlayer);

    ReleaseSndHandleList();
    NNS_SndHeapClear(gAudioManagerSndHeap);
    NNS_SndHeapDestroy(gAudioManagerSndHeap);

    gAudioManagerSndHeap = NNS_SndHeapCreate(sAudioHeapStart, sAudioHeapEnd - sAudioHeapStart);

    sBGMVolume   = AUDIOMANAGER_VOLUME_MAX;
    sSfxVolume   = AUDIOMANAGER_VOLUME_MAX;
    sVoiceVolume = AUDIOMANAGER_VOLUME_MAX;
}

void LoadAudioSndArc(const char *path)
{
    NNS_SndArcInit(&sAudioManagerSndArc, path, gAudioManagerSndHeap, FALSE);
    NNS_SndArcPlayerSetup(gAudioManagerSndHeap);
}

void InitAudioSystemForStage(void *data)
{
    NNS_SndArcInitOnMemory(&sAudioManagerSndArc, data);
    NNS_SndArcPlayerSetup(gAudioManagerSndHeap);
}

// ======
// Tracks
// ======

BOOL PlayTrack(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultTrackPlayer;

    if (gDefaultTrackPlayer.player != NULL)
    {
        StopStageSfx(&gDefaultTrackPlayer);
        ReleaseStageSfx(&gDefaultTrackPlayer);
    }

    if (handlePtr != &gDefaultTrackPlayer)
        ReleaseStageSfx(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sBGMVolume);
}

BOOL PlayTrackEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultTrackPlayer;

    if (gDefaultTrackPlayer.player != NULL)
    {
        StopStageSfx(&gDefaultTrackPlayer);
        ReleaseStageSfx(&gDefaultTrackPlayer);
    }

    if (handlePtr != &gDefaultTrackPlayer)
        ReleaseStageSfx(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sBGMVolume);
}

u8 GetMusicVolume(void)
{
    return sBGMVolume;
}

void SetMusicVolume(u8 volume)
{
    sBGMVolume = volume;
}

// ===
// Sfx
// ===

BOOL PlaySfx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultSfxPlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sSfxVolume);
}

BOOL PlaySfxEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultSfxPlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sSfxVolume);
}

u8 GetSfxVolume(void)
{
    return sSfxVolume;
}

void SetSfxVolume(u8 volume)
{
    sSfxVolume = volume;
}

// ======
// Voices
// ======

BOOL PlayVoiceClip(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultVoicePlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqEx(handlePtr, playerNo, bankNo, playerPrio, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sVoiceVolume);
}

BOOL PlayVoiceClipEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 seqArcNo, u32 seqNo)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultVoicePlayer;

    if (handlePtr->player != NULL)
        NNS_SndHandleReleaseSeq(handlePtr);

    NNS_SndHandleInit(handlePtr);
    NNS_SndArcPlayerStartSeqArcEx(handlePtr, playerNo, bankNo, playerPrio, seqArcNo, seqNo);
    NNS_SndPlayerSetVolume(handlePtr, sVoiceVolume);
}

u8 GetVoiceVolume(void)
{
    return sVoiceVolume;
}

void SetVoiceVolume(u8 volume)
{
    sVoiceVolume = volume;
}

// ========
// Internal
// ========

void ReleaseSndHandleList(void)
{
    for (s32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        NNS_SndHandleReleaseSeq(&sAudioManagerHandleList[i]);
    }

    NNS_SndHandleReleaseSeq(&sDefaultAllocHandle);
    MI_CpuFill8(sAudioManagerHandleState, 0, sizeof(sAudioManagerHandleState));
}

NNSSndHandle *AllocSndHandle(void)
{
    for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
    {
        if ((sAudioManagerHandleState[i >> 3] & (1 << (i & 7))) == 0)
        {
            sAudioManagerHandleState[i >> 3] |= (1 << (i & 7));
            return &sAudioManagerHandleList[i];
        }
    }

    NNS_SndHandleReleaseSeq(&sDefaultAllocHandle);
    return &sDefaultAllocHandle;
}

void FreeSndHandle(NNSSndHandle *handle)
{
    if (&sDefaultAllocHandle == handle)
    {
        NNS_SndHandleReleaseSeq(handle);
    }
    else
    {
        for (u32 i = 0; i < AUDIOMANAGER_HANDLELIST_SIZE; i++)
        {
            if (&sAudioManagerHandleList[i] == handle)
            {
                NNS_SndHandleReleaseSeq(&sAudioManagerHandleList[i]);
                sAudioManagerHandleState[i >> 3] &= ~(1 << (i & 7));
                return;
            }
        }
    }
}
