
#include <game/stage/demoSystem.h>
#include <game/game/gameState.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTIONS
// --------------------

void InitDemoEvent(void)
{
    if ((gameState.titleDemoID & 1) != 0)
    {
        gameState.sailUnknownFlags |= 1;
        RequestSysEventChange(1); // SYSEVENT_SAILING
    }
    else
    {
        RequestSysEventChange(0); // SYSEVENT_ZONE_DEMO
    }

    gameState.titleDemoID++;

    NextSysEvent();
}