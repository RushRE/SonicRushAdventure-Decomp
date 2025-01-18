
#ifndef RUSH_FONTANIMATORCORE_H
#define RUSH_FONTANIMATORCORE_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FontAnimatorCore_
{
    u32 type;
    void *font;
} FontAnimatorCore;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontAnimatorCore__Func_20583E8(void);
NOT_DECOMPILED void FontAnimatorCore__Func_20583F0(void);
NOT_DECOMPILED void FontAnimatorCore__Init(void);
NOT_DECOMPILED void FontAnimatorCore__LoadFont(void);
NOT_DECOMPILED void FontAnimatorCore__Release(void);

#endif // RUSH_FONTANIMATORCORE_H
