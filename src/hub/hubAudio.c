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

NONMATCH_FUNC void HubAudio__PlaySfx(HubSfxIDs id)
{
#ifdef NON_MATCHING
    static const u16 sfxList[] = {
        DCW SEQ_ARC_VILLAGE_SE_PAUSE, SEQ_ARC_VILLAGE_SE_V_DECIDE,   SEQ_ARC_VILLAGE_SE_V_CANCELL, SEQ_ARC_VILLAGE_SE_CURSOL,
        SEQ_ARC_VILLAGE_SE_V_POPUP,   SEQ_ARC_VILLAGE_SE_D_DECISION, SEQ_ARC_VILLAGE_SE_V_CHANGE,  SEQ_ARC_VILLAGE_SE_WAVE,
    };

    PlaySysSfx(HubAudio__sfxList[id]);
#else
    // clang-format off
	ldr r1, =0x02172D04
	mov r0, r0, lsl #1
	ldr ip, =PlaySysSfx
	ldrh r0, [r1, r0]
	bx ip

// clang-format on
#endif
}
