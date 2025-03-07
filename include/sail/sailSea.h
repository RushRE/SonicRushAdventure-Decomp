#ifndef RUSH_SAILSEA_H
#define RUSH_SAILSEA_H

#include <stage/stageTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailSeaUnknown_
{
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
    u16 field_8;
} SailSeaUnknown;

typedef struct SailSeaUnknown2_
{
    s32 field_0;
    s32 field_4;
    s32 field_8;
} SailSeaUnknown2;

typedef struct SailSeaUnknown3_
{
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
    u16 field_8;
    u16 field_A;
    u16 field_C;
    u16 field_E;
    u16 field_10;
    u16 field_12;
    u16 field_14;
    u16 field_16;
    u16 field_18;
    u16 field_1A;
    u16 field_1C;
    u16 field_1E;
    u16 field_20;
    u16 field_22;
} SailSeaUnknown3;

typedef struct SailSea_
{
    s32 timer;
    VecFx32 translation;
    u16 angle1;
    u16 angle2;
    u16 field_14;
    u16 field_16;
    s32 field_18;
    u16 field_1C;
    u16 field_1E;
    s32 field_20;
    u16 field_24;
    u16 field_26;
    SailSeaUnknown field_28[56];
    SailSeaUnknown field_258[56];
    SailSeaUnknown field_488[56];
    SailSeaUnknown3 field_6B8;
    u16 field_6DC;
    u16 field_6DE;
    SailSeaUnknown2 field_6E0[56];
    AnimatorSprite3D aniSeaTex1[1];
    AnimatorSprite3D aniSeaTex2;
} SailSea;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SailSea *SailSea__Create(void);

NOT_DECOMPILED void SailSea__Move(s32 a1);
NOT_DECOMPILED void SailSea__SetAngle(u16 a1);
NOT_DECOMPILED void SailSea__Destructor(Task *task);
NOT_DECOMPILED void SailSea__Main(void);
NOT_DECOMPILED void SailSea__LoadSprites(SailSea *work);
NOT_DECOMPILED void SailSea__ReleaseSprites(SailSea *work);
NOT_DECOMPILED void SailSea__Func_215FB98(SailSea *work);
NOT_DECOMPILED void SailSea__Func_215FD68(SailSea *work);
NOT_DECOMPILED void SailSea__Draw(SailSea *work);
NOT_DECOMPILED void SailSea__Func_2160104(void);
NOT_DECOMPILED void SailSea__Func_21602CC(SailSea *work);
NOT_DECOMPILED void SailSea__Func_21603E8(VecFx32 *a1, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4);
NOT_DECOMPILED fx32 SailSea__GetSurfacePosition(VecFx32 *position);
NOT_DECOMPILED GXRgb SailSea__Func_2160534(s32 a1);

#endif // !RUSH_SAILSEA_H