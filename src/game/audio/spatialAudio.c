#include <game/audio/spatialAudio.h>
#include <game/audio/audioSystem.h>
#include <game/math/mtMath.h>

// --------------------
// ENUMS
// --------------------

enum SpatialAudioFlags_
{
    SPATIALAUDIO_FLAG_NONE = 0,

    SPATIALAUDIO_FLAG_DISABLE_PANNING       = 1 << 0,
    SPATIALAUDIO_FLAG_DISABLE_VOLUME_CHANGE = 1 << 1,
    SPATIALAUDIO_FLAG_HAS_MATRIX            = 1 << 2,
    SPATIALAUDIO_FLAG_USE_VEC_DISTANCE      = 1 << 3,
};
typedef u32 SpatialAudioFlags;

// --------------------
// STRUCTS
// --------------------

struct SpatialAudioManager
{
    SpatialAudioFlags flags;
    fx32 dropoffRate;
    fx32 minDistanceThreshold;
    VecFx32 originPos;
    FXMatrix33 matrix;
};

// --------------------
// VARIABLES
// --------------------

static struct SpatialAudioManager sSpatialAudioManager;

// --------------------
// FUNCTION DECLS
// --------------------

static void ProcessSpatialAudio(NNSSndHandle *handle, VecFx32 *position, s32 startVolume);
static s32 GetSpatialPanning(VecFx32 *position, VecFx32 *origin);
static s32 GetSpatialVolume(VecFx32 *position, VecFx32 *origin, s32 startVolume);

// --------------------
// FUNCTIONS
// --------------------

void InitSpatialAudioSystem(void)
{
    InitSpatialAudioConfig();
}

void InitSpatialAudioConfig(void)
{
    sSpatialAudioManager.flags = SPATIALAUDIO_FLAG_NONE;

    VEC_Set(&sSpatialAudioManager.originPos, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
    sSpatialAudioManager.dropoffRate          = FLOAT_TO_FX32(256.0);
    sSpatialAudioManager.minDistanceThreshold = FLOAT_TO_FX32(0.0);

    MTX_Identity33(sSpatialAudioManager.matrix.nnMtx);
}

void SetSpatialAudioOriginPosition(VecFx32 *position)
{
    MI_CpuCopy16(position, &sSpatialAudioManager.originPos, sizeof(sSpatialAudioManager.originPos));
}

void InitSpatialAudioMatrix(FXMatrix33 *matrix)
{
    MI_CpuCopy16(matrix, &sSpatialAudioManager.matrix, sizeof(sSpatialAudioManager.matrix));

    sSpatialAudioManager.flags |= SPATIALAUDIO_FLAG_HAS_MATRIX;

    if ((sSpatialAudioManager.matrix.m[0][0] | sSpatialAudioManager.matrix.m[1][1] | sSpatialAudioManager.matrix.m[2][2]) == FLOAT_TO_FX32(1.0)
        && (sSpatialAudioManager.matrix.m[0][1] | sSpatialAudioManager.matrix.m[0][2] | sSpatialAudioManager.matrix.m[1][0] | sSpatialAudioManager.matrix.m[1][2]
            | sSpatialAudioManager.matrix.m[2][0] | sSpatialAudioManager.matrix.m[2][1])
               == FLOAT_TO_FX32(0.0))
    {
        sSpatialAudioManager.flags &= ~SPATIALAUDIO_FLAG_HAS_MATRIX;
    }
}

void SetSpatialAudioDropoffRate(fx32 rate)
{
    sSpatialAudioManager.dropoffRate = rate;
}

fx32 GetSpatialAudioDropoffRate(void)
{
    return sSpatialAudioManager.dropoffRate;
}

void SetSpatialAudioDistanceThreshold(fx32 threshold)
{
    sSpatialAudioManager.minDistanceThreshold = threshold;
}

void ProcessSpatialSfx(NNSSndHandle *handle, VecFx32 *position)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultSfxPlayer;

    ProcessSpatialAudio(handlePtr, position, GetSfxVolume());
}

void ProcessSpatialVoiceClip(NNSSndHandle *handle, VecFx32 *position)
{
    NNSSndHandle *handlePtr = handle;
    if (handle == NULL)
        handlePtr = &gDefaultVoicePlayer;

    ProcessSpatialAudio(handlePtr, position, GetVoiceVolume());
}

void ProcessSpatialAudio(NNSSndHandle *handle, VecFx32 *position, s32 startVolume)
{
    if (position == NULL)
        return;

    if ((sSpatialAudioManager.flags & SPATIALAUDIO_FLAG_DISABLE_VOLUME_CHANGE) == 0)
    {
        NNS_SndPlayerSetVolume(handle, GetSpatialVolume(position, &sSpatialAudioManager.originPos, startVolume));
    }

    if ((sSpatialAudioManager.flags & SPATIALAUDIO_FLAG_DISABLE_PANNING) == 0)
    {
        NNS_SndPlayerSetTrackPan(handle, 0xFFFF, GetSpatialPanning(position, &sSpatialAudioManager.originPos));
    }
}

void EnableSpatialVolume(void)
{
    sSpatialAudioManager.flags &= ~SPATIALAUDIO_FLAG_DISABLE_VOLUME_CHANGE;
}

void DisableSpatialVolume(void)
{
    sSpatialAudioManager.flags |= SPATIALAUDIO_FLAG_DISABLE_VOLUME_CHANGE;
}

s32 GetSpatialPanning(VecFx32 *position, VecFx32 *origin)
{
    VecFx32 distance;

    VEC_Subtract(position, origin, &distance);

    if ((sSpatialAudioManager.flags & SPATIALAUDIO_FLAG_HAS_MATRIX) != 0)
        MTX_MultVec33(&distance, sSpatialAudioManager.matrix.nnMtx, &distance);

    if ((distance.x | distance.y | distance.z) != 0)
        VEC_Normalize(&distance, &distance);

    s32 volume = FX32_TO_WHOLE(distance.x << 7);
    return MTM_MATH_CLIP(volume, -128, 127);
}

s32 GetSpatialVolume(VecFx32 *position, VecFx32 *origin, s32 startVolume)
{
    fx32 dist;

    if ((sSpatialAudioManager.flags & SPATIALAUDIO_FLAG_USE_VEC_DISTANCE) != 0)
    {
        dist = VEC_Distance(position, origin);
    }
    else
    {
        VecFx32 distance;

        VEC_Subtract(position, origin, &distance);

        distance.x = MATH_ABS(distance.x);
        distance.y = MATH_ABS(distance.y);
        distance.z = MATH_ABS(distance.z);

        if (position->z != origin->z)
        {
            dist = distance.x;

            if (distance.x > distance.y)
            {
                dist = MT_MATH_MAX(distance.x, distance.z);
            }
            else
            {
                dist = MT_MATH_MAX(distance.y, distance.z);
            }
        }
        else
        {
            dist = MT_MATH_MAX(distance.x, distance.y);
        }
    }

    if (dist > sSpatialAudioManager.minDistanceThreshold)
    {
        fx32 thresholdDistance = dist - sSpatialAudioManager.minDistanceThreshold;
        if (thresholdDistance <= sSpatialAudioManager.dropoffRate)
            startVolume = FX32_TO_WHOLE(MultiplyFX(FX32_FROM_WHOLE(startVolume), FLOAT_TO_FX32(1.0) - FX_Div(thresholdDistance, sSpatialAudioManager.dropoffRate)));
        else
            startVolume = AUDIOMANAGER_VOLUME_MIN;
    }

    return MTM_MATH_CLIP(startVolume, AUDIOMANAGER_VOLUME_MIN, AUDIOMANAGER_VOLUME_MAX);
}
