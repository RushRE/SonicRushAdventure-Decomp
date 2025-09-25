#ifndef RUSH_EXHITCHECK_H
#define RUSH_EXHITCHECK_H

#include <ex/system/exTask.h>

// --------------------
// ENUMS
// --------------------

enum exHitCheckType_
{
    EXHITCHECK_TYPE_NOT_SOLID,
    EXHITCHECK_TYPE_HAZARD,
    EXHITCHECK_TYPE_ACTIVE_PLAYER,
    EXHITCHECK_TYPE_INACTIVE_PLAYER,
    EXHITCHECK_TYPE_RING,
    EXHITCHECK_TYPE_INTRO_METEOR,
};
typedef u8 exHitCheckType;

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
    exHitCheckType type;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } flags;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_2;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_3;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_4;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_5;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } hitFlags;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_7;
    s16 power;
    s16 field_A;
    exHitCheckTaskUnknown box;
} exHitCheck;


typedef struct exHitCheckTask_
{
    u8 unknown;
} exHitCheckTask;


// --------------------
// FUNCTIONS
// --------------------

void exHitCheckTask_SetPauseLevel(s32 pauseLevel);
BOOL exHitCheckTask_IsPaused(void);
void exHitCheckTask_DecPauseLevel(void);
void exHitCheckTask_InitHitChecker(exHitCheck *work);
BOOL exHitCheckTask_AddHitCheck(exHitCheck *work);
void exHitCheckTask_DoArenaBoundsCheck(void *work, u16 type);
void exHitCheckTask_Create(void);

#endif // RUSH_EXHITCHECK_H
