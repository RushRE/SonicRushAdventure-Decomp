
#ifndef RUSH_FONTANIMATORCORE_H
#define RUSH_FONTANIMATORCORE_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

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

#ifdef __cplusplus
}
#endif

#endif // RUSH_FONTANIMATORCORE_H
