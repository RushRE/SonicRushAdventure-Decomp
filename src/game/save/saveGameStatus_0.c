#include <game/save/saveGame.h>

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code16.h>

size_t SaveGame__GetPlayerNameLength(SaveBlockSystem *work)
{
    size_t len = 0;
    while ((work->name.text[len] != 0))
    {
        len++;

        if (len >= SAVEGAME_MAX_NAME_LEN)
            break;
    }

    return len;
}

#include <nitro/codereset.h>