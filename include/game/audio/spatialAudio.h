#ifndef RUSH_SPATIALAUDIO_H
#define RUSH_SPATIALAUDIO_H

#include <game/math/mtMath.h>

// --------------------
// FUNCTIONS
// --------------------

void InitSpatialAudioSystem(void);
void InitSpatialAudioConfig(void);
void SetSpatialAudioOriginPosition(VecFx32 *position);
void InitSpatialAudioMatrix(FXMatrix33 *matrix);
void SetSpatialAudioDropoffRate(fx32 rate);
fx32 GetSpatialAudioDropoffRate(void);
void SetSpatialAudioDistanceThreshold(fx32 threshold);
void ProcessSpatialSfx(NNSSndHandle *handle, VecFx32 *position);
void ProcessSpatialVoiceClip(NNSSndHandle *handle, VecFx32 *position);
void EnableSpatialVolume(void);
void DisableSpatialVolume(void);

#endif // RUSH_SPATIALAUDIO_H
