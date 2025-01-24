#ifndef RUSH_EXHITCHECK_H
#define RUSH_EXHITCHECK_H

#include <ex/exTask.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct exHitCheckTaskUnknown_
{
    VecFx32 size;
    VecFx32 *position;
} exHitCheckTaskUnknown;

typedef struct exHitCheck_
{
    u8 field_0;
    u8 flags;
    u8 field_2;
    u8 field_3;
    u8 field_4;
    u8 field_5;
    u8 hitFlags;
    u8 field_7;
    u16 field_8;
    u16 field_A;
    exHitCheckTaskUnknown box;
} exHitCheck;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void ovl09_216AD9C(void);
NOT_DECOMPILED void ovl09_216ADBC(void);
NOT_DECOMPILED void ovl09_216ADD8(void);
NOT_DECOMPILED void ovl09_216ADF4(void);
NOT_DECOMPILED void ovl09_216AE08(void);
NOT_DECOMPILED void ovl09_216AE78(void);
NOT_DECOMPILED void ovl09_216B264(void);
NOT_DECOMPILED void ovl09_216B36C(void);
NOT_DECOMPILED void ovl09_216B370(void);
NOT_DECOMPILED void ovl09_216B374(void);
NOT_DECOMPILED void ovl09_216B3B0(void);
NOT_DECOMPILED void ovl09_216B3E4(void);
NOT_DECOMPILED void exHitCheckTask__Main(void);
NOT_DECOMPILED void exHitCheckTask__Func8(void);
NOT_DECOMPILED void exHitCheckTask__Destructor(void);
NOT_DECOMPILED void ovl09_216C4A4(void);
NOT_DECOMPILED void exHitCheckTask__Create(void);

#endif // RUSH_EXHITCHECK_H
