#include <ex/core/exRingManager.h>
#include <ex/system/exSystem.h>
#include <ex/system/exMath.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// ENUMS
// --------------------

enum ExRingConfigFlags
{
    EXRINGCONFIG_SPAWN_NONE = 0x00,

    EXRINGCONFIG_SPAWN_L8 = 1 << 0,
    EXRINGCONFIG_SPAWN_L7 = 1 << 1,
    EXRINGCONFIG_SPAWN_L6 = 1 << 2,
    EXRINGCONFIG_SPAWN_L5 = 1 << 3,
    EXRINGCONFIG_SPAWN_L4 = 1 << 4,
    EXRINGCONFIG_SPAWN_L3 = 1 << 5,
    EXRINGCONFIG_SPAWN_L2 = 1 << 6,
    EXRINGCONFIG_SPAWN_L1 = 1 << 7,

    EXRINGCONFIG_SPAWN_R1 = 1 << 8,
    EXRINGCONFIG_SPAWN_R2 = 1 << 9,
    EXRINGCONFIG_SPAWN_R3 = 1 << 10,
    EXRINGCONFIG_SPAWN_R4 = 1 << 11,
    EXRINGCONFIG_SPAWN_R5 = 1 << 12,
    EXRINGCONFIG_SPAWN_R6 = 1 << 13,
    EXRINGCONFIG_SPAWN_R7 = 1 << 14,
    EXRINGCONFIG_SPAWN_R8 = 1 << 15,
};

// --------------------
// VARIABLES
// --------------------

static s16 exRingManagerActiveRingCount;
static void *exLoopRingTaskSingleton;
static void *exRingManagerTaskSingleton;
static void *exRingLastCreatedTask;
static void *exEffectLoopRingTask__sprRing;
static AnimatorSprite3D exRingAnimator;

static struct exRingConfig exRingSpawnTable2_Normal[] = {
    {
        .spawnDelay     = 120,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingConfig exRingSpawnTable4_Normal[] = {
    {
        .spawnDelay     = 120,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingConfig exRingSpawnTable2_Easy[] = {
    {
        .spawnDelay     = 80,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingConfig exRingSpawnTable4_Easy[] = {
    {
        .spawnDelay     = 80,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingConfig exRingSpawnTable3_Easy[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable1_Normal[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable3_Normal[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable5_Normal[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable5_Easy[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable1_Easy[] = {
    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 270,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7 | EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 240,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 360,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L2,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R7 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 300,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L5,
    },

    {
        .spawnDelay     = 330,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },
};

static struct exRingConfig exRingSpawnTable0_Easy[] = {
    {
        .spawnDelay     = 0,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1 | EXRINGCONFIG_SPAWN_R1,
    },

    {
        .spawnDelay     = 120,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 15,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4 | EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4 | EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4 | EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingConfig exRingSpawnTable0_Normal[] = {
    {
        .spawnDelay     = 0,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L3,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L1,
    },

    {
        .spawnDelay     = 120,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R5,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L6,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L8 | EXRINGCONFIG_SPAWN_L7,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R2,
    },

    {
        .spawnDelay     = 15,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 60,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R3 | EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 30,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R8,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_R4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = 5,
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_L4,
    },

    {
        .spawnDelay     = SECONDS_TO_FRAMES(60.0),
        .velocity       = 1.0f,
        .spawnPos.field = EXRINGCONFIG_SPAWN_NONE,
    },
};

static struct exRingTableConfig exRingManagerSpawnTableInfo = {
    .tableID    = 1,
    .tableSizes = { ARRAY_COUNT(exRingSpawnTable0_Normal), ARRAY_COUNT(exRingSpawnTable1_Normal), ARRAY_COUNT(exRingSpawnTable2_Normal), ARRAY_COUNT(exRingSpawnTable3_Normal),
                    ARRAY_COUNT(exRingSpawnTable4_Normal), ARRAY_COUNT(exRingSpawnTable5_Normal), ARRAY_COUNT(exRingSpawnTable0_Easy), ARRAY_COUNT(exRingSpawnTable1_Easy),
                    ARRAY_COUNT(exRingSpawnTable2_Easy), ARRAY_COUNT(exRingSpawnTable3_Easy), ARRAY_COUNT(exRingSpawnTable4_Easy), ARRAY_COUNT(exRingSpawnTable5_Easy) }
};

static struct exRingConfig *exRingManagerSpawnConfig[] = {
    exRingSpawnTable0_Normal, exRingSpawnTable1_Normal, exRingSpawnTable2_Normal, exRingSpawnTable3_Normal, exRingSpawnTable4_Normal, exRingSpawnTable5_Normal,
    exRingSpawnTable0_Easy,   exRingSpawnTable1_Easy,   exRingSpawnTable2_Easy,   exRingSpawnTable3_Easy,   exRingSpawnTable4_Easy,   exRingSpawnTable5_Easy,
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExRingManager helpers
BOOL ExRingManager_InitRingSprite(EX_ACTION_BAC3D_WORK *work);
void ExRingManager_SetRingAnim(EX_ACTION_BAC3D_WORK *work, u16 anim);

// ExLoopRing
void ReleaseExLoopRingAssets(EX_ACTION_BAC3D_WORK *work);
void ExLoopRing_Main_Init(void);
void ExLoopRing_TaskUnknown(void);
void ExLoopRing_Destructor(void);
void ExLoopRing_Main_Animate(void);
BOOL CreateExLoopRing(void);

// ExRing
void ExRing_Main_Init(void);
void ExRing_TaskUnknown(void);
void ExRing_Destructor(void);
void ExRing_Main_Ring(void);
void ExRing_Action_Collect(void);
void ExRing_Main_Sparkle(void);
BOOL CreateExRing(VecFx32 position, VecFx32 velocity);

// ExRingManager
void ExRingManager_Main_Init(void);
void ExRingManager_TaskUnknown(void);
void ExRingManager_Destructor(void);
void ExRingManager_Main_Active(void);
void ConfigureExRingManagerSpawning(void);

// --------------------
// FUNCTIONS
// --------------------

// ExRingField
BOOL ExRingManager_InitRingSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);
    MI_CpuCopy8(&exRingAnimator, &work->sprite.animator, sizeof(work->sprite.animator));

    work->sprite.anim                  = EX_ACTCOM_ANI_RING;
    work->hitChecker.type              = EXHITCHECK_TYPE_RING;
    work->hitChecker.field_4.value_8   = TRUE;
    work->sprite.translation.z         = FLOAT_TO_FX32(60.0);
    work->sprite.scale.x               = FLOAT_TO_FX32(0.375);
    work->sprite.scale.y               = FLOAT_TO_FX32(0.375);
    work->sprite.scale.z               = FLOAT_TO_FX32(1.0);
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->hitChecker.box.size.x        = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.y        = FLOAT_TO_FX32(4.0);
    work->hitChecker.box.size.z        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position      = &work->sprite.translation;

    exRingManagerActiveRingCount++;

    return TRUE;
}

void ExRingManager_SetRingAnim(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    work->sprite.anim = anim;

    u32 textureSize            = Sprite__GetTextureSizeFromAnim(exEffectLoopRingTask__sprRing, 1);
    u32 paletteSize            = Sprite__GetPaletteSizeFromAnim(exEffectLoopRingTask__sprRing, 1);
    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(textureSize, GRAPHICS_ENGINE_A);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(paletteSize, GRAPHICS_ENGINE_A);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exEffectLoopRingTask__sprRing, work->sprite.anim, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels, vramPalette);
}

// ExRingField
void ReleaseExLoopRingAssets(EX_ACTION_BAC3D_WORK *work)
{
    if (work->sprite.anim == EX_ACTCOM_ANI_RING_SPARKLE)
        AnimatorSprite3D__Release(&work->sprite.animator);

    exRingManagerActiveRingCount--;
}

void ExLoopRing_Main_Init(void)
{
    exEffectLoopRingTask *work = ExTaskGetWorkCurrent(exEffectLoopRingTask);

    u32 remainingSize = 0;

    exEffectLoopRingTask__sprRing = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    remainingSize += VRAMSystem__GetPaletteUnknown();
    remainingSize += VRAMSystem__GetTextureUnknown();

    u32 textureSize = Sprite__GetTextureSizeFromAnim(exEffectLoopRingTask__sprRing, 1);
    u32 paletteSize = Sprite__GetPaletteSizeFromAnim(exEffectLoopRingTask__sprRing, 1);

    if (remainingSize >= textureSize + paletteSize)
    {
        VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(textureSize, GRAPHICS_ENGINE_A);
        VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(paletteSize, GRAPHICS_ENGINE_A);

        AnimatorSprite3D__Init(&exRingAnimator, ANIMATOR_FLAG_NONE, exEffectLoopRingTask__sprRing, EX_ACTCOM_ANI_RING, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels, vramPalette);
        AnimatorSprite3D__ProcessAnimationFast(&exRingAnimator);

        exLoopRingTaskSingleton = GetCurrentTask();

        SetCurrentExTaskMainEvent(ExLoopRing_Main_Animate);
    }
}

void ExLoopRing_TaskUnknown(void)
{
    exEffectLoopRingTask *work = ExTaskGetWorkCurrent(exEffectLoopRingTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExLoopRing_Destructor(void)
{
    exEffectLoopRingTask *work = ExTaskGetWorkCurrent(exEffectLoopRingTask);
    UNUSED(work);

    AnimatorSprite3D__Release(&exRingAnimator);

    exLoopRingTaskSingleton = NULL;
}

void ExLoopRing_Main_Animate(void)
{
    exEffectLoopRingTask *work = ExTaskGetWorkCurrent(exEffectLoopRingTask);
    UNUSED(work);

    if (exRingManagerActiveRingCount != 0)
        AnimatorSprite3D__ProcessAnimationFast(&exRingAnimator);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExLoopRing(void)
{
    Task *task = ExTaskCreate(ExLoopRing_Main_Init, ExLoopRing_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exEffectLoopRingTask);

    exEffectLoopRingTask *work = ExTaskGetWork(task, exEffectLoopRingTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExLoopRing_TaskUnknown);

    return TRUE;
}

// ExRing
void ExRing_Main_Init(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);

    exRingLastCreatedTask = GetCurrentTask();

    if (!work->active)
    {
        // NOTE: this logic does not work!
        // the line below will always update the task main func to 'ExRing_Main_Ring' instead of 'ExTask_State_Destroy'
        DestroyCurrentExTask();
    }

    SetCurrentExTaskMainEvent(ExRing_Main_Ring);
    ExRing_Main_Ring();
}

void ExRing_TaskUnknown(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExRing_Destructor(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);

    ReleaseExLoopRingAssets(&work->aniRing);

    exRingLastCreatedTask = NULL;
}

void ExRing_Main_Ring(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);

    work->aniRing.sprite.translation.y -= work->velocity.y;

    if (work->aniRing.hitChecker.hitFlags.value_1)
    {
        ExRing_Action_Collect();
        return;
    }

    if (work->aniRing.sprite.translation.x >= FLOAT_TO_FX32(90.0) || work->aniRing.sprite.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->aniRing.sprite.translation.y <= -FLOAT_TO_FX32(40.0))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->aniRing, &work->aniRing.config);
    exHitCheckTask_AddHitCheck(&work->aniRing.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExRing_Action_Collect(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);

    exSysTaskStatus *status = GetExSystemStatus();

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RING);

    if (status->rings < 999)
        status->rings++;

    work->aniRing.hitChecker.hitFlags.value_1 = FALSE;

    ExRingManager_SetRingAnim(&work->aniRing, EX_ACTCOM_ANI_RING_SPARKLE);
    SetExDrawRequestAnimStopOnFinish(&work->aniRing.config);

    SetCurrentExTaskMainEvent(ExRing_Main_Sparkle);
    ExRing_Main_Sparkle();
}

void ExRing_Main_Sparkle(void)
{
    exEffectRingTask *work = ExTaskGetWorkCurrent(exEffectRingTask);

    work->aniRing.sprite.translation.y -= work->velocity.y;

    if (work->aniRing.config.graphics.disableAnimation)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->aniRing.sprite.translation.x >= FLOAT_TO_FX32(90.0) || work->aniRing.sprite.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->aniRing.sprite.translation.y <= -FLOAT_TO_FX32(40.0))
    {
        DestroyCurrentExTask();
        return;
    }

    AnimateExDrawRequestSprite3D(&work->aniRing);
    AddExDrawRequest(&work->aniRing, &work->aniRing.config);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExRing(VecFx32 position, VecFx32 velocity)
{
    Task *task = ExTaskCreate(ExRing_Main_Init, ExRing_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exEffectRingTask);

    exEffectRingTask *work = ExTaskGetWork(task, exEffectRingTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExRing_TaskUnknown);

    if (!ExRingManager_InitRingSprite(&work->aniRing))
    {
        work->active = FALSE;
        return TRUE;
    }

    work->active = TRUE;
    SetExDrawRequestPriority(&work->aniRing.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniRing.config);
    work->aniRing.sprite.translation.x = position.x;
    work->aniRing.sprite.translation.y = position.y;
    work->velocity.x                   = velocity.x;
    work->velocity.y                   = velocity.y;
    work->velocity.z                   = velocity.z;

    return TRUE;
}

// ExRingManager
void ExRingManager_Main_Init(void)
{
    exEffectRingAdminTask *work = ExTaskGetWorkCurrent(exEffectRingAdminTask);

    exRingManagerTaskSingleton = GetCurrentTask();

    CreateExLoopRing();
    ConfigureExRingManagerSpawning();

    work->tablePos       = 0;
    work->tableLoopCount = 0;

    work->spawnConfig = exRingManagerSpawnConfig[work->tableID][work->tablePos];
    work->tableSize   = exRingManagerSpawnTableInfo.tableSizes[work->tableID];

    SetCurrentExTaskMainEvent(ExRingManager_Main_Active);
}

void ExRingManager_TaskUnknown(void)
{
    exEffectRingAdminTask *work = ExTaskGetWorkCurrent(exEffectRingAdminTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExRingManager_Destructor(void)
{
    exEffectRingAdminTask *work = ExTaskGetWorkCurrent(exEffectRingAdminTask);
    UNUSED(work);

    exRingManagerTaskSingleton = NULL;
}

void ExRingManager_Main_Active(void)
{
    exEffectRingAdminTask *work = ExTaskGetWorkCurrent(exEffectRingAdminTask);

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        if (work->spawnConfig.spawnDelay-- < 0)
        {
            VecFx32 ringPos;
            ringPos.x = FLOAT_TO_FX32(0.0);
            ringPos.y = FLOAT_TO_FX32(140.0);
            ringPos.z = FLOAT_TO_FX32(0.0);

            VecFx32 ringVel;
            ringVel.x = FLOAT_TO_FX32(0.0);

            float ringY;
            MULTIPLY_FLOAT_FX(ringY, work->spawnConfig.velocity)
            ringVel.y = ringY;

            ringVel.z = FLOAT_TO_FX32(0.0);

            if (work->spawnConfig.spawnPos.useColumnL8)
            {
                ringPos.x = FLOAT_TO_FX32(37.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL7)
            {
                ringPos.x = FLOAT_TO_FX32(32.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL6)
            {
                ringPos.x = FLOAT_TO_FX32(27.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL5)
            {
                ringPos.x = FLOAT_TO_FX32(22.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL4)
            {
                ringPos.x = FLOAT_TO_FX32(17.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL3)
            {
                ringPos.x = FLOAT_TO_FX32(12.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL2)
            {
                ringPos.x = FLOAT_TO_FX32(7.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnL1)
            {
                ringPos.x = FLOAT_TO_FX32(2.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR1)
            {
                ringPos.x = -FLOAT_TO_FX32(2.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR2)
            {
                ringPos.x = -FLOAT_TO_FX32(7.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR3)
            {
                ringPos.x = -FLOAT_TO_FX32(12.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR4)
            {
                ringPos.x = -FLOAT_TO_FX32(17.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR5)
            {
                ringPos.x = -FLOAT_TO_FX32(22.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR6)
            {
                ringPos.x = -FLOAT_TO_FX32(27.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR7)
            {
                ringPos.x = -FLOAT_TO_FX32(32.5);
                CreateExRing(ringPos, ringVel);
            }

            if (work->spawnConfig.spawnPos.useColumnR8)
            {
                ringPos.x = -FLOAT_TO_FX32(37.5);
                CreateExRing(ringPos, ringVel);
            }

            work->tablePos++;
            if (work->tablePos < work->tableSize)
            {
                work->spawnConfig = exRingManagerSpawnConfig[work->tableID][work->tablePos];
            }
            else
            {
                work->tableLoopCount++;
                work->tablePos = 0;

                work->spawnConfig = exRingManagerSpawnConfig[work->tableID][work->tablePos];

                work->tableSize = exRingManagerSpawnTableInfo.tableSizes[work->tableID];
            }
        }

        ConfigureExRingManagerSpawning();

        RunCurrentExTaskUnknownEvent();
    }
}

void ConfigureExRingManagerSpawning(void)
{
    exEffectRingAdminTask *work = ExTaskGetWorkCurrent(exEffectRingAdminTask);

    u8 tableID = 1;
    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        switch (GetExSystemStatus()->state)
        {
            case EXSYSTASK_STATE_STARTED:
            case EXSYSTASK_STATE_2:
            case EXSYSTASK_STATE_BOSS_ACTIVE:
                tableID = 0;
                break;

            case EXSYSTASK_STATE_BOSS_FLEE_DONE:
                tableID = 1;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED:
                tableID = 2;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE:
                tableID = 3;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED:
                tableID = 4;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE:
                tableID = 5;
                break;
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        switch (GetExSystemStatus()->state)
        {
            case EXSYSTASK_STATE_STARTED:
            case EXSYSTASK_STATE_2:
            case EXSYSTASK_STATE_BOSS_ACTIVE:
                tableID = 6;
                break;

            case EXSYSTASK_STATE_BOSS_FLEE_DONE:
                tableID = 7;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED:
                tableID = 8;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE:
                tableID = 9;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED:
                tableID = 10;
                break;

            case EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE:
                tableID = 11;
                break;
        }
    }

    if (exRingManagerSpawnTableInfo.tableID != tableID)
    {
        work->tableID  = tableID;
        work->tablePos = 0;

        work->spawnConfig = exRingManagerSpawnConfig[work->tableID][work->tablePos];

        u8 curTable                         = work->tableID;
        exRingManagerSpawnTableInfo.tableID = tableID;
        work->tableSize                     = exRingManagerSpawnTableInfo.tableSizes[curTable];
    }

    work->tableID = tableID;
}

void CreateExRingManager(void)
{
    Task *task =
        ExTaskCreate(ExRingManager_Main_Init, ExRingManager_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exEffectRingAdminTask);

    exEffectRingAdminTask *work = ExTaskGetWork(task, exEffectRingAdminTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExRingManager_TaskUnknown);
}

void DestroyExRingManager(void)
{
    if (exRingManagerTaskSingleton != NULL)
        DestroyExTask(exRingManagerTaskSingleton);
}