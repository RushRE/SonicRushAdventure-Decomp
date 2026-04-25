#include <global.h>
#include <game/system/system.h>
#include <game/graphics/renderCore.h>

// --------------------
// EXTERNS
// --------------------

extern u32 gSystemFrameCounter;

// User
extern void InitGameState(void);

// --------------------
// FUNCTIONS
// --------------------

void NitroMain(void)
{
#ifndef RUSH_CONTEST
    InitSystems();
    InitGameState();

    while (TRUE)
    {
        gSystemFrameCounter++;

        UpdateGameLoop();
        RenderCore_WaitVBlank();
        UnknownSystemHandler();
        UpdateDrawLoop();
    }
#endif
}