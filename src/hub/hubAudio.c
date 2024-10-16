#include <hub/hubAudio.h>
#include <game/audio/audioSystem.h>
#include <game/audio/sysSound.h>

// --------------------
// VARIABLES
// --------------------

static NNSSndHandle *bgmHandle;

// --------------------
// FUNCTIONS
// --------------------

void InitHubAudio(void)
{
    LoadSysSoundVillage();

    bgmHandle = AllocSndHandle();
}

void ReleaseHubAudio(BOOL releaseAudio)
{
    if (bgmHandle != NULL)
    {
        ReleaseHubBGM();

        FreeSndHandle(bgmHandle);
        bgmHandle = NULL;
    }

    if (releaseAudio)
    {
        ReleaseSysSound();
    }
}

void PlayHubBGM(void)
{
    PlaySysVillageTrack(FALSE);
}

void SetHubBGMVolume(u8 volume)
{
    SetSysTrackVolume(volume);
}

void FadeOutHubBGM(s32 fadeFrame)
{
    FadeSysTrack(fadeFrame);
}

void PlayHubItemJingle(void)
{
    ReleaseHubBGM();

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_ITEM, audioManagerSndHeap);
    PlayTrack(bgmHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_ITEM);
}

void PlayHubDecorationJingle(void)
{
    ReleaseHubBGM();

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_DECORATION, audioManagerSndHeap);
    PlayTrack(bgmHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_DECORATION);
}

void ReleaseHubBGM(void)
{
    if (bgmHandle != NULL && bgmHandle->player != NULL)
    {
        StopStageSfx(bgmHandle);
        ReleaseStageSfx(bgmHandle);
    }
}

void PlayHubSfx(HubSfxIDs id)
{
    static const u16 sfxList[HUB_SFX_COUNT] = {
        [HUB_SFX_PAUSE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_PAUSE,         [HUB_SFX_V_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
        [HUB_SFX_V_CANCELL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL, [HUB_SFX_CURSOL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL,
        [HUB_SFX_V_POPUP] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_POPUP,     [HUB_SFX_D_DECISION] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_D_DECISION,
        [HUB_SFX_V_CHANGE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CHANGE,   [HUB_SFX_WAVE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_WAVE,
    };

    PlaySysSfx(sfxList[id]);
}
