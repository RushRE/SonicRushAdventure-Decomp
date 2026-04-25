#include <contest/contestManager.h>
#include <game/graphics/renderCore.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTIONS
// --------------------

void InitDownloadPlayUnknownEvent(void)
{
    RenderCore_DisableSoftReset(TRUE);
    RenderCore_SetNextFoldMode(FOLD_TOGGLE_POWER);
    
    RequestSysEventChange(0);
    NextSysEvent();
}