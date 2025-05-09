#ifndef RUSH_SPRITEPALETTEANIMATION_H
#define RUSH_SPRITEPALETTEANIMATION_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SpritePaletteAnimationFrame_
{
    u16 animID;
    u8 duration;
    u8 flags;
} SpritePaletteAnimationFrame;

typedef struct SpritePaletteAnimation_
{
    void *spriteFile;
    u16 paletteRow;
    u16 eventID;
    u16 flags;
    u16 timer;
    SpritePaletteAnimationFrame *frames;
} SpritePaletteAnimation;

// --------------------
// FUNCTIONS
// --------------------

void ReleaseSpritePalette_OLD(u16 paletteRow);

#endif // RUSH_SPRITEPALETTEANIMATION_H
