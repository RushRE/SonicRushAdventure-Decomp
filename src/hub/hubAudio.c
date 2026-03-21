#include <hub/hubAudio.h>
#include <game/audio/audioSystem.h>
#include <game/audio/sysSound.h>

// --------------------
// VARIABLES
// --------------------

static NNSSndHandle *sBGMHandle;

// --------------------
// FUNCTIONS
// --------------------

void InitHubAudio(void)
{
    LoadSysSoundVillage();

    sBGMHandle = AllocSndHandle();
}

void ReleaseHubAudio(BOOL releaseAudio)
{
    if (sBGMHandle != NULL)
    {
        ReleaseHubBGM();

        FreeSndHandle(sBGMHandle);
        sBGMHandle = NULL;
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

void SetHubBGMVolume(u16 volume)
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

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_ITEM, gAudioManagerSndHeap);
    PlayTrack(sBGMHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_ITEM);
}

void PlayHubDecorationJingle(void)
{
    ReleaseHubBGM();

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_DECORATION, gAudioManagerSndHeap);
    PlayTrack(sBGMHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_DECORATION);
}

void ReleaseHubBGM(void)
{
    if (sBGMHandle != NULL && sBGMHandle->player != NULL)
    {
        StopStageSfx(sBGMHandle);
        ReleaseStageSfx(sBGMHandle);
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
