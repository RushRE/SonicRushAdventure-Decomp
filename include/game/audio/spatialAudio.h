#ifndef RUSH2_SPATIALAUDIO_H
#define RUSH2_SPATIALAUDIO_H

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

void InitSpatialAudioSystem(void);
void InitSpatialAudioConfig(void);
void SetSpatialAudioOriginPosition(VecFx32 *position);
void InitSpatialAudioMatrix(MtxFx33 *matrix);
void SetSpatialAudioDropoffRate(fx32 rate);
fx32 GetSpatialAudioDropoffRate(void);
void SetSpatialAudioDistanceThreshold(fx32 threshold);
void ProcessSpatialSfx(NNSSndHandle *handle, VecFx32 *position);
void ProcessSpatialVoiceClip(NNSSndHandle *handle, VecFx32 *position);
void EnableSpatialVolume(void);
void DisableSpatialVolume(void);

#endif // RUSH2_SPATIALAUDIO_H
