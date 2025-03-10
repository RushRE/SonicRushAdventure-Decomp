#ifndef RUSH_SAILSEA_H
#define RUSH_SAILSEA_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailSeaVertex_
{
    VecFx16 position;
    Vec2Fx16 texCoord;
} SailSeaVertex;

typedef struct SailSeaHorizonSky_
{
    SailSeaVertex vertices[4];
} SailSeaHorizonSky;

typedef struct SailSea_
{
    s32 scrollTimer;
    VecFx32 translation;
    u16 voyageAngle;
    s16 playerAngle;
    fx32 scrollAngleSize;
    s32 seaOscillateAmplitude;
    fx32 distanceAngleSize;
    s32 seaBaseOffsetY;
    fx32 seaHorizonOffsetY;
    SailSeaVertex seaOverlayVertices[56];
    SailSeaVertex seaBaseVertices[56];
    SailSeaVertex seaHorizonVertices[56];
    SailSeaHorizonSky skyHorizon;
    VecFx32 verticesUnknown[56];
    AnimatorSprite3D aniSeaOverlayTex;
    AnimatorSprite3D aniSeaTex;
} SailSea;

// --------------------
// FUNCTIONS
// --------------------

SailSea *CreateSailSea(void);

void MoveSailSea(fx32 speed);
void SetSailSeaVoyageAngle(u16 angle);
fx32 GetSailSeaSurfacePosition(VecFx32 *position);

#endif // !RUSH_SAILSEA_H