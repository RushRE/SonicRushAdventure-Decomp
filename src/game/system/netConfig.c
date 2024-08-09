#include <game/system/netConfig.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/system/sysEvent.h>

// DWCUtility library
#include <dwc/util/dwc_utility.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void NetConfigMain(void);
static BOOL OnCardPulledOut(void);

// --------------------
// FUNCTIONS
// --------------------

void RunNetConfig(void)
{
    // Run DWCUtil library stuff
    NetConfigMain();

    // Reset back into our engine
    UpdatePadInput();
    UpdateTouchInput();
    RequestNewSysEventChange(GetSysEventList()->prevEventID);
    NextSysEvent();
}

void NetConfigMain(void)
{
	// stop sampling touch inputs before we hand over to DWCUtil
    u8 sampleFreq = touchInput.core.sampleFreq;
    if (sampleFreq != 0)
        StopSamplingTouchInput();

	// prepare DWCUtility work
    void *work = HeapAllocHead(HEAP_USER, DWC_UTILITY_WORK_SIZE);
    CARD_SetPulledOutCallback(OnCardPulledOut);

	// start DWCUtility (twice??)
    DWC_StartUtility(work, GetGameLanguage(), DWC_UTILITY_TOP_MENU_FOR_JPN);
    DWC_StartUtility(work, GetGameLanguage(), DWC_UTILITY_TOP_MENU_COMMON);

	// cleanup DWCUtility stuff
    CARD_SetPulledOutCallback(NULL);
    HeapFree(HEAP_USER, work);
    OS_EnableIrq();

	// if we were sampling before, restart our sampling
    if (sampleFreq != 0)
        ResetTouchInput();

	// reset brightness
    GX_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);
    GXS_SetMasterBrightness(RENDERCORE_BRIGHTNESS_WHITE);
    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE;

	// reset displays
    GX_DispOn();
    GXS_DispOn();
}

BOOL OnCardPulledOut(void)
{
    RenderCore_StopAllDMAs();

    return TRUE;
}
