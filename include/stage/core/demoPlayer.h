#ifndef RUSH2_DEMOPLAYER_H
#define RUSH2_DEMOPLAYER_H

#include <stage/stageTask.h>

// --------------------
// ENUMS
// --------------------

enum DemoState_
{
    DEMOPLAYER_STATE_NOT_SKIPPED,
    DEMOPLAYER_STATE_WAS_SKIPPED,
};
typedef u32 DemoState;

enum DemoPlayAnimator
{
    DEMOPLAY_ANIMATOR_DEMO_PLAY,
    DEMOPLAY_ANIMATOR_PRESS_START,

    DEMOPLAY_ANIMATOR_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct DemoConfig_
{
    const char *keydataPath;
    fx32 spawnX;
    fx32 spawnY;
    u32 demoDuration;
    u16 stageID;
    u32 characterID;
} DemoConfig;

typedef struct DemoPlayer_
{
    s32 timer;
    void *sprDemoPlay;
    AnimatorSpriteDS aniDemoPlay[DEMOPLAY_ANIMATOR_COUNT];
    u32 flashTimer;
} DemoPlayer;

// --------------------
// FUNCTIONS
// --------------------

void InitZoneDemoEvent(void);
const char *GetCurrentDemoPath(void);
void GetDemoSpawnPosition(fx32 *x, fx32 *y);
BOOL HasDemoSpawnPos(void);
void CreateDemoPlayer(void);
DemoState GetDemoState(void);

#endif // RUSH2_DEMOPLAYER_H
