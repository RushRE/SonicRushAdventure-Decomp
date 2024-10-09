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

u32 GameObject__TempObjBitfield[(GAMEOBJECT_TEMPLIST_SIZE + (32 - 1)) / 32];
MapObject GameObject__TempObjList[GAMEOBJECT_TEMPLIST_SIZE];

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

    u16 atkFlags[3] = { 0, 2, 2 };
    u16 defFlags[3] = { 1, 0, 0 };

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

    for (s32 i = 0; i < 3; i++)
    {
        ObjRect__SetGroupFlags(&work->colliders[i], 2, 1);
        ObjRect__SetAttackStat(&work->colliders[i], atkFlags[i], 0x40);
        ObjRect__SetDefenceStat(&work->colliders[i], defFlags[i], 0x3F);
        work->colliders[i].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }

    ObjRect__SetOnDefend(&work->colliders[0], GameObject__OnDefend_Enemy);

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
    work->colliders[0].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->colliders[1].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
    work->colliders[2].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;

    StageTask__SetAnimation(&work->objWork, animID);
}

GameObjectTask *GameObject__SpawnObject(s32 id, fx32 x, fx32 y, u16 flags, s8 left, s8 top, u8 width, u8 height, u8 param)
{
    GameObjectTask *work = NULL;

    s16 slot = GameObject__GetNextTempObjID();
    if (slot < GAMEOBJECT_TEMPLIST_SIZE)
    {
        GameObject__TempObjList[slot].x         = MAPOBJECT_DESTROYED;
        GameObject__TempObjList[slot].y         = MAPOBJECT_DESTROYED;
        GameObject__TempObjList[slot].id        = id;
        GameObject__TempObjList[slot].flags     = flags;
        GameObject__TempObjList[slot].left      = left;
        GameObject__TempObjList[slot].top       = top;
        GameObject__TempObjList[slot].width     = width;
        GameObject__TempObjList[slot].height    = height;
        GameObject__TempObjList[slot].param.u16 = 0;

        work = stageObjectSpawnList[id](&GameObject__TempObjList[slot], x, y, param);
        if (work == NULL)
            GameObject__ReleaseTempObj(&GameObject__TempObjList[slot]);
    }

    return work;
}

NONMATCH_FUNC void GameObject__ProcessRecievedPackets_ItemBox(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	ldr r0, =gameState
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl ObjPacket__Func_2074DB4
	ldr r0, =gPlayerList
	ldr r0, [r0, #4]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r8, #0x35
	ldr r5, =playerGameStatus
	ldr r4, =gPlayer
	mvn r7, #0
	mov r6, r8
	mov r10, r8
	mov r11, r8
_0202726C:
	ldr r1, =gPlayerList
	mov r0, #2
	ldr r1, [r1, #4]
	ldrb r1, [r1, #0x5d2]
	bl ObjPacket__GetRecievedPacket
	movs r9, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl EventManager__GetObjectLayout
	ldr r1, =gameState
	ldrh r2, [r9, #6]
	ldr r1, [r1, #0x10]
	add r0, r2, r0
	tst r1, #0x400
	beq _020272F0
	ldrh r1, [r0, #2]
	cmp r1, #0x30
	cmpne r1, #0x31
	beq _020272CC
	add r1, r1, #0xff00
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	bhi _020272E0
_020272CC:
	ldrh r2, [r5, #0x8e]
	ldrh r1, [r5, #0x8a]
	cmp r2, r1
	bne _0202726C
	b _020272F0
_020272E0:
	ldrh r2, [r9, #2]
	ldrh r1, [r5, #0x8a]
	cmp r2, r1
	bne _0202726C
_020272F0:
	ldrh r1, [r0, #4]
	orr r1, r1, #0x2000
	strh r1, [r0, #4]
	ldrb r1, [r0, #0]
	cmp r1, #0xff
	bne _02027324
	ldrh r1, [r0, #2]
	add r1, r1, #0xfd0
	add r1, r1, #0xf000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	bhi _0202726C
_02027324:
	ldrb r1, [r9, #4]
	cmp r1, #0xa
	addls pc, pc, r1, lsl #2
	b _0202726C
_02027334: // jump table
	b _0202726C // case 0
	b _0202726C // case 1
	b _020273F0 // case 2
	b _0202726C // case 3
	b _0202726C // case 4
	b _0202726C // case 5
	b _0202726C // case 6
	b _02027360 // case 7
	b _02027384 // case 8
	b _020273A8 // case 9
	b _020273CC // case 10
_02027360:
	mov r0, #0
	stmia sp, {r0, r8}
	mov r1, r7
	mov r2, r7
	mov r3, r7
	bl PlaySfxEx
	ldr r0, [r4, #0]
	bl Player__GiveSlowdownEffect
	b _0202726C
_02027384:
	mov r0, #0
	stmia sp, {r0, r6}
	mov r1, r7
	mov r2, r7
	mov r3, r7
	bl PlaySfxEx
	ldr r0, [r4, #0]
	bl Player__GiveConfusionEffect
	b _0202726C
_020273A8:
	mov r0, #0
	stmia sp, {r0, r10}
	mov r1, r7
	mov r2, r7
	mov r3, r7
	bl PlaySfxEx
	ldr r0, [r4, #0]
	bl Player__DepleteTension
	b _0202726C
_020273CC:
	mov r0, #0
	stmia sp, {r0, r11}
	mov r1, r7
	mov r2, r7
	mov r3, r7
	bl PlaySfxEx
	ldr r0, [r4, #0]
	bl Player__ApplyWarpEfect
	b _0202726C
_020273F0:
	mov r1, #0xff
	strb r1, [r0]
	b _0202726C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void GameObject__ProcessRecievedPackets_Unknown(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r0, =gameState
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bl ObjPacket__Func_2074DB4
	ldr r6, =gPlayerList
	ldr r0, [r6, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r5, =gameState
	ldr r4, =playerGameStatus
	mov r7, #0xff
	mov r9, #2
_0202744C:
	ldr r1, [r6, #4]
	mov r0, r9
	ldrb r1, [r1, #0x5d2]
	bl ObjPacket__GetRecievedPacket
	movs r8, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bl EventManager__GetObjectLayout
	ldrh r2, [r8, #6]
	ldr r1, [r5, #0x10]
	tst r1, #0x400
	add r0, r2, r0
	beq _020274C4
	ldrh r1, [r0, #2]
	cmp r1, #0x30
	cmpne r1, #0x31
	beq _020274A0
	add r1, r1, #0xff00
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	bhi _020274B4
_020274A0:
	ldrh r2, [r4, #0x8e]
	ldrh r1, [r4, #0x8a]
	cmp r2, r1
	bne _0202744C
	b _020274C4
_020274B4:
	ldrh r2, [r8, #2]
	ldrh r1, [r4, #0x8a]
	cmp r2, r1
	bne _0202744C
_020274C4:
	ldrb r1, [r0, #0]
	cmp r1, #0xff
	beq _0202744C
	ldrb r1, [r8, #4]
	cmp r1, #2
	streqb r7, [r0]
	b _0202744C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
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

    ObjSendPacket *sendPacket = ObjPacket__SendPacket(packet, GAMEPACKET_INTERACTABLE, 0, sizeof(GameObjectSendPacket));
    sendPacket->header.param  = playerGameStatus.field_88[0];
}

NONMATCH_FUNC void GameObject__SpawnExplosion(GameObjectTask *work)
{
	// https://decomp.me/scratch/tNoAG -> 82.90%
#ifdef NON_MATCHING
    u32 moveFlag = STAGE_TASK_MOVE_FLAG_NONE;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);

    if ((mapCamera.camera[0].flags & MAPSYS_CAMERA_FLAG_1000000) != 0 && mapCamera.camera[0].waterLevel < FX32_TO_WHOLE(work->objWork.position.y) - 64)
    {
        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(16.0) + (FX32_FROM_WHOLE(mtMathRand() / 8)), -(FX32_FROM_WHOLE(mtMathRand() / 8)),
                                   WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(3.0) - (FX32_FROM_WHOLE(mtMathRand() / 8)), -FLOAT_TO_FX32(5.0) - (FX32_FROM_WHOLE(mtMathRand() / 8)),
                                   WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, -FLOAT_TO_FX32(16.0) - (FX32_FROM_WHOLE(mtMathRand() / 8)), -(FX32_FROM_WHOLE(mtMathRand() / 8)),
                                   WATEREXPLOSION_BUBBLES);

        CreateEffectWaterExplosion(&work->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), WATEREXPLOSION_BOMB);
    }
    else
    {
        CreateEffectExplosion(&work->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_ENEMY);
    }

    u32 debrisType = mtMathRand() & 3;

    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) != 0 || (work->flags & GAMEOBJECT_FLAG_40000) != 0)
        moveFlag = STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    for (s16 d = 0; d < 2; d++)
    {
        EffectEnemyDebris *debris =
            CreateEffectEnemyDebris(&work->objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(24.0), FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(2.0), (debrisType & 3) + 4);
        debris->objWork.moveFlag |= moveFlag;

        debrisType++;
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r6, #0x28
	sub r1, r6, #0x29
	mov r4, #0
	mov r5, r0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	stmia sp, {r4, r6}
	bl PlaySfxEx
	ldr r0, =mapCamera
	ldr r1, [r0, #0]
	tst r1, #0x1000000
	beq _020276FC
	ldr r1, [r5, #0x48]
	ldrh r2, [r0, #0x6e]
	mov r0, r1, asr #0xc
	sub r0, r0, #0x40
	cmp r2, r0
	bge _020276FC
	ldr r7, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r3, [r7, #0]
	ldr r2, =0x3C6EF35F
	mov r0, r5
	mla r8, r3, r1, r2
	mla r6, r8, r1, r2
	mov r1, r8, lsr #0x10
	mov r2, r6, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, r2, lsr #0x10
	mov r2, r1, lsl #0x1d
	mov r1, r3, lsl #0x1d
	mov r3, r2, lsr #0x11
	mov r2, r1, lsr #0x11
	add r1, r3, #0x10000
	rsb r2, r2, #0
	mov r3, #1
	str r6, [r7]
	bl CreateEffectWaterExplosion
	ldr r0, =0x00196225
	ldr r3, [r7, #0]
	ldr r1, =0x3C6EF35F
	mov r2, #0x4000
	mla r8, r3, r0, r1
	mla r6, r8, r0, r1
	mov r0, r6, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r3, r8, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r1, lsl #0x1d
	mov r1, r0, lsr #0x11
	mov r3, r3, lsl #0x1d
	rsb r2, r2, #0
	sub r2, r2, r3, lsr #17
	mov r0, r5
	rsb r1, r1, #0x3000
	mov r3, #1
	str r6, [r7]
	bl CreateEffectWaterExplosion
	mov r6, r7
	mov r3, #0x10000
	ldr r7, [r6, #0]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	rsb r3, r3, #0
	mla r8, r7, r1, r2
	mla r2, r8, r1, r2
	mov r1, r8, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r7, r1, lsr #0x10
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r6]
	mov r6, r1, lsl #0x1d
	mov r1, r7, lsl #0x1d
	mov r1, r1, lsr #0x11
	rsb r2, r1, #0
	sub r1, r3, r6, lsr #17
	mov r0, r5
	mov r3, #1
	bl CreateEffectWaterExplosion
	mov r1, r4
	mov r0, r5
	mov r2, r1
	mov r3, r1
	bl CreateEffectWaterExplosion
	b _02027710
_020276FC:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	mov r3, r1
	bl CreateEffectExplosion
_02027710:
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, [r5, #0x1c]
	and r10, r1, #3
	tst r0, #0x1000
	bne _02027750
	ldr r0, [r5, #0x354]
	tst r0, #0x40000
	beq _02027754
_02027750:
	mov r4, #0x100
_02027754:
	mov r8, #0x2000
	mov r9, #0
	rsb r8, r8, #0
	sub r6, r8, #0x16000
	mov r7, r9
_02027768:
	and r0, r10, #3
	str r8, [sp]
	add ip, r0, #4
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r7
	str ip, [sp, #4]
	bl CreateEffectEnemyDebris
	add r1, r9, #1
	ldr r2, [r0, #0x1c]
	mov r1, r1, lsl #0x10
	orr r2, r2, r4
	mov r9, r1, asr #0x10
	str r2, [r0, #0x1c]
	cmp r9, #2
	add r10, r10, #1
	blt _02027768
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void GameObject__OnDestroyEnemy(GameObjectTask *work)
{
    fx32 velY = 0;

    // ???
    GetCurrentZoneID();

    if ((work->flags & GAMEOBJECT_FLAG_20000) == 0)
    {
        // ???
        mtMathRand();

        velY = FLOAT_TO_FX32(0.5);
        StageTask__ObjectSpdDirFall(NULL, &velY, work->objWork.fallDir);
    }
}

NONMATCH_FUNC void GameObject__OnDefend_Enemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
	// https://decomp.me/scratch/aI5ZN -> 91.36%
#ifdef NON_MATCHING
    GameObjectTask *enemy = (GameObjectTask *)rect2->parent;
    Player *player        = (Player *)rect1->parent;

    if (enemy == NULL)
        return;

    if (enemy->health == 0)
    {
        if ((enemy->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS) == 0)
            enemy->flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;

        enemy->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        enemy->colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        enemy->colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
        enemy->colliders[2].flag |= OBS_RECT_WORK_FLAG_800;

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
        enemy->objWork.flag |= 8;
        GameObject__SendPacket(enemy, player, GAMEOBJECT_PACKET_DESTROYED);
    }
    else
    {
        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1), ObjRect__HitCenterY(rect2, rect1));

        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1) - (mtMathRand() / 2), ObjRect__HitCenterY(rect2, rect1) - (mtMathRand() / 2));

        CreateEffectBattleBurst(ObjRect__HitCenterX(rect2, rect1) - (mtMathRand() / 2), ObjRect__HitCenterY(rect2, rect1) - (mtMathRand() / 2));

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);
        CreateEffectVitality(&enemy->objWork, 0, -FLOAT_TO_FX32(80.0), enemy->health);
        enemy->health--;
        enemy->mapObject->param.u8[1]++;
        enemy->blinkTimer            = 60;
        enemy->colliders[1].hitPower = 0;
        GameObject__SendPacket(enemy, player, GAMEOBJECT_PACKET_1);

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
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r7, r1
	ldr r5, [r7, #0x1c]
	mov r8, r0
	cmp r5, #0
	ldr r6, [r8, #0x1c]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrb r0, [r5, #0x345]
	cmp r0, #0
	bne _020279F0
	ldr r0, [r5, #0x1c]
	tst r0, #0x1000
	ldreq r0, [r5, #0x354]
	orreq r0, r0, #0x10000
	streq r0, [r5, #0x354]
	ldr r0, [r5, #0x18]
	orr r0, r0, #2
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x230]
	orr r0, r0, #0x800
	str r0, [r5, #0x230]
	ldr r0, [r5, #0x270]
	orr r0, r0, #0x800
	str r0, [r5, #0x270]
	ldr r0, [r5, #0x2b0]
	orr r0, r0, #0x800
	str r0, [r5, #0x2b0]
	ldr r0, [r5, #0x138]
	cmp r0, #0
	beq _020278BC
	mov r1, #0
	bl NNS_SndPlayerStopSeq
_020278BC:
	cmp r6, #0
	beq _020279C0
	ldrh r0, [r6, #0]
	cmp r0, #1
	bne _02027918
	mov r0, r6
	mov r1, #0x190
	bl Player__GiveComboTension
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xc
	bne _020279C0
	ldr r0, [r5, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x114
	bhs _020279C0
	ldr r0, =playerGameStatus
	ldrsh r1, [r0, #0xc8]
	add r1, r1, #1
	strh r1, [r0, #0xc8]
	b _020279C0
_02027918:
	ldr r0, [r6, #0x11c]
	cmp r0, #0
	beq _020279C0
	ldrh r1, [r0, #0]
	mov r6, r0
	cmp r1, #1
	bne _020279C0
	mov r1, #0x190
	bl Player__GiveComboTension
	mov r0, r5
	mov r1, r6
	bl GameObject__BoostImpactEnemy
	ldr r0, [r6, #0x5d8]
	tst r0, #0x80
	beq _02027968
	mov r0, #0x4000
	str r0, [r6, #8]
	str r0, [r6, #4]
	str r0, [r5, #8]
	str r0, [r5, #4]
_02027968:
	mov r0, r5
	mov r1, r6
	mov r2, #2
	bl GameObject__SendPacket
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xc
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r5, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x114
	addhs sp, sp, #8
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, =playerGameStatus
	add sp, sp, #8
	ldrsh r1, [r0, #0xc8]
	add r1, r1, #1
	strh r1, [r0, #0xc8]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020279C0:
	mov r0, r5
	bl GameObject__SpawnExplosion
	mov r0, r5
	bl GameObject__OnDestroyEnemy
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r3, r1, #8
	mov r1, r6
	mov r2, #2
	str r3, [r5, #0x18]
	bl GameObject__SendPacket
	b _02027B8C
_020279F0:
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r4, r0
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterY
	mov r1, r0
	mov r0, r4
	bl CreateEffectBattleBurst
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r4, [r3, #0]
	ldr r2, =0x3C6EF35F
	mov r0, r7
	mla r9, r4, r1, r2
	mla r1, r9, r1, r2
	str r1, [r3]
	mov r2, r9, lsr #0x10
	mov r9, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r10, r1, lsl #0x10
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r4, r0
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterY
	mov r1, r0
	ldr r2, =0x0001FFFE
	and r0, r2, r10, lsr #16
	rsb r0, r0, r2, lsr #1
	add r0, r4, r0
	and r3, r2, r9, lsr #16
	rsb r2, r3, r2, lsr #1
	add r1, r1, r2
	bl CreateEffectBattleBurst
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r4, [r3, #0]
	ldr r2, =0x3C6EF35F
	mov r0, r7
	mla r9, r4, r1, r2
	mla r1, r9, r1, r2
	str r1, [r3]
	mov r2, r9, lsr #0x10
	mov r9, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r10, r1, lsl #0x10
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r1, r8
	mov r4, r0
	mov r0, r7
	bl ObjRect__HitCenterY
	mov r3, r0
	ldr r1, =0x0001FFFE
	and r0, r1, r10, lsr #16
	rsb r0, r0, r1, lsr #1
	add r0, r4, r0
	and r2, r1, r9, lsr #16
	rsb r1, r2, r1, lsr #1
	add r1, r3, r1
	bl CreateEffectBattleBurst
	mov r0, #0
	str r0, [sp]
	mov r1, #0x28
	str r1, [sp, #4]
	sub r1, r1, #0x29
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	mov r1, #0
	sub r2, r1, #0x50000
	ldrb r3, [r5, #0x345]
	bl CreateEffectVitality
	ldrb r0, [r5, #0x345]
	add r2, r5, #0x300
	mov r4, #0x3c
	sub r0, r0, #1
	strb r0, [r5, #0x345]
	ldr r8, [r5, #0x340]
	mov r0, r5
	ldrb r7, [r8, #0xb]
	mov r1, r6
	add r3, r5, #0x200
	add r5, r7, #1
	strb r5, [r8, #0xb]
	strh r4, [r2, #0x50]
	mov r4, #0
	mov r2, #1
	strh r4, [r3, #0x84]
	bl GameObject__SendPacket
	cmp r6, #0
	beq _02027B8C
	ldrh r0, [r6, #0]
	cmp r0, #1
	bne _02027B8C
	mov r0, r6
	bl Player__Action_AttackRecoil
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02027B8C:
	cmp r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrh r0, [r6, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r6
	bl Player__Action_DestroyAttackRecoil
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void GameObject__In_Default(void)
{
    GameObjectTask *work = TaskGetWorkCurrent(GameObjectTask);

    if (work->parent != NULL && (work->parent->flag & STAGE_TASK_FLAG_DESTROYED) != 0)
        work->parent = NULL;

    GameObject__ProcessRecievedPackets(work);

    if (!ObjectPauseCheck(work->objWork.flag) && work->blinkTimer != 0)
    {
        work->blinkTimer--;

        if ((work->blinkTimer & 2) != 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
        else
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;

        work->colliders[0].defPower = 0xFF;
        work->colliders[1].hitPower = 0;

        if (work->blinkTimer == 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            work->colliders[0].defPower = 0x3F;
            work->colliders[1].hitPower = 0x40;
        }
    }
}

void GameObject__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, GameObjectTask *work)
{
    if (block->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        if (block->id <= 2)
        {
            if (block->hitbox.left == block->hitbox.right && block->hitbox.top == block->hitbox.bottom)
            {
                work->colliders[block->id].flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
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

    if ((work->objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) == 0)
    {
        if (work->colliders[0].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[0]);

        if (work->colliders[1].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[1]);

        if (work->colliders[2].parent != NULL)
            StageTask__HandleCollider(&work->objWork, &work->colliders[2]);

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
        if ((GameObject__TempObjBitfield[slot >> 5] & (1 << (slot & 0x1F))) == 0)
        {
            GameObject__TempObjBitfield[slot >> 5] |= (1 << (slot & 0x1F));
            return slot;
        }
    }

    return slot;
}

void GameObject__ReleaseTempObj(MapObject *obj)
{
    u32 id = ((size_t)obj - (size_t)GameObject__TempObjList) / sizeof(MapObject);

    GameObject__TempObjBitfield[id >> 5] &= ~(1 << (id & 0x1F));
}

NONMATCH_FUNC void GameObject__ProcessRecievedPackets(GameObjectTask *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, r0
	ldr r2, [r7, #0x340]
	ldrh r0, [r2, #4]
	tst r0, #0x2000
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bic r1, r0, #0x2000
	ldr r0, =gameState
	strh r1, [r2, #4]
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bl ObjPacket__Func_2074DB4
	mov r6, #0
_02028068:
	ldr r0, =gPlayer
	ldr r0, [r0, #0]
	ldrb r0, [r0, #0x5d2]
	cmp r6, r0
	beq _02028174
	ldr r9, =gPlayerList
	ldr r8, =gameState
	mov r4, #2
_02028088:
	mov r0, r4
	mov r1, r6
	bl ObjPacket__GetRecievedPacketData
	movs r5, r0
	beq _02028174
	bl EventManager__GetObjectLayout
	ldrh r2, [r5, #2]
	ldr r1, [r7, #0x340]
	add r0, r2, r0
	cmp r1, r0
	bne _02028088
	ldrb r0, [r5, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02028134
_020280C4: // jump table
	b _02028134 // case 0
	b _020280DC // case 1
	b _020280DC // case 2
	b _020280F0 // case 3
	b _02028108 // case 4
	b _02028120 // case 5
_020280DC:
	ldr r0, [r9, #4]
	add r1, r7, #0x218
	add r0, r0, #0x510
	bl GameObject__OnDefend_Enemy
	b _02028134
_020280F0:
	ldr r0, [r9, #4]
	ldr r2, [r7, #0x23c]
	add r0, r0, #0x510
	add r1, r7, #0x218
	blx r2
	b _02028134
_02028108:
	ldr r0, [r9, #4]
	ldr r2, [r7, #0x27c]
	add r0, r0, #0x510
	add r1, r7, #0x258
	blx r2
	b _02028134
_02028120:
	ldr r0, [r9, #4]
	ldr r2, [r7, #0x2bc]
	add r0, r0, #0x510
	add r1, r7, #0x298
	blx r2
_02028134:
	ldr r0, [r8, #0x14]
	cmp r0, #1
	ldreq r0, [r8, #0x20]
	cmpeq r0, #1
	bne _02028088
	ldrb r0, [r5, #0]
	cmp r0, #7
	blo _02028088
	cmp r0, #0xa
	bhi _02028088
	ldr r0, [r9, #4]
	ldr r2, [r7, #0x23c]
	add r0, r0, #0x510
	add r1, r7, #0x218
	blx r2
	b _02028088
_02028174:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #2
	blo _02028068
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
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
            badnik->colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
            badnik->colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
            badnik->colliders[2].flag |= OBS_RECT_WORK_FLAG_800;

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

NONMATCH_FUNC void GameObject__Func_20282A8(VecFx32 *inputPos, VecFx32 *outputPos, MtxFx44 *mtx, BOOL setFrustum)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r5, r0
	mov r8, r1
	mov r7, r2
	mov r4, r3
	bl InitStageLightConfig
	ldr r0, =g_obj
	ldr r2, [r0, #0x40]
	cmp r2, #0
	beq _020282E4
	add r0, sp, #0x18
	add r1, sp, #0x14
	blx r2
	b _020282F4
_020282E4:
	ldr r1, [r0, #0x2c]
	str r1, [sp, #0x18]
	ldr r0, [r0, #0x30]
	str r0, [sp, #0x14]
_020282F4:
	ldr r2, [r5, #0]
	ldr r1, [sp, #0x18]
	ldr r0, =g_obj
	sub r1, r2, r1
	str r1, [r8]
	ldr r2, [r5, #4]
	ldr r1, [sp, #0x14]
	sub r1, r2, r1
	rsb r1, r1, #0
	str r1, [r8, #4]
	ldr r1, [r5, #8]
	str r1, [r8, #8]
	ldrsh r1, [r0, #0xc]
	ldr r2, [r8, #0]
	add r1, r2, r1, lsl #12
	str r1, [r8]
	ldrsh r1, [r0, #0xe]
	ldr r2, [r8, #4]
	add r1, r2, r1, lsl #12
	str r1, [r8, #4]
	ldr r1, [r0, #0]
	cmp r1, #0x1000
	beq _02028374
	ldr r0, [r8, #0]
	sub r0, r0, #0x80000
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x80000
	str r0, [r8]
_02028374:
	ldr r0, =g_obj
	ldr r2, [r0, #4]
	cmp r2, #0x1000
	beq _020283B4
	mov r0, #0x60000
	ldr r1, [r8, #4]
	rsb r0, r0, #0
	sub r0, r0, r1
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x60000
	rsb r0, r0, #0
	str r0, [r8, #4]
_020283B4:
	cmp r4, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, =g_obj
	ldr r2, =FX_SinCosTable_
	ldr r6, [r0, #0x3c]
	ldrh r0, [r6, #0]
	ldr r4, [r6, #4]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r3, r1, lsl #1
	mov r1, r0, lsl #1
	ldrsh r0, [r2, r3]
	ldrsh r1, [r2, r1]
	bl FX_Div
	smull r2, r1, r0, r4
	adds r3, r2, #0x800
	ldr r0, =g_obj
	adc r2, r1, #0
	ldr r1, [r0, #0x3c]
	mov r5, r3, lsr #0xc
	ldr r0, [r6, #0xc]
	orr r5, r5, r2, lsl #20
	smull r0, r2, r5, r0
	adds r3, r0, #0x800
	ldr r0, [r6, #4]
	ldr r1, [r1, #0x28]
	adc r2, r2, #0
	mov r4, r3, lsr #0xc
	orr r4, r4, r2, lsl #20
	bl FX_Div
	ldr r1, [r8, #4]
	mov lr, #0x1000
	add r1, r1, #0x60000
	smull r2, r1, r0, r1
	adds r2, r2, #0x800
	mov r10, r2, lsr #0xc
	adc r1, r1, #0
	orr r10, r10, r1, lsl #20
	ldr r2, [r8, #0]
	mov r1, #0x80000
	str r1, [r8]
	sub r1, r1, #0xe0000
	str r1, [r8, #4]
	rsb r2, r2, #0x80000
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	ldr r8, =NNS_G3dGlb+0x00000008
	adc r0, r1, #0
	mov r9, r2, lsr #0xc
	orr r9, r9, r0, lsl #20
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	add ip, r5, r10
	sub r0, r5, r10
	ldr r5, [r6, #4]
	sub r2, r9, r4
	str r5, [sp]
	add r3, r4, r9
	ldr r4, [r6, #8]
	mov r11, #0
	stmib sp, {r4, lr}
	ldr r4, =NNS_G3dGlb+0x00000008
	str r11, [sp, #0xc]
	rsb r1, ip, #0
	str r4, [sp, #0x10]
	bl G3i_FrustumW_
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0x50
	str r1, [r0, #0xfc]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}
