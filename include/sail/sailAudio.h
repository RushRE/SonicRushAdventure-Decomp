#ifndef RUSH2_SAILAUDIO_H
#define RUSH2_SAILAUDIO_H

#include <global.h>
#include <game/audio/audioSystem.h>

// --------------------
// FUNCTIONS
// --------------------

void SailAudio__PlaySpatialSequence(NNSSndHandle *handle, s32 id, VecFx32 *position);
void SailAudio__PlaySpatialSequenceEx(NNSSndHandle *handle, s32 playerNo, s32 bankNo, s32 playerPrio, s32 id, VecFx32 *position);
void SailAudio__FadeSequence(NNSSndHandle *handle);
void SailAudio__PlaySequence(s32 id);
BOOL SailAudio__CheckSequencePlaying(NNSSndHandle *handle, s32 id);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void SailAudio__StopSequence(s32 id)
{
    NNS_SndPlayerStopSeqBySeqArcIdx(SND_SAIL_SEQARC_ARC_VOYAGE_SE, id, 0);
}

#endif // !RUSH2_SAILAUDIO_H