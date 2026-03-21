#include <game/graphics/spritePaletteAnimation.h>

// --------------------
// VARIABLES
// --------------------

static u8 sPaletteRowRefs[16] = { 0 };

// --------------------
// FUNCTIONS
// --------------------

// sprite palette animation module... seems to be a leftover module from rush
void ReleaseSpritePalette_OLD(u16 paletteRow)
{
    if (sPaletteRowRefs[paletteRow] != 0)
        sPaletteRowRefs[paletteRow]--;
}