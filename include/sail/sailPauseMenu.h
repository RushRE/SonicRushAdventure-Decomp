#ifndef RUSH_SAILPAUSEMENU_H
#define RUSH_SAILPAUSEMENU_H

#include <stage/stageTask.h>

// --------------------
// ENUMS
// --------------------

enum SailPauseMenuFlags_
{
    SAILPAUSEMENU_FLAG_NONE = 0x00,

    SAILPAUSEMENU_FLAG_DID_PAUSE      = 1 << 0,
    SAILPAUSEMENU_FLAG_PLAY_PAUSE_SFX = 1 << 1,

    // ???
    SAILPAUSEMENU_FLAG_UNKNOWN1 = 1 << 4,

    // ???
    SAILPAUSEMENU_FLAG_UNKNOWN2 = 1 << 13,
};
typedef u16 SailPauseMenuFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct SailPauseMenu_
{
    s32 unused;
    SailPauseMenuFlags flags;
    u16 selection;
    u8 prevPausePriority;
    StageTask *parent;
} SailPauseMenu;

// --------------------
// FUNCTIONS
// --------------------

void CreateSailPauseMenu(void);
void CreateSailReplayPauseMenu(void);

#endif // !RUSH_SAILPAUSEMENU_H
