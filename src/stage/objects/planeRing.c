#include <stage/objects/planeRing.h>
#include <stage/core/ringManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_zPos mapObject->left

// --------------------
// FUNCTIONS
// --------------------

GameObjectTask *CreatePlaneRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Ring *ring = CreateStageRing3D((MapRing *)mapObject, x, y, FX32_FROM_WHOLE(mapObjectParam_zPos));

    // Create a ring for use in the fg/bg segments in sky babylon
    if (ring != NULL)
    {
        fx32 zScale;
        if (mapObjectParam_zPos >= 0)
            zScale = FLOAT_TO_FX32(0.0078125) * mapObjectParam_zPos;
        else
            zScale = FLOAT_TO_FX32(0.00390625) * mapObjectParam_zPos;

        fx32 scale = FLOAT_TO_FX32(1.0) + zScale;

        if (ring->scale.x != FLOAT_TO_FX32(1.0))
            scale = MultiplyFX(ring->scale.x, scale);

        if (scale > FLOAT_TO_FX32(2.0))
            scale = FLOAT_TO_FX32(2.0);

        ring->scale.x = ring->scale.y = ring->scale.z = scale;
    }

    return NULL;
}