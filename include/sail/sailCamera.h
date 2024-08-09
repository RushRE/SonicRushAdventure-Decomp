#ifndef RUSH2_SAILCAMERA_H
#define RUSH2_SAILCAMERA_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailCamera_
{
    s32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    u32 field_18;
    u32 field_1C;
    s32 field_20;
    VecFx32 tracker0;
    VecFx32 tracker1;
    void (*state)(struct SailCamera_ *work);
} SailCamera;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SailCamera *SailCamera__Create(void);

NOT_DECOMPILED void SailCamera__Main(void);
NOT_DECOMPILED void SailCamera__State_JetHover(SailCamera *work);
NOT_DECOMPILED void SailCamera__State_Boat(SailCamera *work);

#endif // !RUSH2_SAILCAMERA_H