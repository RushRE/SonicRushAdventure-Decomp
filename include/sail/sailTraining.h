#ifndef RUSH_SAILTRAINING_H
#define RUSH_SAILTRAINING_H

#include <stage/stageTask.h>

// --------------------
// ENUMS
// --------------------

enum SailTrainingFlags
{
    SAILTRAINING_FLAG_NONE = 0x00,

    SAILTRAINING_FLAG_FINISHED                 = 1 << 0,
    SAILTRAINING_FLAG_CREATED_FIRST_DIALOG     = 1 << 1,
    SAILTRAINING_FLAG_CREATED_GOOD_LUCK_DIALOG = 1 << 2,
};

// --------------------
// STRUCTS
// --------------------

typedef struct SailTraining_
{
    u16 mode;
    BOOL (*state)(void);
    u16 flags;
    u16 field_A;
    s32 timer;
    s32 quota;

    union
    {
        struct
        {
            s32 rings;
            u32 flags;
        } jet;

        struct
        {
            s32 rings;
            u32 flags;
        } boat;

        struct
        {
            s32 rings;
            u32 flags;
        } hover;

        struct
        {
            u32 enemyDefeatCount;
            u32 flags;
        } submarine;
    };

    StageTask *sailTrainingDialog;
} SailTraining;

// --------------------
// FUNCTIONS
// --------------------

void CreateSailTraining(void);

#endif // !RUSH_SAILTRAINING_H