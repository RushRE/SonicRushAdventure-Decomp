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

void DockHelpers__LoadVillageTrack(void)
{
    LoadSysSoundVillage();

    bgmHandle = AllocSndHandle();
}

void HubAudio__Release(BOOL releaseAudio)
{
    if (bgmHandle != NULL)
    {
        HubAudio__StopSoundHandle();

        FreeSndHandle(bgmHandle);
        bgmHandle = NULL;
    }

    if (releaseAudio)
        ReleaseSysSound();
}

void HubAudio__PlayVillageTrack(void)
{
    PlaySysVillageTrack(FALSE);
}

void HubAudio__SetTrackVolume(u8 volume)
{
    SetSysTrackVolume(volume);
}

void HubAudio__FadeTrack(s32 fadeFrame)
{
    FadeSysTrack(fadeFrame);
}

void HubAudio__PlayItemJingle(void)
{
    HubAudio__StopSoundHandle();

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_ITEM, audioManagerSndHeap);
    PlayTrack(bgmHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_ITEM);
}

void HubAudio__PlayDecorationJingle(void)
{
    HubAudio__StopSoundHandle();

    NNS_SndArcLoadSeq(SND_SYS_SEQ_SEQ_J_DECORATION, audioManagerSndHeap);
    PlayTrack(bgmHandle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_J_DECORATION);
}

void HubAudio__StopSoundHandle(void)
{
    if (bgmHandle != NULL && bgmHandle->player != NULL)
    {
        NNS_SndPlayerStopSeq(bgmHandle, 0);
        NNS_SndHandleReleaseSeq(bgmHandle);
    }
}

void HubAudio__PlaySfx(HubSfxIDs id)
{
    static const u16 sfxList[] = {
        [HUB_SFX_PAUSE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_PAUSE,         [HUB_SFX_V_DECIDE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_DECIDE,
        [HUB_SFX_V_CANCELL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CANCELL, [HUB_SFX_CURSOL] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_CURSOL,
        [HUB_SFX_V_POPUP] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_POPUP,     [HUB_SFX_D_DECISION] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_D_DECISION,
        [HUB_SFX_V_CHANGE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_V_CHANGE,   [HUB_SFX_WAVE] = SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_WAVE,
    };

    PlaySysSfx(sfxList[id]);
}
