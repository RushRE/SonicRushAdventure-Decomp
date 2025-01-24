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

NOT_DECOMPILED void exHitCheckTask__Func_216AD9C(void);
NOT_DECOMPILED void exHitCheckTask__Func_216ADBC(void);
NOT_DECOMPILED void exHitCheckTask__Func_216ADD8(void);
NOT_DECOMPILED void exHitCheckTask__InitHitChecker(void);
NOT_DECOMPILED void exHitCheckTask__CheckBoxOverlap(void);
NOT_DECOMPILED void exHitCheckTask__AddHitCheck(void);
NOT_DECOMPILED void exHitCheckTask__CheckArenaBounds(void);
NOT_DECOMPILED void exHitCheckTask__Func_216B36C(void);
NOT_DECOMPILED void exHitCheckTask__Func_216B370(void);
NOT_DECOMPILED void exHitCheckTask__ArenaCheckForModel(void);
NOT_DECOMPILED void exHitCheckTask__DoArenaBoundsCheck(void);
NOT_DECOMPILED void exHitCheckTask__DoHitChecks(void);
NOT_DECOMPILED void exHitCheckTask__Main(void);
NOT_DECOMPILED void exHitCheckTask__Func8(void);
NOT_DECOMPILED void exHitCheckTask__Destructor(void);
NOT_DECOMPILED void exHitCheckTask__Main_Active(void);
NOT_DECOMPILED void exHitCheckTask__Create(void);

#endif // RUSH_EXHITCHECK_H
