
#include <game/network/wirelessManager.h>

// --------------------
// VARIABLES
// --------------------

// Split out into a separate file to enforce matching link order
u16 sWirelessManagerUserGameInfo[56] ATTRIBUTE_ALIGN(32);
s32 sWirelessManagerUnknownBuffer[144] ATTRIBUTE_ALIGN(32);
s32 sWirelessManagerSendBuffer[128] ATTRIBUTE_ALIGN(32);