#include <game/graphics/screenUnknown.h>

// --------------------
// VARIABLES
// --------------------

u8 paletteRowRefs[16] = { 0 };

// --------------------
// FUNCTIONS
// --------------------

// functionality currently unknown... seems to be a leftover module from rush
void ReleaseScreenUnknown(u16 paletteRow)
{
    if (paletteRowRefs[paletteRow] != 0)
        paletteRowRefs[paletteRow]--;
}