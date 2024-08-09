#include <global.h>
#include <game/system/system.h>
#include <game/graphics/renderCore.h>

// --------------------
// EXTERNS
// --------------------

extern u32 systemFrameCounter;

// User
extern void InitGameState(void);

// --------------------
// FUNCTIONS
// --------------------

void NitroMain(void)
{
    InitSystems();
    InitGameState();
    
    while (TRUE)
    {
        systemFrameCounter++;

        UpdateGameLoop();
        RenderCore_WaitVBlank();
        UnknownSystemHandler();
        UpdateDrawLoop();
    }
}