#include <stage/player/playerSpawn.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>

// --------------------
// FUNCTIONS
// --------------------

GameObjectTask *CreatePlayerSpawn(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if ((gameState.gameFlag & GAME_FLAG_PLAYER_RESPAWNED) == 0)
    {
        if (gameState.gameMode != GAMEMODE_DEMO || (playerGameStatus.spawnPosition.x == 0 && playerGameStatus.spawnPosition.y == 0))
        {
            playerGameStatus.spawnPosition.x = x;
            playerGameStatus.spawnPosition.y = y + FLOAT_TO_FX32(3.0);
        }
    }

    DestroyMapObject(mapObject);
    return NULL;
}