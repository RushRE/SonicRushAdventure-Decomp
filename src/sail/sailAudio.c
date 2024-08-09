#include <sail/sailAudio.h>
#include <game/audio/spatialAudio.h>

// --------------------
// FUNCTIONS
// --------------------

void SailAudio__PlaySpatialSequence(NNSSndHandle *handle, s32 id, VecFx32 *position)
{
    SailAudio__PlaySpatialSequenceEx(handle, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, id, position);
}

void SailAudio__PlaySpatialSequenceEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 id, VecFx32 *position)
{
    PlaySfxEx(handle, playerNo, bankNo, playerPrio, SND_SAIL_SEQARC_ARC_VOYAGE_SE, id);

    if (position != NULL)
        ProcessSpatialSfx(handle, position);
}

void SailAudio__FadeSequence(NNSSndHandle *handle)
{
    NNS_SndPlayerStopSeq(handle, 16);
    NNS_SndHandleReleaseSeq(handle);
}

void SailAudio__PlaySequence(s32 id)
{
    PlaySfxEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SAIL_SEQARC_ARC_VOYAGE_SE, id);
}

BOOL SailAudio__CheckSequencePlaying(NNSSndHandle *handle, s32 id)
{
    if (handle == NULL)
        return FALSE;

    struct NNSSndSeqPlayer *player = handle->player;
    if (player == NULL)
        return FALSE;

    if (player->status != NNS_SND_SEQ_PLAYER_STATUS_STOP)
    {
        if (id == -1 ||                                                                       // no seq id, just check if the handle is valid at all
            (player->seqType == NNS_SND_PLAYER_SEQ_TYPE_SEQ && player->seqNo == id) ||        // check if the handle is playing this sequence
            (player->seqType == NNS_SND_PLAYER_SEQ_TYPE_SEQARC && player->seqArcIndex == id)) // check if the handle is playing this sequence from an archive
            return TRUE;
    }

    return FALSE;
}
