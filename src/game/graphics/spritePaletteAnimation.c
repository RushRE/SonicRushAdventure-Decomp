#include <game/graphics/spritePaletteAnimation.h>

// --------------------
// VARIABLES
// --------------------

u8 paletteRowRefs[16] = { 0 };

// --------------------
// FUNCTIONS
// --------------------

// sprite palette animation module... seems to be a leftover module from rush
void ReleaseSpritePalette_OLD(u16 paletteRow)
{
    if (paletteRowRefs[paletteRow] != 0)
        paletteRowRefs[paletteRow]--;
}