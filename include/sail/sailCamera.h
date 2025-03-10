#ifndef RUSH_SAILCAMERA_H
#define RUSH_SAILCAMERA_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailCamera_
{
    fx32 offsetY;
    fx32 targetOffsetY;
    fx32 trackY1;
    fx32 targetTrackY1;
    fx32 trackY2;
    fx32 targetTrackY2;
    fx32 radius1;
    fx32 targetRadius1;
    fx32 radius2;
    VecFx32 tracker0;
    VecFx32 tracker1;
    void (*state)(struct SailCamera_ *work);
} SailCamera;

// --------------------
// FUNCTIONS
// --------------------

SailCamera *CreateSailCamera(void);

#endif // !RUSH_SAILCAMERA_H