#ifndef RUSH2_SAILRIVALCONTROLLER_H
#define RUSH2_SAILRIVALCONTROLLER_H

#include <stage/stageTask.h>

// --------------------
// TYPES
// --------------------

struct SailPlayer_;

// --------------------
// CONSTANTS/MACROS
// --------------------

#define SAILRIVAL_GET_ACTION_FLAG(action) (1 << (action))

// --------------------
// ENUMS
// --------------------

enum SailRivalAction_
{
    SAILRIVAL_ACTION_NONE,
    SAILRIVAL_ACTION_DISABLE_PREV_TOUCH_POS,
    SAILRIVAL_ACTION_START_BOOST,
    SAILRIVAL_ACTION_STOP_BOOST,
    SAILRIVAL_ACTION_JUMP_RAMP,
    SAILRIVAL_ACTION_DO_TRICK,
    SAILRIVAL_ACTION_TAKE_DAMAGE,
    SAILRIVAL_ACTION_DROP_BOMB,
    SAILRIVAL_ACTION_LAUNCH_TORPEDO,
    SAILRIVAL_ACTION_END,
};
typedef u16 SailRivalAction;

// --------------------
// STRUCTS
// --------------------

typedef struct SailRivalControllerEntry_
{
    u32 position;
    SailRivalAction type;
    u32 touchOnX;
} SailRivalControllerEntry;

typedef struct SailRivalControllerHeader_
{
    SailRivalControllerEntry entries[1];
} SailRivalControllerHeader;

typedef struct SailRival_
{
    u32 flags;
    s32 timer;
    s32 racePosition;
    s32 entryID;
    s32 actions;
    s16 disablePrevPosTimer;
    u16 field_16;
    SailRivalControllerHeader *file;
    struct SailPlayer_ *parent;
    s16 touchPosX;
    u32 curPosition;
    s16 curTouchPosX;
    u32 nextPosition;
    s16 nextTouchPosX;
} SailRival;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SailRival *SailRival__Create(struct SailPlayer_ *parent, SailRivalControllerHeader *controller, const char *path);

NOT_DECOMPILED void SailRival__Destructor(Task *task);
NOT_DECOMPILED void SailRival__Main(void);

#endif // !RUSH2_SAILRIVALCONTROLLER_H