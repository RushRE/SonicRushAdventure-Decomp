#ifndef RUSH2_PLAYERNAMEMENU_H
#define RUSH2_PLAYERNAMEMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>
#include <game/graphics/unknown2056570.h>
#include <game/text/fontWindow.h>
#include <game/save/saveGame.h>

// --------------------
// STRUCTS
// --------------------

typedef struct PlayerNameMenu_
{
    FontWindow fontWindow;
    void *fntAll;
} PlayerNameMenu;

// --------------------
// FUNCTIONS
// --------------------

void CreatePlayerNameMenu(void);

#endif // RUSH2_PLAYERNAMEMENU_H