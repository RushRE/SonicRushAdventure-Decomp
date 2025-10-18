#include <stage/gameObject.h>
#include <game/stage/mapSys.h>
#include <game/stage/eventManager.h>
#include <game/object/objectManager.h>
#include <game/object/objPacket.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>

#include <stage/effectTask.h>
#include <stage/effects/explosion.h>
#include <stage/effects/enemyDebris.h>
#include <stage/effects/battleBurst.h>
#include <stage/effects/vitality.h>
#include <stage/effects/waterExplosion.h>

// --------------------
// EXTERN VARS
// --------------------

extern const CreateObjectFunc stageObjectSpawnList[MAPOBJECT_COUNT];

// --------------------
// VARIABLES
// --------------------

u32 usedTempObjects[(1 + GAMEOBJECT_TEMPLIST_SIZE + (32 - 1)) / 32];
MapObject tempObjectList[GAMEOBJECT_TEMPLIST_SIZE];

u8 StageTask__DefaultDiffData[512] = {
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
    ((0x8 << 0) | (0x8 << 4)), ((0x8 << 0) | (0x8 << 4)),
};

// --------------------
// FUNCTIONS
// --------------------

void GameObject__InitFromObject(GameObjectTask *work, MapObject *mapObject, fx32 x, fx32 y)
{
#ifndef NON_MATCHING
    // dunno what this is, it's unreferenced and uncompiled but it's the only way I've gotten atkFlags & defFlags to match
    static u8 __UNKNOWN__[1];
#endif

    u16 atkFlags[GAMEOBJECT_COLLIDER_COUNT] = { 0, 2, 2 };
    u16 defFlags[GAMEOBJECT_COLLIDER_COUNT] = { 1, 0, 0 };

    SetTaskInFunc(&work->objWork, GameObject__In_Default);
    work->objWork.flag |= STAGE_TASK_FLAG_ALWAYS_RUN_PPIN;

    SetTaskSpriteCallback(&work->objWork, GameObject__SpriteCallback_Default);
    SetTaskCollideFunc(&work->objWork, GameObject__Collide_Default);
    SetTaskViewCheckFunc(&work->objWork, StageTask__ViewCheck_Default);
    work->originPos.x        = x;
    work->originPos.y        = y;
    work->objWork.position.x = x;
    work->objWork.position.y = y;

    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.1640625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(15.0);

    work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;

    work->objWork.scale.x = work->objWork.scale.y = work->objWork.scale.z = FLOAT_TO_FX32(1.0);

    for (s32 i = 0; i < GAMEOBJECT_COLLIDER_COUNT; i++)
    {
        ObjRect__SetGroupFlags(&work->colliders[i], 2, 1);
        ObjRect__SetAttackStat(&work->colliders[i], atkFlags[i], OBS_RECT_HITPOWER_DEFAULT);
        ObjRect__SetDefenceStat(&work->colliders[i], defFlags[i], OBS_RECT_DEFPOWER_DEFAULT);
        work->colliders[i].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    }

    ObjRect__SetOnDefend(&work->colliders[GAMEOBJECT_COLLIDER_WEAK], GameObject__OnDefend_Enemy);

    if (mapObject != NULL)
    {
        work->mapObject    = mapObject;
        work->mapObjectX   = mapObject->x;
        work->mapObject->x = MAPOBJECT_DESTROYED;

        if (mapObject->id < MAPOBJECT_64)
            work->objWork.objType = STAGE_OBJ_TYPE_ENEMY;
        else
            work->objWork.objType = STAGE_OBJ_TYPE_OBJECT;

        work->objWork.viewOutOffset = 264 - GameObject__ViewOffsetTable[mapObject->id];
    }
    else
    {
        work->objWork.objType = STAGE_OBJ_TYPE_ENEMY;
    }

    work->objWork.collisionObj = &work->collisionObject;
}

void GameObject__Destructor(Task *task)
{
    GameObjectTask *work = TaskGetWork(task, GameObjectTask);

    if (work->sndHandle != NULL)
    {
        ReleaseStageSfx(work->sndHandle);
        FreeSndHandle(work->sndHandle);
    }

    MapObject *mapObject = work->mapObject;
    if (mapObject != NULL && mapObject->x == MAPOBJECT_DESTROYED && mapObject->y == MAPOBJECT_DESTROYED)
    {
        GameObject__ReleaseTempObj(mapObject);
    }
    else
    {
        if ((work->flags & GAMEOBJECT_FLAG_ALLOW_RESPAWN) == 0 && mapObject != NULL)
            mapObject->x = work->mapObjectX;
    }

    StageTask_Destructor(task);
}

void GameObject__SetAnimation(GameObjectTask *work, u16 animID)
{
    work->colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->colliders[GAMEOBJECT_COLLIDER_SOLID].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    StageTask__SetAnimation(&work->objWork, animID);
}

GameObjectTask *GameObject__SpawnObject(s32 id, fx32 x, fx32 y, u16 flags, s8 left, s8 top, u8 width, u8 height, u8 param)
{
    GameObjectTask *work = NULL;

    s16 slot = GameObject__GetNextTempObjID();
    if (slot < GAMEOBJECT_TEMPLIST_SIZE)
    {
        tempObjectList[slot].x         = MAPOBJECT_DESTROYED;
        tempObjectList[slot].y         = MAPOBJECT_DESTROYED;
        tempObjectList[slot].id        = id;
        tempObjectList[slot].flags     = flags;
        tempObjectList[slot].left      = left;
        tempObjectList[slot].top       = top;
        tempObjectList[slot].width     = width;
        tempObjectList[slot].height    = height;
        tempObjectList[slot].param.u16 = 0;

        work = stageObjectSpawnList[id](&tempObjectList[slot], x, y, param);
        if (work == NULL)
            GameObject__ReleaseTempObj(&tempObjectList[slot]);
    }

    return work;
}

void GameObject__ProcessReceivedPackets_ItemBoxes(void)
{
    if (gmCheckVsBattleFlag())
    {
        ObjPacket__PrepareReceivedPackets();

        if (gPlayerList[PLAYER_CONTROL_P2] == NULL)
            return;

        while (TRUE)
        {
            ObjReceivePacket *packet         = (ObjReceivePacket *)ObjPacket__GetNextReceivedPacket(2, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
            GameObjectSendPacket *packetData = (GameObjectSendPacket *)packet->data;
            if (packet == NULL)
                return;

            MapObject *mapObject = (MapObject *)(packetData->id + (size_t)EventManager__GetObjectLayout());
            if (gmCheckFlag(GAME_FLAG_USE_WIFI))
            {
                if (mapObject->id == MAPOBJECT_48 || mapObject->id == MAPOBJECT_49 || mapObject->id == MAPOBJECT_256 || mapObject->id == MAPOBJECT_257)
                {
                    if (playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] != playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2])
                    {
                        continue;
                    }
                }
                else
                {
                    if (packet->header.param != playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2])
                    {
                        continue;
                    }
                }
            }

            mapObject->flags |= GAMEOBJECT_FLAG_HAS_PACKET_ACTION;
            if (mapObject->x != MAPOBJECT_DESTROYED || (mapObject->id == MAPOBJECT_48 || mapObject->id == MAPOBJECT_49))
            {
                switch (packetData->type)
                {
                    case GAMEOBJECT_PACKET_DESTROYED:
                        break;

                    case GAMEOBJECT_PACKET_SLOWDOWN:
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_ON);
                        Player__GiveSlowdownEffect(gPlayer);
                        continue;

                    case GAMEOBJECT_PACKET_CONFUSION:
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_ON);
                        Player__GiveConfusionEffect(gPlayer);
                        continue;

                    case GAMEOBJECT_PACKET_TENSION_SWAP:
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_ON);
                        Player__DepleteTension(gPlayer);
                        continue;

                    case GAMEOBJECT_PACKET_GRAB:
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ITEM_ON);
                        Player__ApplyWarpEfect(gPlayer);
                        continue;

                    default:
                        continue;
                }

                DestroyMapObject(mapObject);
            }
        }
    }
}

void GameObject__ProcessReceivedPackets_Enemies(void)
{
    if (gmCheckVsBattleFlag())
    {
        ObjPacket__PrepareReceivedPackets();

        if (gPlayerList[PLAYER_CONTROL_P2] == NULL)
            return;

        while (TRUE)
        {
            ObjReceivePacket *packet         = (ObjReceivePacket *)ObjPacket__GetNextReceivedPacket(2, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
            GameObjectSendPacket *packetData = (GameObjectSendPacket *)packet->data;
            if (packet == NULL)
                return;

            MapObject *mapObject = (MapObject *)(packetData->id + (size_t)EventManager__GetObjectLayout());
            if (gmCheckFlag(GAME_FLAG_USE_WIFI))
            {
                if (mapObject->id == MAPOBJECT_48 || mapObject->id == MAPOBJECT_49 || mapObject->id == MAPOBJECT_256 || mapObject->id == MAPOBJECT_257)
                {
                    if (playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] != playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2])
                    {
                        continue;
                    }
                }
                else
                {
                    if (packet->header.param != playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2])
                    {
                        continue;
                    }
                }
            }

            if (mapObject->x != MAPOBJECT_DESTROYED && packetData->type == GAMEOBJECT_PACKET_DESTROYED)
                DestroyMapObject(mapObject);
        }
    }
}

void GameObject__SendPacket(GameObjectTask *work, Player *player, GameObjectPacketType type)
{
    if (work->mapObject != NULL && work->mapObject->x == MAPOBJECT_DESTROYED && work->mapObject->y == MAPOBJECT_DESTROYED)
        return;

    if (!gmCheckVsBattleFlag() || !CheckIsPlayer1(player))
        return;

    GameObjectSendPacket *packet = RequestNextSendPacket();

    if (packet == NULL)
        return;

    packet->type = type;
    packet->id   = (size_t)work->mapObject - (size_t)EventManager__GetObjectLayout();

    ObjSendPacket *sendPacket = ObjPacket__QueueSendPacket(packet, GAMEPACKET_INTERACTABLE, 0, sizeof(GameObjectSendPacket));
    sendPacket->header.param  = playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1];
}

void GameObject__SpawnExplosion(GameObjectTask *work)
{
    s16 d;

    u32 moveFlag = STAGE_TASK_MOVE_FLAG_NONE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);

    if ((mapCamera.camera[0].flags & MAPSYS_CAMERA_FLAG_1000000) != 0 && mapCamera.camera[0].waterLevel < FX32_TO_WHOLE(work->objWork.position.y) - 64)
    {
        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(16.0) + FX32_FROM_WHOLE(mtMathRandRepeat(8)), -FX32_FROM_WHOLE(mtMathRandRepeat(8)), WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(3.0) - FX32_FROM_WHOLE(mtMathRandRepeat(8)), -FLOAT_TO_FX32(4.0) - FX32_FROM_WHOLE(mtMathRandRepeat(8)),
                                   WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, -FLOAT_TO_FX32(16.0) - FX32_FROM_WHOLE(mtMathRandRepeat(8)), -FX32_FROM_WHOLE(mtMathRandRepeat(8)), WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), WATEREXPLOSION_BOMB);
    }
    else
    {
        CreateEffectExplosion(&work->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_ENEMY);
    }

    u16 debrisType = mtMathRandRepeat(4);

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) != 0 || (work->flags & GAMEOBJECT_FLAG_NO_EXPLOSION_COLLISIONS) != 0)
        moveFlag = STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    for (d = 0; d < 2; d++)
    {
        EffectEnemyDebris *debris =
            CreateEffectEnemyDebris(&work->objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(24.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(2.0), ((debrisType + d) & 3) + 4);
        debris->objWork.moveFlag |= moveFlag;
    }
}

void GameObject__OnDestroyEnemy(GameObjectTask *work)
{
    // This function appears to be gutted & leftover from Sonic Rush.

    fx32 velY = FLOAT_TO_FX32(0.0);

    // Get zoneID to know what animal types to spawn (unused)
    u16 zoneID = GetCurrentZoneID();

    if ((work->flags & GAMEOBJECT_FLAG_NO_ANIMAL_SPAWN) == 0)
    {
        // Pick animal type (unused)
        mtMathRand();

        velY = FLOAT_TO_FX32(0.5);
        StageTask__ObjectSpdDirFall(NULL, &velY, work->objWork.fallDir);
    }
}

void GameObject__OnDefend_Enemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    GameObjectTask *enemy = (GameObjectTask *)rect2->parent;
    Player *player        = (Player *)rect1->parent;

    if (enemy == NULL)
        return;

    if (enemy->health == 0)
    {
        if ((enemy->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) == 0)
            enemy->flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;

        enemy->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        enemy->colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        enemy->colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        enemy->colliders[GAMEOBJECT_COLLIDER_SOLID].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        if (enemy->objWork.sequencePlayerPtr != NULL)
            StopStageSfx(enemy->objWork.sequencePlayerPtr);

        if (player != NULL)
        {
            if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
            {
                Player__GiveComboTension(player, PLAYER_TENSION_ENEMY);
                if (gmCheckMissionType(MISSION_TYPE_DEFEAT_ENEMIES) && enemy->mapObject->id < MAPOBJECT_276)
                    playerGameStatus.missionStatus.enemyDefeatCount++;
            }
            else
            {
                Player *parent = (Player *)player->objWork.parentObj;
                if (parent != NULL && (player = (Player *)player->objWork.parentObj, parent->objWork.objType == STAGE_OBJ_TYPE_PLAYER))
                {
                    Player__GiveComboTension(parent, PLAYER_TENSION_ENEMY);
                    GameObject__BoostImpactEnemy(enemy, player);

                    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
                    {
                        player->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                        player->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
                        enemy->objWork.hitstopTimer  = FLOAT_TO_FX32(4.0);
                        enemy->objWork.shakeTimer    = FLOAT_TO_FX32(4.0);
                    }

                    GameObject__SendPacket(enemy, player, GAMEOBJECT_PACKET_DESTROYED);

                    if (gmCheckMissionType(MISSION_TYPE_DEFEAT_ENEMIES) && enemy->mapObject->id < MAPOBJECT_276)
                        playerGameStatus.missionStatus.enemyDefeatCount++;

                    return;
                }
            }
        }

        GameObject__SpawnExplosion(enemy);
        GameObject__OnDestroyEnemy(enemy);
        QueueDestroyStageTask(&enemy->objWork);
        GameObject__SendPacket(enemy, player, GAMEOBJECT_PACKET_DESTROYED);
    }
    else
    {
        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1), ObjRect__HitCenterY(rect2, rect1));

        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1) + mtMathRandRange(-FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0)),
                                ObjRect__HitCenterY(rect2, rect1) + mtMathRandRange(-FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0)));

        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1) + mtMathRandRange(-FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0)),
                                ObjRect__HitCenterY(rect2, rect1) + mtMathRandRange(-FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(16.0)));

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);
        CreateEffectVitality(&enemy->objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(80.0), enemy->health);
        enemy->health--;
        enemy->mapObject->param.health++;
        enemy->blinkTimer                                  = SECONDS_TO_FRAMES(1.0);
        enemy->colliders[GAMEOBJECT_COLLIDER_ATK].hitPower = OBS_RECT_HITPOWER_VULNERABLE;
        GameObject__SendPacket(enemy, player, GAMEOBJECT_PACKET_HURT);

        if (player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
        {
            Player__Action_AttackRecoil(player);
            return;
        }
    }

    if (player != NULL)
    {
        if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
            Player__Action_DestroyAttackRecoil(player);
    }
}

void GameObject__In_Default(void)
{
    GameObjectTask *work = TaskGetWorkCurrent(GameObjectTask);

    if (work->parent != NULL && IsStageTaskDestroyed(work->parent))
        work->parent = NULL;

    GameObject__ProcessPacketActions(work);

    if (ObjectPauseCheck(work->objWork.flag) == FALSE && work->blinkTimer != 0)
    {
        work->blinkTimer--;

        if ((work->blinkTimer & 2) != 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        else
            work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

        work->colliders[GAMEOBJECT_COLLIDER_WEAK].defPower = OBS_RECT_DEFPOWER_INVINCIBLE;
        work->colliders[GAMEOBJECT_COLLIDER_ATK].hitPower = OBS_RECT_HITPOWER_VULNERABLE;

        if (work->blinkTimer == 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
            work->colliders[GAMEOBJECT_COLLIDER_WEAK].defPower = OBS_RECT_DEFPOWER_DEFAULT;
            work->colliders[GAMEOBJECT_COLLIDER_ATK].hitPower = OBS_RECT_HITPOWER_DEFAULT;
        }
    }
}

void GameObject__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, GameObjectTask *work)
{
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        if (block->id <= GAMEOBJECT_COLLIDER_COUNT - 1)
        {
            if (block->hitbox.left == block->hitbox.right && block->hitbox.top == block->hitbox.bottom)
            {
                work->colliders[block->id].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
            }
            else
            {
                work->colliders[block->id].parent = &work->objWork;
                ObjRect__SetBox(&work->colliders[block->id], block->hitbox.left, block->hitbox.top, block->hitbox.right, block->hitbox.bottom);
            }
        }
    }
}

void GameObject__Collide_Default(void)
{
    GameObjectTask *work = TaskGetWorkCurrent(GameObjectTask);

    if (!IsStageTaskDestroyedAny(&work->objWork))
    {
        if (work->colliders[GAMEOBJECT_COLLIDER_WEAK].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[GAMEOBJECT_COLLIDER_WEAK]);

        if (work->colliders[GAMEOBJECT_COLLIDER_ATK].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[GAMEOBJECT_COLLIDER_ATK]);

        if (work->colliders[GAMEOBJECT_COLLIDER_SOLID].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[GAMEOBJECT_COLLIDER_SOLID]);

        if (work->collisionObject.work.parent != NULL)
        {
            if (!StageTask__ViewCheck_Default(&work->objWork))
                ObjCollisionObjectRegist(&work->collisionObject.work);
        }
    }
}

void GameObject__BoostImpactEnemy(GameObjectTask *work, Player *player)
{
    switch (work->mapObject->id)
    {
        case MAPOBJECT_11:
        case MAPOBJECT_327:
            break;

        case MAPOBJECT_340:
        case MAPOBJECT_342:
        case MAPOBJECT_344:
        case MAPOBJECT_345:
        case MAPOBJECT_346:
        case MAPOBJECT_347:
            break;

        default:
            GameObject__SetAnimation(work, 0);
            break;
    }

    work->objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    SetTaskState(&work->objWork, GameObject__State_BoostImpactSpin);
    work->objWork.groundVel = 0;
    work->objWork.userTimer = 32;
    work->objWork.userWork  = 0;

    fx32 force = 0x37F0 - (mtMathRand() & 0x1FE0);

    work->objWork.velocity.x = player->objWork.position.x - player->objWork.prevPosition.x;
    work->objWork.velocity.y = player->objWork.position.y - player->objWork.prevPosition.y;

    u16 angle = FX_Atan2Idx(player->objWork.move.y, player->objWork.move.x) - FLOAT_DEG_TO_IDX(90.0);
    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        angle += FLOAT_DEG_TO_IDX(180.0);

    work->objWork.velocity.x += MultiplyFX(force, CosFX((s32)angle));
    work->objWork.velocity.y += MultiplyFX(force, SinFX((s32)angle));

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);
}

void GameObject__State_BoostImpactSpin(GameObjectTask *work)
{
    work->objWork.dir.z += FLOAT_DEG_TO_IDX(22.5);

    if (work->objWork.userTimer == 0)
    {
        GameObject__SpawnExplosion(work);
        GameObject__OnDestroyEnemy(work);
        DestroyStageTask(&work->objWork);
    }

    work->objWork.userTimer--;
}

s16 GameObject__GetNextTempObjID(void)
{
    s16 slot = 0;

    for (slot = 0; slot < GAMEOBJECT_TEMPLIST_SIZE; slot++)
    {
        if ((usedTempObjects[slot >> 5] & (1 << (slot & 0x1F))) == 0)
        {
            usedTempObjects[slot >> 5] |= (1 << (slot & 0x1F));
            return slot;
        }
    }

    return slot;
}

void GameObject__ReleaseTempObj(MapObject *obj)
{
    u32 id = ((size_t)obj - (size_t)tempObjectList) / sizeof(MapObject);

    usedTempObjects[id >> 5] &= ~(1 << (id & 0x1F));
}

void GameObject__ProcessPacketActions(GameObjectTask *work)
{
    if ((work->mapObject->flags & GAMEOBJECT_FLAG_HAS_PACKET_ACTION) != 0)
    {
        work->mapObject->flags &= ~GAMEOBJECT_FLAG_HAS_PACKET_ACTION;

        if (gmCheckVsBattleFlag())
        {
            ObjPacket__PrepareReceivedPackets();

            for (u16 p = 0; p < PLAYER_COUNT; p++)
            {
                if (p != gPlayer->aidIndex)
                {
                    while (TRUE)
                    {
                        GameObjectSendPacket *packet = (GameObjectSendPacket *)ObjPacket__GetNextReceivedPacketData(2, p);
                        if (packet == NULL)
                            break;

                        MapObject *mapObject = (MapObject *)(packet->id + (size_t)EventManager__GetObjectLayout());
                        if (work->mapObject == mapObject)
                        {
                            switch (packet->type)
                            {
                                case GAMEOBJECT_PACKET_HURT:
                                case GAMEOBJECT_PACKET_DESTROYED:
                                    GameObject__OnDefend_Enemy(gPlayerList[PLAYER_CONTROL_P2]->colliders, &work->colliders[GAMEOBJECT_COLLIDER_WEAK]);
                                    break;

                                case GAMEOBJECT_PACKET_OBJ_COLLISION_1:
                                    work->colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend(gPlayerList[PLAYER_CONTROL_P2]->colliders, &work->colliders[GAMEOBJECT_COLLIDER_WEAK]);
                                    break;

                                case GAMEOBJECT_PACKET_OBJ_COLLISION_2:
                                    work->colliders[GAMEOBJECT_COLLIDER_ATK].onDefend(gPlayerList[PLAYER_CONTROL_P2]->colliders, &work->colliders[GAMEOBJECT_COLLIDER_ATK]);
                                    break;

                                case GAMEOBJECT_PACKET_OBJ_COLLISION_3:
                                    work->colliders[GAMEOBJECT_COLLIDER_SOLID].onDefend(gPlayerList[PLAYER_CONTROL_P2]->colliders, &work->colliders[GAMEOBJECT_COLLIDER_SOLID]);
                                    break;
                            }

                            if (gmCheckRingBattle())
                            {
                                if (packet->type >= GAMEOBJECT_PACKET_SLOWDOWN && packet->type <= GAMEOBJECT_PACKET_GRAB)
                                    work->colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend(&gPlayerList[PLAYER_CONTROL_P2]->colliders[0], &work->colliders[GAMEOBJECT_COLLIDER_WEAK]);
                            }
                        }
                    }
                }
            }
        }
    }
}

BadnikBreakResult GameObject__BadnikBreak(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2, GameObjectPacketType type)
{
    GameObjectTask *badnik = (GameObjectTask *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (badnik == NULL)
        return BADNIKBREAKRESULT_NONE;

    if (player != NULL)
    {
        if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
        {
            Player__GiveComboTension(player, PLAYER_TENSION_ENEMY);
            GameObject__SendPacket(badnik, player, type);
            Player__Action_DestroyAttackRecoil(player);
            return BADNIKBREAKRESULT_DESTROYED_PLAYER;
        }

        player = (Player *)player->objWork.parentObj;
        if (player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
        {
            if ((badnik->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) == 0)
                badnik->flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;

            badnik->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            badnik->colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            badnik->colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            badnik->colliders[GAMEOBJECT_COLLIDER_SOLID].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            Player__GiveComboTension(player, PLAYER_TENSION_ENEMY);
            GameObject__BoostImpactEnemy(badnik, player);

            if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
            {
                player->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                player->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);

                badnik->objWork.hitstopTimer = FLOAT_TO_FX32(4.0);
                badnik->objWork.shakeTimer   = FLOAT_TO_FX32(4.0);
            }

            GameObject__SendPacket(badnik, player, GAMEOBJECT_PACKET_DESTROYED);

            return BADNIKBREAKRESULT_DESTROYED_SUPERBOOST;
        }
    }

    return BADNIKBREAKRESULT_NONE;
}

/* "Necessary" in order to match the bloat LSL16/LSR16 pairs (which probably stem from implicit conversions in
    the source code across inlined functions (or macros) but I couldn't find the right combination) */
#define FX_SINCOSCAST (s32)(u16)
//! Allows passing two arguments at once to functions taking sin and cos parameters next to each other.
#define FX_SIN_AND_COS(angle) SinFX(FX_SINCOSCAST(angle)), CosFX(FX_SINCOSCAST(angle))

void GameObject__TransformWorldToScreen(VecFx32 *inputPos, VecFx32 *outputPos, MtxFx44 *outProjMtx, BOOL setFrustum)
{
    InitStageLightConfig();

    fx32 camX;
    fx32 camY;
    if (g_obj.cameraFunc != NULL)
    {
        g_obj.cameraFunc(&camX, &camY);
    }
    else
    {
        camX = g_obj.camera[GRAPHICS_ENGINE_A].x;
        camY = g_obj.camera[GRAPHICS_ENGINE_A].y;
    }

    outputPos->x = inputPos->x - camX;
    outputPos->y = -(inputPos->y - camY);
    outputPos->z = inputPos->z;
    outputPos->x += FX32_FROM_WHOLE(g_obj.offset.x);
    outputPos->y += FX32_FROM_WHOLE(g_obj.offset.y);

    if (g_obj.scale.x != FLOAT_TO_FX32(1.0))
        outputPos->x = FX32_FROM_WHOLE(HW_LCD_CENTER_X) + MultiplyFX(outputPos->x - FX32_FROM_WHOLE(HW_LCD_CENTER_X), g_obj.scale.x);

    if (g_obj.scale.y != FLOAT_TO_FX32(1.0))
        outputPos->y = -(FX32_FROM_WHOLE(HW_LCD_CENTER_Y) + MultiplyFX(-FX32_FROM_WHOLE(HW_LCD_CENTER_Y) - outputPos->y, g_obj.scale.y));

    if (setFrustum)
    {
        CameraConfig const *const ptrConfig = &g_obj.cameraConfig->config;
        const u32 halfFOV                   = ptrConfig->projFOV;
        const u32 nearPlaneDistance         = ptrConfig->projNear;
        const fx32 tangentHalfFOV           = FX_Div(FX_SIN_AND_COS(halfFOV));
        const fx32 frustumHalfHeight        = MultiplyFX(tangentHalfFOV, nearPlaneDistance);
        const fx32 frustumHalfWidth         = MultiplyFX(frustumHalfHeight, ptrConfig->aspectRatio);
        const fx32 nearByZ                  = FX_Div(ptrConfig->projNear, g_obj.cameraConfig->lookAtTo.z);
        const fx32 frustumCenterY           = MultiplyFX(nearByZ, (FX32_FROM_WHOLE(HW_LCD_CENTER_Y) + outputPos->y));
        const fx32 frustumCenterX           = MultiplyFX(nearByZ, (FX32_FROM_WHOLE(HW_LCD_CENTER_X) - outputPos->x));
        outputPos->x                        = FX32_FROM_WHOLE(HW_LCD_CENTER_X);
        outputPos->y                        = -FX32_FROM_WHOLE(HW_LCD_CENTER_Y);

        (*outProjMtx) = *NNS_G3dGlbGetProjectionMtx();

        const fx32 top    = -frustumCenterY + frustumHalfHeight;
        const fx32 bottom = -(frustumHalfHeight + frustumCenterY);
        const fx32 left   = frustumCenterX - frustumHalfWidth;
        const fx32 right  = frustumHalfWidth + frustumCenterX;
        const fx32 near   = ptrConfig->projNear;
        const fx32 far    = ptrConfig->projFar;
        NNS_G3dGlbFrustum(top, bottom, left, right, near, far);
    }
}
